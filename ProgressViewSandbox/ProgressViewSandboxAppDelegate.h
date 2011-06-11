//
//  ProgressViewSandboxAppDelegate.h
//  ProgressViewSandbox
//
//  Created by Joe on 5/24/11.
//

#import <UIKit/UIKit.h>

@class ProgressViewSandboxViewController;

@interface ProgressViewSandboxAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ProgressViewSandboxViewController *viewController;

@end
