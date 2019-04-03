//
//  BUPopUpDismissAnumator.h
//  CustomTransition
//
//  Created by Виктор on 23/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BUPercentDriver;
@interface BUPopUpDismissAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (strong, nonatomic, readonly) BUPercentDriver *driver;

- (instancetype)initWithDriver:(BUPercentDriver *)driver;

@end

NS_ASSUME_NONNULL_END
