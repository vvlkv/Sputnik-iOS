//
//  BUScheduleNewViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUScheduleViewControllerInput_h
#define BUScheduleViewControllerInput_h

@protocol BUScheduleTableViewControllerDelegate;
@protocol BUScheduleTableViewControllerDataSource;

@protocol BUScheduleViewControllerInput <NSObject>
@required
- (void)updateDate:(NSString *)date andWeek:(NSString *)week;
- (void)updateWeekIndex:(NSUInteger)weekIndex;
- (void)updateDayMarkers:(NSArray *)markers;
- (void)updateSemester;

- (void)showAlertControllerWithItems:(NSArray<NSString *> *)items selected:(void (^) (NSInteger index))selectionBlock;
- (void)showAlertController:(NSString *)title message:(NSString *)message;
- (void)showSearchIconVisibility:(BOOL)isVisible;
- (void)showFailInternetMessage;
- (void)showChooseEntityMessage;
- (void)showProgress;
- (void)hideProgress;

- (void)dataSource:(id <BUScheduleTableViewControllerDataSource>)dataSource;
- (void)delegate:(id <BUScheduleTableViewControllerDelegate>)delegate;

//NEW
- (void)updateEntityName:(NSString *)name;
- (void)createScheduleViews:(NSUInteger)startIndex;

@end

#endif /* BUScheduleNewViewControllerInput_h */
