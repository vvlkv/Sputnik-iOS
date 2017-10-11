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
- (void)updateView;
- (void)updateDate;
- (void)updateWeekSegmentWithIndex:(NSUInteger)index;
- (void)addAlertViewWithItems:(NSArray *)items;

@optional
- (void)showSearchIcon;
- (void)hideSearchIcon;

@end
