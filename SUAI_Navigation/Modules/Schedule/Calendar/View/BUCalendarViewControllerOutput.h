//
//  BUCalendarViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 14.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUCalendarViewControllerOutput <NSObject>

@required
- (void)viewDidLoad;
- (void)didSelectDate:(NSDate *)date;
- (void)didPressAlertAction:(NSString *)action;
- (id)dataSource;
- (id)delegate;

@end
