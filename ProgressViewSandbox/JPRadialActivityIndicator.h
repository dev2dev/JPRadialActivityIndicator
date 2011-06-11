//
//  JPRadialActivityIndicator.h
//  ProgressViewSandbox
//
//  Created by Joe on 5/24/11.
//

#import <UIKit/UIKit.h>

@interface JPRadialActivityIndicator : UIView {
    UIColor *backingColor;
	UIColor *highlightColor;
	
	BOOL active;
	BOOL hidesWhenStopped;
	
	NSTimer *_spinTimer;
}

@property (nonatomic, retain) UIColor *backingColor, *highlightColor;
@property (nonatomic, assign) BOOL active, hidesWhenStopped;
@property (nonatomic, retain) NSTimer *_spinTimer;

- (void) startAnimating;
- (void) stopAnimating;
- (BOOL) isAnimating;

- (void) timerIncremented:(NSTimer *) theTimer;

@end
