//
//  JPRadialActivityIndicator.h
//  ProgressViewSandbox
//
//  Created by Joe on 5/24/11.
//  Copyright 2011 IdiogenicOsmoles & PasquaLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityIndicator.h"

@interface JPRadialActivityIndicator : ActivityIndicator {
    UIColor *backingColor;
	UIColor *highlightColor;
	
	BOOL active;
	BOOL hidesWhenStopped;
	
	NSTimer *_spinTimer;
	CGFloat _angle;
}

@property (nonatomic, retain) UIColor *backingColor, *highlightColor;
@property (nonatomic, assign) BOOL active, hidesWhenStopped;
@property (nonatomic, retain) NSTimer *_spinTimer;
@property (nonatomic, assign) CGFloat _angle;

- (void) startAnimating;
- (void) stopAnimating;
- (BOOL) isAnimating;

- (void) timerIncremented:(NSTimer *) theTimer;

@end
