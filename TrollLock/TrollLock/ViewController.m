//
//  ViewController.m
//  POCTester
//
//  Created by Анохин Юрий on 20.12.2022.
//

#import "ViewController.h"
#import "poc.h"
#import <sys/utsname.h>

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)go:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                   message:@"After you press the begin button, you are on your own. I don't take any risks but instead you do. If you are fine with it, go ahead then!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Begin"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSError *error = nil;
        for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error]) {
            [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
        }
        if ([self->_media isOn]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please enter the URL for your custom .zip file" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"URL Link to .zip file";
            }];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                struct utsname systemInfo;
                uname(&systemInfo);
                NSString* code = [NSString stringWithCString:systemInfo.machine
                                                    encoding:NSUTF8StringEncoding];
                overwriteLock(code, true, [[alertController textFields][0] text]);
            }];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            self->_Active.hidden = false;
            self->_Warning.hidden = false;
            struct utsname systemInfo;
            uname(&systemInfo);
            NSString* code = [NSString stringWithCString:systemInfo.machine
                                                encoding:NSUTF8StringEncoding];
            overwriteLock(code, false, @"");
        }
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Respring"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UIApplication *sharedApplication = [UIApplication sharedApplication];
        NSArray<UIWindow *> *windows = sharedApplication.windows;
        UIWindow *window = windows.firstObject;
        if (window) {
            while (true) {
                [window snapshotViewAfterScreenUpdates:NO];
            }
        }
    }];
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:firstAction];
    [alert addAction:thirdAction];
    
    if (SYSTEM_VERSION_LESS_THAN(@"16.1.1")) {
        [alert addAction:secondAction];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)info:(id)sender {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *versionText = @"TrollLock Reborn, Version ";
    NSString *fullversion = [versionText stringByAppendingString:version];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://discord.gg/4EFEYnFb7x"];
    NSURL *URL2 = [NSURL URLWithString:@"https://github.com/ZipArchive/ZipArchive"];
    NSURL *URL3 = [NSURL URLWithString:@"https://github.com/zhuowei/MacDirtyCowDemo"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:fullversion
                                                                   message:@"Made with ♡ by Nathan & haxi0. Thanks to: zhuowei, MR X, k.y., Finny, bonnie, rxfe_, PrimePlatypus, Nightinq and apricot."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Visit the Discord Server"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Opened the Discord invite URL!");
            }
        }];
    }];
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"ZipArchive Project"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [application openURL:URL2 options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Opened the ZipArchive URL!");
            }
        }];
    }];
    UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"MacDirtyCow Exploit"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [application openURL:URL3 options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Opened the MacDirtyCow URL!");
            }
        }];
    }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    [alert addAction:fourthAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}




@end
