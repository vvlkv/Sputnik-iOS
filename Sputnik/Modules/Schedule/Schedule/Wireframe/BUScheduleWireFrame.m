//
//  BUScheduleWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleWireFrame.h"
#import "BUScheduleViewController.h"
#import "BUScheduleRouter.h"

#import "BUScheduleInteractor.h"
#import "BUSchedulePresenter.h"

@implementation BUScheduleWireFrame

+ (UIViewController *)assembly {
    BUScheduleViewController *newVC = [[BUScheduleViewController alloc] init];
    BUScheduleInteractor *interactor = [[BUScheduleInteractor alloc] init];
    BUSchedulePresenter *presenter = [[BUSchedulePresenter alloc] init];
    BUScheduleRouter *router = [[BUScheduleRouter alloc] init];
    interactor.output = presenter;
    presenter.view = newVC;
    presenter.input = interactor;
    presenter.router = router;
    newVC.output = presenter;
    router.output = presenter;
    
    return newVC;
}

@end
