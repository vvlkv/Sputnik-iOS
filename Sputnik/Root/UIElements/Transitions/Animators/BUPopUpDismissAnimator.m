//
//  BUPopUpDismissAnumator.m
//  CustomTransition
//
//  Created by Виктор on 23/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "BUPopUpDismissAnimator.h"

@implementation BUPopUpDismissAnimator

- (instancetype)initWithDriver:(BUPercentDriver *)driver {
    self = [super init];
    if (self) {
        _driver = driver;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([toViewController isEqual:nil])
        return;
    
    UIView *containerView = transitionContext.containerView;
    CGRect offscreenFrame = CGRectMake(0, containerView.bounds.size.height, containerView.frame.size.width, toViewController.view.frame.size.height);
    
    UIView *blurView = nil;
    for (UIView *view in [containerView subviews]) {
        if ([view tag] == 2) {
            blurView = view;
        }
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         toViewController.view.frame = offscreenFrame;
                         if (![blurView isEqual:nil])
                             blurView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

@end
