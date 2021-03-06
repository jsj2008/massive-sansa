//
//  IDPTaskProvider.h
//  TouchMenus
//
//  Created by Steffen Bauereiss on 15.02.13.
//  Copyright (c) 2013 TUM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuItem.h"

@protocol MenuCandidate <NSObject>
- (void) resetMenu;
	//resets all menu-structure to default;
@end

@protocol ExperimentController <NSObject>

- (void) unlock;
- (UIViewController *) createViewControllerOfName:(NSString *)viewControllerName andLock:(BOOL)lock;
- (void) setTaskMessage:(NSString *)message;
- (void) didFinish;
- (void) didFinishExperiment;
- (void) didFinishTask;
- (UIViewController *) tellMe;

@end

@interface IDPTaskProvider : NSObject <UIAlertViewDelegate>

@property id<ExperimentController> experimentControllerDelegate;
@property id<MenuCandidate> currentMenu;

- (void)loadExerciseSet:(NSInteger *)val;

//singleton
+ (IDPTaskProvider *) sharedInstance;

//start/stop
- (void) prepareNextExperiment;
- (void) startNextExperiment;

//collect all MenuItem clicks
- (void) selectItem:(MenuItem *)item;


//further logging
- (void) backButtonClicked;
- (void) breadCrumbClickedToTargetItem:(MenuItem *)item;
- (void) breadCrumbClickedToTarget:(NSString *)itemTitle;
- (void) swipeRecognizedFrom:(CGPoint)from to:(CGPoint)to;
- (void) swipeRecognizedInDirection:(UISwipeGestureRecognizerDirection)direction;
- (void) clickedOutside;
- (void) otherActionPerformed:(NSString *)action withDescription:(NSString *)description;

@end
