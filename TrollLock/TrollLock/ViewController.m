//
//  ViewController.m
//  POCTester
//
//  Created by Анохин Юрий on 20.12.2022.
//

#import "ViewController.h"
#import "poc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)go:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://discord.gg/4EFEYnFb7x"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                   message:@"You need to do some steps before pressing this button, get the instruction on my Discord server. If you had already done those steps, go ahead and press the top button."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Let's do this!"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        self->_Active.hidden = false;
        poc();
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Visit the Discord Server"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Opened the Discord invite URL!");
            }
        }];
    }];
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSLog(@"Cancelled :(");
    }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
