//
//  BUCalendarNewViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 22/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUCalendarNewViewControllerOutput_h
#define BUCalendarNewViewControllerOutput_h

@protocol BUCalendarViewControllerOutput <NSObject>
@required
- (void)viewDidLoad;

- (void)didSelectDate:(NSDate *)date;

@end

#endif /* BUCalendarNewViewControllerOutput_h */
