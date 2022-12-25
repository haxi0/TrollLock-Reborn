//
//  ViewController.m
//  POCTester
//
//  Created by Анохин Юрий on 20.12.2022.
//

#import "ViewController.h"
#import "poc.h"
#import <ZipArchive.h>

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)go:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                   message:@"You need to do some steps before pressing this button, get the instruction on my Discord server. If you had already done those steps, go ahead and press the top button."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Let's do this!"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Choose one of the folders"
                                                                       message:@"Multiple folders named lock were found, it depends on your device which is yours. Try a few, and if you still don't manage to find the correct folder contact for support on my Discord server."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"lock@3x-d73.ca"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Active.hidden = false;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc73();
            });
        }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"lock@3x-896h.ca"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Active.hidden = false;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc896();
            });
        }];
        UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"lock@3x-812h.ca"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Active.hidden = false;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc812();
            });
        }];
        UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"lock@2x-896h.ca"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Active.hidden = false;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc2x896();
            });
        }];
        UIAlertAction *fifthAction = [UIAlertAction actionWithTitle:@"lock@2x-812h.ca"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Active.hidden = false;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc2x812();
            });
        }];
        
        [alert addAction:firstAction];
        [alert addAction:secondAction];
        [alert addAction:thirdAction];
        [alert addAction:fourthAction];
        [alert addAction:fifthAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Create folder, TrollStore only"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"TrollLock" ofType:@"zip"];
        [SSZipArchive unzipFileAtPath:filepath toDestination:@"/var/mobile/Media"];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Done"
                                       message:@"Now there should be a folder in /var/mobile/Media called TrollLock. If there isn't, try the iMazing method."
                                       preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* firstAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel
           handler:^(UIAlertAction * action) {}];

        [alert addAction:firstAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Respring"
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
    UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:firstAction];
    [alert addAction:fourthAction];
    
    if (SYSTEM_VERSION_LESS_THAN(@"16.1")) {
        [alert addAction:thirdAction];
    }
    
    if (SYSTEM_VERSION_LESS_THAN(@"15.5")) {
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
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:fullversion
                                                                   message:@"Made with ♡ by Nathan & haxi0"
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
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}




@end
