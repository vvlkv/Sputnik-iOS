//
//  BUScrollViewDetector.h
//  CustomTransition
//
//  Created by Виктор on 26/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;
@class UIScrollView;
@interface BUScrollViewDetector : NSObject

@property (readonly, nonatomic) UIScrollView *scrollView;

- (instancetype)initWithPresentedViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
