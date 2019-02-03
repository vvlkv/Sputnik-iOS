//
//  BUScheduleNewViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUScheduleViewControllerOutput_h
#define BUScheduleViewControllerOutput_h

@protocol BUScheduleViewControllerOutput <NSObject>
@required
- (void)viewDidLoad;
- (void)didChangeWeekIndex:(NSUInteger)index;

- (void)didTapOnCalendar;
- (void)didTapOnSearch;

@end

#endif /* BUScheduleNewViewControllerOutput_h */
