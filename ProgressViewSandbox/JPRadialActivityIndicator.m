//
//  JPRadialActivityIndicator.m
//  ProgressViewSandbox
//
//  Created by Joe on 5/24/11.
//  Copyright 2011 IdiogenicOsmoles & PasquaLabs. All rights reserved.
//

#import "JPRadialActivityIndicator.h"


@interface UIColor (RGBBlackAndWhite)
+ (UIColor *) RGBWhiteColor;
+ (UIColor *) RGBBlackColor;
@end


@implementation UIColor (RGBBlackAndWhite)
+ (UIColor *) RGBWhiteColor {
	return [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

+ (UIColor *) RGBBlackColor {
	return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
}
@end



@implementation JPRadialActivityIndicator

@synthesize backingColor, highlightColor;
@synthesize active, hidesWhenStopped;
@synthesize _spinTimer;

#define DEG2RAD(x) (0.0174532925 * (x))
//As declared in JPRadialProgressView, but restated to have less dependence on other classes

#pragma mark - UI
- (void) startAnimating {
	self.active = YES;
}

- (void) stopAnimating {
	self.active = NO;
}

- (BOOL) isAnimating {
	//Hmmm...
	return active;
}

- (void) setActive:(BOOL) newActive {
	active = newActive;
	if (newActive == YES) {
		if (_spinTimer == nil)
			_spinTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerIncremented:) userInfo:nil repeats:YES];
//		else
//			There is already a spin timer active, don't make another
	} else {
		[_spinTimer invalidate];
		_spinTimer = nil;
		self.transform = CGAffineTransformRotate(self.transform, DEG2RAD(0));
	}
}

#pragma mark Color

- (void) setBackingColor:(UIColor *)newBackingColor {
	[backingColor release];
	
	if (newBackingColor == [UIColor whiteColor])
		backingColor = [[UIColor RGBWhiteColor] retain];
	else if (newBackingColor == [UIColor blackColor])
		backingColor = [[UIColor RGBBlackColor] retain];
	else
		backingColor = [newBackingColor retain];
	
	[self setNeedsDisplay];
}

- (void) setHighlightColor:(UIColor *)newHighlightColor {
	[highlightColor release];
	
	if (newHighlightColor == [UIColor whiteColor])
		highlightColor = [[UIColor RGBWhiteColor] retain];
	else if (newHighlightColor == [UIColor blackColor])
		highlightColor = [[UIColor RGBBlackColor] retain];
	else
		highlightColor = [newHighlightColor retain];
	
	[self setNeedsDisplay];
}


#pragma mark initializer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backingColor = [UIColor greenColor];
		self.highlightColor = [UIColor blueColor];
		self.active = NO;
		self.hidesWhenStopped = YES;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void) timerIncremented:(NSTimer *) theTimer {
	if (active == NO) {
		[theTimer invalidate];
		[_spinTimer invalidate];
		_spinTimer = nil;
	}
		
	self.transform = CGAffineTransformRotate(self.transform, DEG2RAD(7));
}

/* Courtesy of Navel Labs */
// http://navel-labs.com/

- (void)drawRect:(CGRect)rect
{
	if (active == YES || hidesWhenStopped == NO) {
		CGRect imageBounds = (CGRect){0.0f, 0.0f, 44.0f, 44.0f}; //Magic number leftover from original opacity image (ActivityIndicator.opacity), should be absolved
		CGRect bounds = [self bounds];
		
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGFloat alignStroke;
		CGFloat resolution;
		CGMutablePathRef path;
		CGRect drawRect;
		UIColor *color;
		CGFloat stroke;
		CGGradientRef gradient;
		NSMutableArray *colors;
		CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
		CGPoint point;
		CGPoint point2;
		CGFloat locations[3];
		resolution = 0.5f * (bounds.size.width / imageBounds.size.width + bounds.size.height / imageBounds.size.height);
		CGContextBeginTransparencyLayer(context, NULL);
		
		CGContextSaveGState(context);
		CGContextTranslateCTM(context, bounds.origin.x, bounds.origin.y);
		CGContextScaleCTM(context, (bounds.size.width / imageBounds.size.width), (bounds.size.height / imageBounds.size.height));
		
		// Layer 1
		
		alignStroke = 0.0f;
		path = CGPathCreateMutable();
		drawRect = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
		drawRect.origin.x = (roundf(resolution * drawRect.origin.x + alignStroke) - alignStroke) / resolution;
		drawRect.origin.y = (roundf(resolution * drawRect.origin.y + alignStroke) - alignStroke) / resolution;
		drawRect.size.width = roundf(resolution * drawRect.size.width) / resolution;
		drawRect.size.height = roundf(resolution * drawRect.size.height) / resolution;
		CGPathAddEllipseInRect(path, NULL, drawRect);
		color = [UIColor colorWithRed:0.0f green:0.502f blue:1.0f alpha:1.0f];
		[color setStroke];
		stroke = 4.75f;
		stroke *= resolution;
		if (stroke < 1.0f) {
			stroke = ceilf(stroke);
		} else {
			stroke = roundf(stroke);
		}
		stroke /= resolution;
		stroke *= 2.0f;
		CGContextSetLineWidth(context, stroke);
		CGContextSetLineCap(context, kCGLineCapSquare);
		CGContextSaveGState(context);
		CGContextAddPath(context, path);
		CGContextEOClip(context);
		CGContextAddPath(context, path);
		CGContextStrokePath(context);
		CGContextRestoreGState(context);
		CGPathRelease(path);
		
		// Layer 2
		CGContextSetBlendMode(context, kCGBlendModeSourceIn);
		CGContextBeginTransparencyLayer(context, NULL);
		
		alignStroke = 0.0f;
		path = CGPathCreateMutable();
		drawRect = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
		drawRect.origin.x = (roundf(resolution * drawRect.origin.x + alignStroke) - alignStroke) / resolution;
		drawRect.origin.y = (roundf(resolution * drawRect.origin.y + alignStroke) - alignStroke) / resolution;
		drawRect.size.width = roundf(resolution * drawRect.size.width) / resolution;
		drawRect.size.height = roundf(resolution * drawRect.size.height) / resolution;
		CGPathAddRect(path, NULL, drawRect);
		colors = [NSMutableArray arrayWithCapacity:3];
//		color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
		color = backingColor;
		[colors addObject:(id)[color CGColor]];
		locations[0] = 1.0f;
//		color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
		color = backingColor;
		[colors addObject:(id)[color CGColor]];
		locations[1] = 0.249f;
//		color = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
		color = highlightColor;
		[colors addObject:(id)[color CGColor]];
		locations[2] = 0.095f;
		gradient = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
		CGContextAddPath(context, path);
		CGContextSaveGState(context);
		CGContextEOClip(context);
		point = CGPointMake(22.0f, 44.0f);
		point2 = CGPointMake(22.0f, 0.0f);
		CGContextDrawLinearGradient(context, gradient, point, point2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
		CGContextRestoreGState(context);
		CGGradientRelease(gradient);
		CGPathRelease(path);
		
		CGContextEndTransparencyLayer(context);
		
		CGContextRestoreGState(context);
		CGContextEndTransparencyLayer(context);
		CGColorSpaceRelease(space);
	}
}


- (void)dealloc
{
	[backingColor release];
	[highlightColor release];
	[_spinTimer release];
    [super dealloc];
}

@end
