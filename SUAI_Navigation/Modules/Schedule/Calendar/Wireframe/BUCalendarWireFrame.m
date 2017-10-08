//
//  BUCalendarWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCalendarWireFrame.h"
#import "BUCalendarViewController.h"
#import "BUCalendarPresenter.h"
#import "BUScheduleRouter.h"

@implementation BUCalendarWireFrame

+ (UIViewController *)assemblyCalendarWithData:(NSArray *)data {
    BUCalendarViewController *calendarViewController = [[BUCalendarViewController alloc] init];
    BUCalendarPresenter *calendarPresenter = [[BUCalendarPresenter alloc] initWithData:data];
    BUScheduleRouter *router = [[BUScheduleRouter alloc] init];
    calendarPresenter.router = router;
    calendarPresenter.view = calendarViewController;
    calendarViewController.output = calendarPresenter;
    return calendarViewController;
}

+ (UIViewController *)assemblyCalendarWithData:(NSArray *)data andRootViewController:(UIViewController *)viewController {
    BUCalendarViewController *calendarViewController = [[BUCalendarViewController alloc] init];
    BUCalendarPresenter *calendarPresenter = [[BUCalendarPresenter alloc] initWithData:data andRootViewController:viewController];
    BUScheduleRouter *router = [[BUScheduleRouter alloc] init];
    calendarPresenter.router = router;
    calendarPresenter.view = calendarViewController;
    calendarViewController.output = calendarPresenter;
    return calendarViewController;
}

@end
