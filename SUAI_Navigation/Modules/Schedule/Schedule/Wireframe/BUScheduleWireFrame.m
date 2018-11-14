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

+ (UIViewController *)assembly {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BUScheduleViewController"
                                                 bundle:nil];
    
    BUScheduleViewController *scheduleVC = (BUScheduleViewController *)[sb instantiateViewControllerWithIdentifier:@"BUScheduleID"];
    BUSchedulePresenter *schedulePresenter = [[BUSchedulePresenter alloc] init];
    BUScheduleInteractor *scheduleInteractor = [[BUScheduleInteractor alloc] init];
    BUScheduleRouter *scheduleRouter = [[BUScheduleRouter alloc] init];
    schedulePresenter.input = scheduleInteractor;
    schedulePresenter.router = scheduleRouter;
    scheduleInteractor.output = schedulePresenter;
    scheduleVC.output = schedulePresenter;
    schedulePresenter.view = scheduleVC;
    return scheduleVC;
}

@end
