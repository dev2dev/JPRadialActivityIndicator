//
//  ProgressViewSandboxViewController.m
//  ProgressViewSandbox
//
//  Created by Joe on 5/24/11.
//  Copyright 2011 IdiogenicOsmoles & PasquaLabs. All rights reserved.
//

#import "ProgressViewSandboxViewController.h"

@implementation ProgressViewSandboxViewController

@synthesize radialProgress;
@synthesize activityIndicator;
@synthesize timer;

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

- (IBAction) toggleActivityIndicator:(id) sender {
	self.activityIndicator.frame = CGRectMake(360, 80, 120, 120);
	self.activityIndicator.active = !activityIndicator.active;
}

#pragma mark - Memory management

- (void)dealloc
{
	[radialProgress release], radialProgress = nil;
	[activityIndicator release], activityIndicator = nil;
	[timer invalidate], [timer release], timer = nil;
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
	self.radialProgress = [[JPRadialProgressView alloc] initWithFrame:CGRectMake(80, 80, 120, 120)];
	[self.view addSubview:radialProgress];
	
	self.activityIndicator = [[JPRadialActivityIndicator alloc] initWithFrame:CGRectMake(360, 80, 120, 120)];
	[self.view addSubview:activityIndicator];
	[activityIndicator startAnimating];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
