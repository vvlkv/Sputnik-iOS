//
//  BUPopUpAnimationController.m
//  CustomTransition
//
//  Created by Виктор on 23/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "BUPopUpPresentAnimator.h"

@implementation BUPopUpPresentAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([toViewController isEqual:nil])
        return;
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toViewController.view];
    
    toViewController.view.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, containerView.bounds.size.height);
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect intermediateFrame = (CGRect) { finalFrame.origin, finalFrame.size.width, finalFrame.size.height + 50};
    UIView *blurView = nil;
    for (UIView *view in [containerView subviews]) {
        if ([view tag] == 2) {
            blurView = view;
        }
    }
    //.8 .7
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:.7 initialSpringVelocity:.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        toViewController.view.frame = intermediateFrame;
        if (![blurView isEqual:nil])
            blurView.alpha = .4;
    } completion:^(BOOL finished) {
        toViewController.view.frame = finalFrame;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
