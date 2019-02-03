//
//  BUTabBarPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 02/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUTabBarViewControllerOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUTabBarViewControllerInput;
@interface BUTabBarPresenter : NSObject <BUTabBarViewControllerOutput>

@property (weak, nonatomic) id <BUTabBarViewControllerInput> view;

@end

NS_ASSUME_NONNULL_END
