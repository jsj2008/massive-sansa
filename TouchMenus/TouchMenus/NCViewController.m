//
//  NCViewController.m
//  NavController
//
//  Created by Steffen Bauereiss on 10.02.13.
//  Copyright (c) 2013 Steffen Bauereiss. All rights reserved.
//

#import "NCViewController.h"
#import "NCTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NCViewController ()
{
	int pos;
}

@property (retain) UINavigationController *navController;
@property (retain) NSMutableArray *stack;

@end

@implementation NCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	
	self.stack = [[NSMutableArray alloc] init];
	
	NCTableViewController *tblv = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"NCTBLV"];
	tblv.delegate = self;
	
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:tblv];
	self.navController = nc;
	
	UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-150, self.view.bounds.size.width, 150)];
	[navView setClipsToBounds:YES];
	[navView addSubview:self.navController.view];
	
	[navView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	
	[self.navController.view setFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
	
	[self.navController.navigationBar setHidden:YES];
	
	UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [navView addGestureRecognizer:rightRecognizer];
	
	[self.view addSubview:navView];
	
}
- (IBAction)backButtonClick:(UIButton *)sender
{
	[self rightSwipeHandle];
}

- (void)rightSwipeHandle
{
	
	if ([self.navController.viewControllers count] == 1)
	{
		CGFloat offset = 100.0;
		CGFloat endposY = self.navController.view.frame.origin.y;
		[UIView animateWithDuration:.2 animations:^{
			CGRect frame = self.navController.view.frame;
			frame.origin.y = endposY + offset;
			self.navController.view.frame = frame;
		} completion:^(BOOL finished){
			[UIView animateWithDuration:.1 animations:^{
				CGRect frame = self.navController.view.frame;
				frame.origin.y = endposY;
				self.navController.view.frame = frame;
			}];
		}];
	}
	else
	{
		CATransition* transition = [CATransition animation];
		transition.duration = 0.2;
		transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		transition.type = kCATransitionMoveIn; //kCATransitionFade, kCATransitionPush, kCATransitionReveal, kCATransitionFade
		transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
		[self.navController.view.layer addAnimation:transition forKey:nil];
		[self.navController popViewControllerAnimated:NO];
		
		//breadcrumbpop
		[self breadcrumbPop];
	}
}

- (void)addToBreadCrumb:(id)tblv
{
	NCTableViewController *tblview = (NCTableViewController *)tblv;
	[self breadcrumPush:tblview];
}

- (void)breadcrumPush:(NCTableViewController *)tblv
{
	UILabel *button = [[UILabel alloc] initWithFrame:CGRectMake(pos, 300, 100, 44)];
	
	pos += 100;
	
	[button setText:[tblv.menuItem getTitle]];
	
	[self.view addSubview:button];
	[self.stack addObject:button];
	
}
- (void)breadcrumbPop
{
	UILabel *button = [self.stack lastObject];
	[button removeFromSuperview];
	
	[self.stack removeLastObject];
	pos -= 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end