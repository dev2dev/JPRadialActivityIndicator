//
//  UIColor+RandomColor.h
//  ProgressViewSandbox
//  One of the best classes for debugging

#import <UIKit/UIKit.h>

@interface UIColor (debug)
+ (UIColor *)randomColor;
@end


@implementation UIColor (debug)
+ (UIColor *)randomColor {
    CGFloat red = (arc4random()%256)/256.0;
    CGFloat green = (arc4random()%256)/256.0;
    CGFloat blue = (arc4random()%256)/256.0;
	
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
