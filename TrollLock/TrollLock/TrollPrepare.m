//
//  TrollPrepare.m
//  TrollLock
//
//  Created by Apricot on 2022-12-26.
//

#import <Foundation/Foundation.h>
#import <ZipArchive.h>
#import "poc.h"

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

void trollPrepare(bool media, NSString *url, NSString *path) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *targetFilePath = [NSString stringWithFormat:@"%@/main.caml", documentsDirectory];
    
    if (media == true) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"Downloading custom .zip file");
            NSString *urlToDownload = url;
            NSURL *url = [NSURL URLWithString:urlToDownload];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            if (urlData)
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"TrollLock.zip"];
                NSLog(@"%@", filePath);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [urlData writeToFile:filePath atomically:YES];
                    [SSZipArchive unzipFileAtPath:filePath toDestination:documentsDirectory];
                    NSLog(@"Successfully downloaded custom .zip file");
                });
            }
            
        });
    }
    
    for (int i = 1; i <= 40; i++) {
        // Default troll face
        NSString *trollFileName = [NSString stringWithFormat:@"trollformation%d", i];
        NSString *trollFilePath = [[NSBundle mainBundle] pathForResource:trollFileName ofType:@"png"];
        
        if (media == true) {
            // Custom lock icon
            trollFileName = [NSString stringWithFormat:@"/trollformation%d.png", i];
            trollFilePath = [documentsDirectory stringByAppendingString:trollFileName];
        }
        
        NSString *trollReplace = [NSString stringWithFormat:@"trolling%dx", i];
        fileContents = [fileContents stringByReplacingOccurrencesOfString:trollReplace withString:trollFilePath];
    }
    
    // Log file contents for easy debugging.
    NSLog(@"%@", fileContents);
    
    // Write animation file.
    dispatch_async(dispatch_get_main_queue(), ^{
        [fileContents writeToFile:targetFilePath atomically:YES];
    });
    
    // Copy animation file to target folder.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        trollLockCopy(targetFilePath, path);
    });
}
