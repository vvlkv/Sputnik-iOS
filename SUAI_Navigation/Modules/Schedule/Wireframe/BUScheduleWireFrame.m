//
//  BUScheduleWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleWireFrame.h"
#import "BUScheduleRouter.h"
#import "BUSchedulePresenter.h"
#import "BUScheduleViewController.h"
#import "BUScheduleInteractor.h"
#import "BUAppDataContainer.h"

@implementation BUScheduleWireFrame

+ (UIViewController *)assemblySchedule {
    BUScheduleViewController *scheduleVC = [[BUScheduleViewController alloc] init];
    NSString *entity = [[BUAppDataContainer instance] entity];
    NSUInteger type = [[BUAppDataContainer instance] type];
    BUSchedulePresenter *schedulePresenter = [[BUSchedulePresenter alloc] initWithEntity:entity andType:type];
    BUScheduleInteractor *scheduleInteractor = [[BUScheduleInteractor alloc] initAsRoot:YES];
    BUScheduleRouter *scheduleRouter = [[BUScheduleRouter alloc] init];
    schedulePresenter.input = scheduleInteractor;
    schedulePresenter.router = scheduleRouter;
    scheduleInteractor.output = schedulePresenter;
    scheduleVC.output = schedulePresenter;
    schedulePresenter.view = scheduleVC;
    return scheduleVC;
}

@end
