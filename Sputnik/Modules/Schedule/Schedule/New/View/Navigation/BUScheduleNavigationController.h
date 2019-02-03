//
//  BUScheduleNavigationController.h
//  SUAI_Navigation
//
//  Created by Виктор on 03/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@class BUScheduleNavigationController;
@protocol BUScheduleNavigationControllerControlDelegate <NSObject>
@required
- (void)navigationController:(BUScheduleNavigationController *)navVC didChangeWeekTypeControl:(NSUInteger)index;

@end

@interface BUScheduleNavigationController: BURootNavigationController

@property (nonatomic, assign) BOOL controlVisible;
@property (nonatomic, assign) NSUInteger weekIndex;
@property (nonatomic, weak) id<BUScheduleNavigationControllerControlDelegate> controlDelegate;

- (void)setDate:(NSString *)date andWeek:(NSString *)week;

@end

NS_ASSUME_NONNULL_END
