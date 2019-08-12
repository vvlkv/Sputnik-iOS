//
//  BUScrollViewUpdater.h
//  CustomTransition
//
//  Created by Виктор on 26/03/2019.
//  Copyright © 2019 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIView;
@class UIScrollView;
@interface BUScrollViewUpdater : NSObject

@property (assign, nonatomic) BOOL shouldDissmiss;

- (instancetype)initWithRootView:(UIView *)root andScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
