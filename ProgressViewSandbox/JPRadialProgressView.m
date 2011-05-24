//
//  JPRadialProgressView.m
//  JPRadialProgress
//
//  Created by Joe on 12/1/10.
//  Copyright 2010 IdiogenicOsmoles. All rights reserved.
//

#import "JPRadialProgressView.h"

//static inline double radians (double degrees) {return degrees * M_PI/180;}
#define DEG2RAD(x) (0.0174532925 * (x))

#define debug_rect( arg ) NSLog( @"CGRect ( %f, %f, %f, %f)", arg.origin.x, arg.origin.y, arg.size.width, arg.size.height )
//#define NEGATIVE_NINETY_DEGREES radians(-90)

@implementation JPRadialProgressView

@synthesize emptyColor, fillColor;

/* Courtesy of Navel Labs */
// http://navel-labs.com/

void NLDrawPieChartProgressGraph(CGContextRef context, CGPoint center, CGFloat radius, CGFloat percentComplete) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, center.x, center.y);
	//Changed the ending radian multiplier from 359 to 359.9. I feel that one degree less allows a tiny sliver to show.
	//If 360 was used, then it would effectively be zero, so 359.9 is much closer to a true 360° than 359.
    CGPathAddArc(path, NULL, center.x, center.y, radius, DEG2RAD(270), DEG2RAD((percentComplete*359.9)-90), NO);
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGPathRelease(path);    
    
	//I ignore this, it's not my style. :)
	//Add a stroke around the drawn path
    //CGContextStrokeEllipseInRect(context, CGRectMake(center.x - radius, center.y - radius, radius*2, radius*2));
}


//So, the first line is a quick and dirty macro to make the degree to radian conversion a little more clear. Then the function just draws a path in the given context with core graphics methods. Whatever color you've set as the fill is the color of the pie chart. Here's an example of how you could use this in a UIView's drawRect:

- (void) drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGPoint centerPoint = CGPointMake(rect.size.height / 2, rect.size.width / 2);
	CGFloat radius = rect.size.height / 2; //Set the radius to half the height.
	
	//Draw the empty state of the radial progress view
	[emptyColor setFill];
	NLDrawPieChartProgressGraph(context, centerPoint, radius, 0);
	
	//Only draw if the progress is within 1.0 and 0.0
	if (progress > 0.0) { //Restrict the bounds of the circle to not draw if angle is negative.
		[fillColor setFill];
		NLDrawPieChartProgressGraph(context, centerPoint, radius, progress);
	}
	
	//"Erase" from current context
	CGContextSetBlendMode(context, kCGBlendModeClear);;
	
	//Erase a circle smaller than the last one to 'punch out' a hole using a magic number of 1.5 times the radius as the size of the erased circle.
	CGFloat innerRadius = radius * 1.5;
	CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius /2, centerPoint.y - innerRadius/2); //Center it based on the last circle
	
	CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius, innerRadius));
	CGContextFillPath(context);
	
	//End drawing!
}

- (void) setProgress:(float) newProgress {
	progress = newProgress;
	[self setNeedsDisplay];
}

- (float) progress {
	return progress;
}

- (id)initWithFrame:(CGRect) newFrame {
    
    self = [super initWithFrame:newFrame];
    if (self) {
		self.emptyColor = [UIColor blackColor];
		self.fillColor = [UIColor whiteColor];
		self.backgroundColor = [UIColor clearColor];
		self.progress = 0.0;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setOpaque:NO];
		[self setUserInteractionEnabled:NO];
		self.emptyColor = [UIColor colorWithRed:0.345 green:0.275 blue:0.275 alpha:1.000];
		self.fillColor = [UIColor yellowColor];
		if ([aDecoder decodeObjectForKey:@"emptyColor"]) {
			self.emptyColor = [aDecoder decodeObjectForKey:@"emptyColor"];
		}
		if ([aDecoder decodeObjectForKey:@"fillColor"]) {
			self.fillColor = [aDecoder decodeObjectForKey:@"fillColor"];
		}
		self.progress = [aDecoder decodeFloatForKey:@"progress"];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:emptyColor forKey:@"emptyColor"];
	[encoder encodeObject:fillColor forKey:@"fillColor"];
	[encoder encodeFloat:progress forKey:@"progress"];
}

- (void)dealloc {
	[fillColor release];
	[emptyColor release];
	progress = 0.0;
    [super dealloc];
}

@end

