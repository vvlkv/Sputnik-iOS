//
//  BUCalendarNewViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 22/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUCalendarNewViewControllerInput_h
#define BUCalendarNewViewControllerInput_h

@protocol BUScheduleTableViewControllerDelegate;
@protocol BUScheduleTableViewControllerDataSource;

@protocol BUCalendarViewControllerInput <NSObject>
@required
- (void)updateSchedule;

- (void)showAlertControllerWithItems:(NSArray<NSString *> *)items selected:(void (^) (NSInteger index))selectionBlock;

- (void)dataSource:(id <BUScheduleTableViewControllerDataSource>)dataSource;
- (void)delegate:(id <BUScheduleTableViewControllerDelegate>)delegate;

- (void)dismiss;

@end

#endif /* BUCalendarNewViewControllerInput_h */
