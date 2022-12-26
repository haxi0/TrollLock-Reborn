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
            self->_Warning.hidden = false;
            self->_Active.hidden = false;
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
                    
                    //saving is done on main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [urlData writeToFile:filePath atomically:YES];
                        [fileContents writeToFile:filePath atomically:YES];
                        NSLog(@"File Saved !");
                    });
                }
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc73();
            });
        }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"lock@3x-896h.ca"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Warning.hidden = false;
            self->_Active.hidden = false;
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
                    
                    //saving is done on main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [urlData writeToFile:filePath atomically:YES];
                        [fileContents writeToFile:filePath atomically:YES];
                        NSLog(@"File Saved !");
                    });
                }
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc896();
            });
        }];
        UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"lock@3x-812h.ca"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Warning.hidden = false;
            self->_Active.hidden = false;
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
                    
                    //saving is done on main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [urlData writeToFile:filePath atomically:YES];
                        [fileContents writeToFile:filePath atomically:YES];
                        NSLog(@"yay! success");
                    });
                }
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc812();
            });
        }];
        UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"lock@2x-896h.ca"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Warning.hidden = false;
            self->_Active.hidden = false;
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
                    
                    //saving is done on main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [urlData writeToFile:filePath atomically:YES];
                        [fileContents writeToFile:filePath atomically:YES];
                        NSLog(@"File Saved !");
                    });
                }
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                poc2x896();
            });
        }];
        UIAlertAction *fifthAction = [UIAlertAction actionWithTitle:@"lock@2x-812h.ca"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self->_Warning.hidden = false;
            self->_Active.hidden = false;
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
                    
                    //saving is done on main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [urlData writeToFile:filePath atomically:YES];
                        [fileContents writeToFile:filePath atomically:YES];
                        NSLog(@"File Saved !");
                    });
                }
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
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
    
    if (SYSTEM_VERSION_LESS_THAN(@"16.1")) {
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
