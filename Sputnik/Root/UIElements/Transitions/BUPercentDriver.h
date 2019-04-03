//
//  BUPercentDriver.h
//  CustomTransition
//
//  Created by Виктор on 23/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUPercentDriver : UIPercentDrivenInteractiveTransition

@property (assign, nonatomic) BOOL canRecognize;
@property (assign, nonatomic) BOOL hasStarted;
@property (assign, nonatomic) BOOL shouldFinish;

- (instancetype)initWithPresentedViewController:(UIViewController *_Nullable)viewController;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
