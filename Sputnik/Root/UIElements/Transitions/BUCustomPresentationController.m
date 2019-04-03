//
//  BUCustomPresentationController.m
//  CustomTransition
//
//  Created by Виктор on 23/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "BUCustomPresentationController.h"
#import "BUPercentDriver.h"
#import "BUScrollViewDetector.h"
#import "BUScrollViewUpdater.h"

CGFloat const kDelimeter = 6.;

@interface BUCustomPresentationController()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) UIView *blurView;
@property (strong, nonatomic) BUPercentDriver *driver;
@property (strong, nonatomic) BUScrollViewUpdater *scrollUpdater;

@end

@implementation BUCustomPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _blurView = [[UIView alloc] init];
        _blurView.tag = 2;
        _blurView.backgroundColor = [UIColor blackColor];
        _blurView.alpha = .0f;
    }
    return self;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGRect containerBounds = self.containerView.bounds;
    CGFloat yOffset = containerBounds.size.height / kDelimeter;
    return CGRectMake(0, yOffset, containerBounds.size.width, containerBounds.size.height - yOffset);
}

- (void)presentationTransitionWillBegin {
    _blurView.frame = self.containerView.frame;
    [self.containerView addSubview:_blurView];
    [self roundCorners];
}

- (void)dismissalTransitionWillBegin {
    [self.containerView endEditing:YES];
}

- (void)roundCorners {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.presentedView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.f, 10.f)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.presentedView.bounds;
    layer.path = path.CGPath;
    self.presentedView.layer.mask = layer;
    self.presentedView.layer.masksToBounds = YES;
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    _panGesture.delegate = self;
    _panGesture.cancelsTouchesInView = NO;
    _panGesture.maximumNumberOfTouches = 1;
    [self.presentedViewController.view addGestureRecognizer:_panGesture];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPresentedViewController)];
    [_blurView addGestureRecognizer:tap];
}

- (void)dismissPresentedViewController {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    if (![pan isEqual:_panGesture])
        return;
    
    switch ([pan state]) {
        case UIGestureRecognizerStateBegan: {
            BUScrollViewDetector *detector = [[BUScrollViewDetector alloc] initWithPresentedViewController:self.presentedViewController];
            UIScrollView *scrollView = [detector scrollView];
            if (![scrollView isEqual:nil]) {
                _scrollUpdater = [[BUScrollViewUpdater alloc] initWithRootView:self.presentedViewController.view andScrollView:scrollView];
            }
            [pan setTranslation:CGPointZero inView:self.containerView];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            if (_scrollUpdater != nil && _scrollUpdater.shouldDissmiss) {
                CGPoint translation = [pan translationInView:self.presentedView];
                [self updateViewForTranslation:translation.y];
            } else {
                [pan setTranslation:CGPointZero inView:self.presentedView];
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            __weak typeof(self) welf = self;
            [UIView animateWithDuration:0.25 animations:^{
                [welf.presentedView setTransform:CGAffineTransformIdentity];
            }];
            _scrollUpdater = nil;
            break;
        }
        default:
            break;
    }
}

- (void)updateViewForTranslation:(CGFloat)translation {
    CGFloat translationFactor = 0.5;
    CGFloat dismissThreshold = 150;
    if (translation > 0) {
        CGFloat translationModal = translationFactor * translation;
        [self.presentedView setTransform:CGAffineTransformMakeTranslation(0.0, translationModal)];
        if (translation > dismissThreshold)
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.presentedView setTransform:CGAffineTransformIdentity];
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_blurView removeFromSuperview];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isEqual:_panGesture];
}

@end
