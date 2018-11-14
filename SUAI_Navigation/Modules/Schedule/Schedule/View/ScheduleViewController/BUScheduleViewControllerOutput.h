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
- (void)viewDidLoadWithWeekSegmentIndex:(NSUInteger)index;
- (void)didChangeWeekSegment:(NSUInteger)index;
- (void)didChangeScheduleSegment:(NSUInteger)index;

@optional
- (void)didPressSearchButton;
- (void)didPressAlertAction:(NSString *)action;
- (void)didPressCalendarAction;
- (void)didPressGoToSettingsButton;
- (id)dataSource;
- (id <BUScheduleContentDelegate>)delegate;

@end
