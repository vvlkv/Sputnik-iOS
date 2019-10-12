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
    return [CATransaction animationDuration];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([fromViewController isEqual:nil])
        return;
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:fromViewController];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeTranslation(0, finalFrame.size.height);
    } completion:^(BOOL finished) {
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
