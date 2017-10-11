//
//  BUScheduleViewControllerOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleContentDataSource.h"
#import <UIKit/UIKit.h>

@protocol BUScheduleViewControllerOutput <NSObject>

@required
- (void)viewDidLoad;
- (void)didChangeWeekSegment:(NSUInteger)index;


@optional
- (void)didChangeScheduleSegment:(NSUInteger)index;
- (void)didPressSearchButton;
- (void)didPressAlertAction:(NSString *)action;
- (void)didPressCalendarAction;
- (id <BUScheduleContentDataSource>)dataSource;
- (id <BUScheduleContentDelegate>)delegate;

@end
