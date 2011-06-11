//
//  JPRadialProgressView.h
//  JPRadialProgress
//
//  Created by Joe on 12/1/10.
//

//  The foundation of this class has been provided by Navel Labs at http://navel-labs.com. Thanks!

#import <UIKit/UIKit.h>


@interface JPRadialProgressView : UIView {
	UIColor *emptyColor;
	UIColor *fillColor;
	CGFloat progress;
}

@property (nonatomic, retain) UIColor *emptyColor, *fillColor;
@property (nonatomic) CGFloat progress;

@end
