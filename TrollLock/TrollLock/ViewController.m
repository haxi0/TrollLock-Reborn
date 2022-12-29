//
//  ViewController.m
//  POCTester
//
//  Created by Анохин Юрий on 20.12.2022.
//

#import "ViewController.h"
#import "TrollPrepare.h"
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
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please enter the URL to .zip" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"URL to .zip";
            }];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"lock@3x-d73.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(true, [[alertController textFields][0] text], @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-d73.ca/main.caml");
            }];
            UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"lock@3x-896h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(true, [[alertController textFields][0] text], @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml");
            }];
            UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"lock@3x-812h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(true, [[alertController textFields][0] text], @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml");
            }];
            UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"lock@2x-896h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(true, [[alertController textFields][0] text], @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml");
            }];
            UIAlertAction *fifthAction = [UIAlertAction actionWithTitle:@"lock@2x-812h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(true, [[alertController textFields][0] text], @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-812h.ca/main.caml");
            }];
            [alertController addAction:firstAction];
            [alertController addAction:secondAction];
            [alertController addAction:thirdAction];
            [alertController addAction:fourthAction];
            [alertController addAction:fifthAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select a folder"
                                                                           message:@"Each one is different for all devices. Try all of them and if you don't succeed, join my Discord server for support."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"lock@3x-d73.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(false, @"", @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-d73.ca/main.caml");
            }];
            UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"lock@3x-896h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(false, @"", @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-896h.ca/main.caml");
            }];
            UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"lock@3x-812h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(false, @"", @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@3x-812h.ca/main.caml");
            }];
            UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"lock@2x-896h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(false, @"", @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-896h.ca/main.caml");
            }];
            UIAlertAction *fifthAction = [UIAlertAction actionWithTitle:@"lock@2x-812h.ca" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self->_Active.hidden = false;
                self->_Warning.hidden = false;
                trollPrepare(false, @"", @"/System/Library/PrivateFrameworks/SpringBoardUIServices.framework/lock@2x-812h.ca/main.caml");
            }];
            [alertController addAction:firstAction];
            [alertController addAction:secondAction];
            [alertController addAction:thirdAction];
            [alertController addAction:fourthAction];
            [alertController addAction:fifthAction];
            [self presentViewController:alertController animated:YES completion:nil];
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
                                                          style:UIAlertActionStyleCancel handler:nil];
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
                                                          style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Visit the Discord Server"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [application openURL:URL options:@{} completionHandler:nil];
    }];
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"ZipArchive Project"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [application openURL:URL2 options:@{} completionHandler:nil];
    }];
    UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"MacDirtyCow Exploit"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [application openURL:URL3 options:@{} completionHandler:nil];
    }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    [alert addAction:fourthAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
