//
//  ProgressViewSandboxViewController.h
//  ProgressViewSandbox
//
//  Created by Joe on 5/24/11.
//  Copyright 2011 IdiogenicOsmoles & PasquaLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPRadialProgressView.h"
#import "JPRadialActivityIndicator.h"

@interface ProgressViewSandboxViewController : UIViewController {
	JPRadialProgressView *radialProgress;
	JPRadialActivityIndicator *activityIndicator;
	NSTimer *timer;
	
	UIPinchGestureRecognizer *pinchGesture;
	CGSize defaultSize;
}

@property (nonatomic, retain) JPRadialProgressView *radialProgress;
@property (nonatomic, retain) JPRadialActivityIndicator *activityIndicator;
@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, retain) UIPinchGestureRecognizer *pinchGesture;

- (IBAction) startRadialProgressTimer;
- (IBAction) randomizeColors:(id) sender;
- (IBAction) toggleActivityIndicator:(id) sender;

@end
