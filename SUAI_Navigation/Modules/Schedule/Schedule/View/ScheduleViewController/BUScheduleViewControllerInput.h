//
//  BUScheduleViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUScheduleViewControllerInput <NSObject>

@required
- (void)obtainStartScheduleScreen:(NSUInteger)index;
- (void)loadScheduleView;
- (void)update;
- (void)updateWeekSegmentWithIndex:(NSUInteger)index;
- (void)addAlertViewWithItems:(NSArray *)items;

@optional
- (void)loadFailView;
- (void)updateDate:(NSString *)date andWeek:(NSString *)week;
- (void)showSearchIcon;
- (void)hideSearchIcon;
- (void)showNewScheduleAlert;

@end
