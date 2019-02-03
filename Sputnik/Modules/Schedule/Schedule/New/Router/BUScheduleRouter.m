//
//  BUScheduleNewRouter.m
//  SUAI_Navigation
//
//  Created by Виктор on 20/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUScheduleRouter.h"

#import "BUScheduleViewController.h"
#import "BUSchedulePresenter.h"
#import "BUScheduleInteractor.h"
#import "BUScheduleRouter.h"

#import "BURootNavigationController.h"
#import "BUScheduleSearchViewController.h"

#import "BUMainScreenViewController.h"

#import "BUCalendarPresenter.h"
#import "BUCalendarViewController.h"

@implementation BUScheduleRouter

#pragma mark - BUScheduleNewRouterInput

- (void)pushScheduleViewControllerFromViewController:(__kindof UIViewController *)vc
                                          withEntity:(NSString *)entity
                                                type:(NSUInteger)type {
    BUScheduleViewController *newVC = [[BUScheduleViewController alloc] init];
    BUSchedulePresenter *presenter = [[BUSchedulePresenter alloc] initWithEntityName:entity andType:type];
    BUScheduleInteractor *interactor = [[BUScheduleInteractor alloc] init];
    BUScheduleRouter *router = [[BUScheduleRouter alloc] init];
    newVC.output = presenter;
    presenter.view = newVC;
    presenter.input = interactor;
    presenter.router = router;
    interactor.output = presenter;
    [vc.navigationController pushViewController:newVC animated:YES];
}

- (void)presentCalendarViewControllerFromViewController:(__kindof UIViewController *)vc withSchedule:(SUAISchedule *)schedule {
    BUCalendarViewController *cVC = [[BUCalendarViewController alloc] init];
    BURootNavigationController *navVC = [[BURootNavigationController alloc] initWithRootViewController:cVC];
    BUCalendarPresenter *presenter = [[BUCalendarPresenter alloc] initWithSchedule:schedule];
    __weak typeof(self) welf = self;
    presenter.foundEntity = ^(NSString *name, NSUInteger type) {
        [welf pushScheduleViewControllerFromViewController:vc withEntity:name type:type];
    };
    presenter.foundAuditory = ^(NSString *aud) {
        [welf showAuditory:aud fromViewController:vc];
    };
    presenter.view = cVC;
    cVC.output = presenter;
    [vc presentViewController:navVC animated:YES completion:nil];
}

- (void)presentSearchViewControllerFromViewController:(__kindof UIViewController *)vc {
    BUScheduleSearchViewController *searchVC = [[BUScheduleSearchViewController alloc] init];
    __weak typeof(self) welf = self;
    searchVC.foundEntity = ^(SUAIEntity *entity) {
        [welf.output didFindEntity:entity];
    };
    BURootNavigationController *rootNavVC = [[BURootNavigationController alloc] initWithRootViewController:searchVC];
    [vc presentViewController:rootNavVC animated:YES completion:nil];
}

- (void)showAuditory:(NSString *)auditory fromViewController:(__kindof UIViewController *)vc {
    NSArray *viewControllers = [vc.tabBarController viewControllers];
    UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
    BUMainScreenViewController *navigationController = [[myNavController childViewControllers] firstObject];
    [navigationController receiveAuditory:auditory];
    [vc.tabBarController setSelectedIndex:2];
}

@end
