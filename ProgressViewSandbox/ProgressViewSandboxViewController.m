//
//  ProgressViewSandboxViewController.m
//  ProgressViewSandbox
//
//  Created by Joe on 5/24/11.
//  Copyright 2011 IdiogenicOsmoles & PasquaLabs. All rights reserved.
//

#import "ProgressViewSandboxViewController.h"
#import "UIColor+RandomColor.h"

@implementation ProgressViewSandboxViewController

@synthesize radialProgress;
@synthesize activityIndicator;
@synthesize timer;
@synthesize pinchGesture;

#pragma mark - JPRadialProgressView

- (void) incrementRadialProgress:(NSTimer *) activeTimer {
	if (radialProgress.progress < 1.0) {
		CGFloat increment = 0.001;
		self.radialProgress.progress += increment;
	} else {
		[activeTimer invalidate];
		[radialProgress setProgress:0.0];
		self.timer = nil;
	}
}


#pragma mark - UI

- (IBAction) startRadialProgressTimer {
	if (timer == nil)
		self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(incrementRadialProgress:) userInfo:nil repeats:YES];
	else
		NSLog(@"There is already a timer running");
}

- (IBAction) randomizeColors:(id) sender {
	self.activityIndicator.highlightColor = [UIColor randomColor];
	self.activityIndicator.backingColor = [UIColor randomColor];
	
	self.radialProgress.emptyColor = [UIColor randomColor];
	self.radialProgress.fillColor = [UIColor randomColor];
}

- (IBAction) toggleActivityIndicator:(id) sender {
	self.activityIndicator.active = !activityIndicator.active;
}

#pragma mark - UIPinchGestureRecognizer

- (void) pinched:(UIPinchGestureRecognizer *) pinchGestureRecognizer {
	CGFloat scale = pinchGestureRecognizer.scale;
	CGFloat newHeight = defaultSize.height * scale;
	CGFloat newWidth = defaultSize.width * scale;
	CGSize newSize = CGSizeMake(newWidth, newHeight);
	
	CGRect radialProgressFrame = radialProgress.frame;
	radialProgress.frame = (CGRect) {radialProgressFrame.origin, newSize};
	[radialProgress setNeedsDisplay];
	
	if (![activityIndicator isAnimating]) {
		CGRect activityIndicatorFrame = activityIndicator.frame;
		activityIndicator.frame = (CGRect) {activityIndicatorFrame.origin, newSize};
		[activityIndicator setNeedsDisplay];
	} else
		NSLog(@"If the activity indicator is active, it'll fly off screen upon resizing. This is undesirable.");
}

#pragma mark - Memory management

- (void)dealloc
{
	[radialProgress release], radialProgress = nil;
	[activityIndicator release], activityIndicator = nil;
	[timer invalidate], [timer release], timer = nil;
	[pinchGesture release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	defaultSize = (CGSize){120, 120};
	
	self.radialProgress = [[JPRadialProgressView alloc] initWithFrame:(CGRect){80, 80, defaultSize}];
	[self.view addSubview:radialProgress];
	
	self.activityIndicator = [[JPRadialActivityIndicator alloc] initWithFrame:(CGRect){360, 80, defaultSize}];
	[self.view addSubview:activityIndicator];
	activityIndicator.hidesWhenStopped = NO;
	[activityIndicator startAnimating];
	
	self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)];
	[self.view addGestureRecognizer:pinchGesture];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
	[self.view removeGestureRecognizer:pinchGesture];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
