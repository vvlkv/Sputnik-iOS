//
//  BUPercentDriver.m
//  CustomTransition
//
//  Created by Виктор on 23/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "BUPercentDriver.h"

@interface BUPercentDriver() <UIGestureRecognizerDelegate> {
    
}

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (weak, nonatomic) UIViewController *viewController;

@end

@implementation BUPercentDriver

- (instancetype)initWithPresentedViewController:(UIViewController *_Nullable)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
        _shouldFinish = NO;
        _hasStarted = NO;
        _canRecognize = NO;
    }
    return self;
}

- (instancetype)init {
    return [self initWithPresentedViewController:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIViewController *parentViewController = [self viewControllerForScrollView:scrollView];
    if (![parentViewController isEqual:_viewController])
        return;
    CGFloat translation = -(scrollView.contentOffset.y + scrollView.contentInset.top);
    if (translation < 0.0)
        return;
    scrollView.bounces = NO;
    [self updateViewForTranslation:translation * 2];
}


#pragma mark - Private

- (void)updateViewForTranslation:(CGFloat)translation {
    CGFloat translationFactor = 0.5;
    if (translation > 0) {
        CGFloat translationModal = translationFactor * translation;
        [_viewController.view setTransform:CGAffineTransformMakeTranslation(0.0, translationModal)];
    } else {
        [_viewController.view setTransform:CGAffineTransformIdentity];
    }
}

- (UIViewController *_Nullable)viewControllerForScrollView:(UIScrollView *)scrollView {
    UIResponder *nextResponder = scrollView.nextResponder;
    while (nextResponder != nil && ![nextResponder isKindOfClass:[UIViewController class]]) {
        nextResponder = nextResponder.nextResponder;
    }
    return (UIViewController *)nextResponder;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    UIView *view = _viewController.view;
    CGPoint translation = [gesture translationInView:view];
    CGFloat verticalMove = translation.y / view.bounds.size.height;
    CGFloat downwardMove = fmaxf(verticalMove, 0.0);
    CGFloat downwardMovePercent = fminf(downwardMove, 1.0);
    CGFloat percentThreshold = 0.4f;
    
    switch ([gesture state]) {
        case UIGestureRecognizerStateBegan: {
            if (translation.y < 0) {
                break;
            }
            _hasStarted = true;
            [_viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            self.shouldFinish = downwardMovePercent > percentThreshold;
            if (self.shouldFinish) {
                self.completionSpeed = 1.f - downwardMovePercent;
                [self finishInteractiveTransition];
            } else {
                [self updateInteractiveTransition:downwardMovePercent/3];
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (self.shouldFinish) {
                self.completionSpeed = 1.f - downwardMovePercent;
                [self finishInteractiveTransition];
            } else {
                self.completionSpeed = 0.1;
                [self cancelInteractiveTransition];
            }
            _hasStarted = false;
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            _hasStarted = false;
            [self cancelInteractiveTransition];
            break;
        }
        default:
            break;
    }
}

@end
