//
//  BUScrollViewDetector.m
//  CustomTransition
//
//  Created by Виктор on 26/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import "BUScrollViewDetector.h"
#import <UIKit/UIKit.h>

@interface BUScrollViewDetector() {
    
}

@property (weak, nonatomic) UIViewController *presentedViewController;

@end

@implementation BUScrollViewDetector

- (instancetype)initWithPresentedViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        _presentedViewController = viewController;
    }
    return self;
}

- (UIScrollView *)scrollView {
    for (UIView *view in [_presentedViewController.view subviews]) {
        if ([view isKindOfClass:[UIScrollView class]])
            return (UIScrollView *)view;
    }
    return nil;
}

@end
