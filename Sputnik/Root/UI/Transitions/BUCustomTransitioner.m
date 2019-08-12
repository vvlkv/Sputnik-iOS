//
//  BUCustomTransitioner.m
//  CustomTransition
//
//  Created by Виктор on 23/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "BUCustomTransitioner.h"
#import "BUPopUpPresentAnimator.h"
#import "BUPopUpDismissAnimator.h"
#import "BUCustomPresentationController.h"
#import "BUPercentDriver.h"

@implementation BUCustomTransitioner

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                               presentingViewController:(nullable UIViewController *)presenting
                                                                   sourceViewController:(UIViewController *)source {
    return [[BUCustomPresentationController alloc] initWithPresentedViewController:presented
                                                          presentingViewController:presenting];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source {
    return [[BUPopUpPresentAnimator alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[BUPopUpDismissAnimator alloc] init];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if ([animator isKindOfClass:[BUPopUpDismissAnimator class]]) {
        BUPopUpDismissAnimator *popUpDismiss = (BUPopUpDismissAnimator *)animator;
        BUPercentDriver *driver = [popUpDismiss driver];
        if ([driver hasStarted]) {
            return driver;
        }
    }
    return nil;
}

@end
