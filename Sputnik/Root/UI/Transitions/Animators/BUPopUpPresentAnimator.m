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
    return [CATransaction animationDuration] * 2.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([toViewController isEqual:nil])
        return;
    
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toViewController.view];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = (CGRect){.origin = finalFrame.origin, .size.width = finalFrame.size.width, .size.height = finalFrame.size.height + 50};
    
    //.8 .7
    toViewController.view.transform = CGAffineTransformMakeTranslation(0, finalFrame.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:.7 initialSpringVelocity:.0
                        options:UIViewAnimationOptionCurveEaseIn animations:^{
                            toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        toViewController.view.frame = finalFrame;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
