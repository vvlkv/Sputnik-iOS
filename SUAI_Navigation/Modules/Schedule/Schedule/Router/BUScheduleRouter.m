//
//  BUScheduleRouter.m
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleRouter.h"
#import "BUScheduleSearchViewController.h"
#import "BUScheduleDetailInfoViewController.h"
#import "BUSchedulePresenter.h"
#import "BUScheduleInteractor.h"
#import "BUMainScreenViewController.h"
#import "BURootNavigationController.h"
#import "BUCalendarWireFrame.h"
#import <UIKit/UIKit.h>

@implementation BUScheduleRouter

#pragma mark - BUScheduleRouterInput

- (void)presentSearchViewControllerWithItems:(NSArray *)items
                          fromViewController:(UIViewController *)viewController
                                andPresenter:(id)presenter {
    
    BUScheduleSearchViewController *searchVC = [[BUScheduleSearchViewController alloc] initWithContents:items];
    searchVC.output = presenter;
    BURootNavigationController *navVc = [[BURootNavigationController alloc] initWithRootViewController:searchVC];
    [viewController presentViewController:navVc animated:YES completion:nil];
}

- (void)pushDetailViewControllerFromViewController:(UIViewController *)viewController
                                        withEntity:(NSString *)entity
                                           andType:(NSUInteger)type {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BUScheduleDetailInfoViewController" bundle:nil];
    BUScheduleDetailInfoViewController *scheduleVC = (BUScheduleDetailInfoViewController *)[sb instantiateViewControllerWithIdentifier:@"BUScheduleDetailID"];
    scheduleVC.title = [[entity componentsSeparatedByString:@"-"] firstObject];
    BUSchedulePresenter *schedulePresenter = [[BUSchedulePresenter alloc] init];
    BUScheduleInteractor *scheduleInteractor = [[BUScheduleInteractor alloc] initWithEntity:entity ofType:type];
    BUScheduleRouter *scheduleRouter = [[BUScheduleRouter alloc] init];
    schedulePresenter.input = scheduleInteractor;
    schedulePresenter.router = scheduleRouter;
    scheduleInteractor.output = schedulePresenter;
    scheduleVC.output = schedulePresenter;
    schedulePresenter.view = scheduleVC;
    [viewController.navigationController pushViewController:scheduleVC
                                                   animated:YES];
}

- (void)presentCalendarViewControllerFromViewController:(UIViewController *)viewController
                                               withData:(NSArray *)data {
    BURootNavigationController *navVc = [[BURootNavigationController alloc] initWithRootViewController:[BUCalendarWireFrame assemblyCalendarWithData:data
                                                                                                                               andRootViewController:viewController]];
    [viewController presentViewController:navVc animated:YES completion:nil];
}

- (void)passAuditory:(NSString *)auditory fromNavigationViewController:(UIViewController *)viewController {
    NSArray *viewControllers = [viewController.tabBarController viewControllers];
    UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
    BUMainScreenViewController *navigationController = [[myNavController childViewControllers] firstObject];
    [navigationController receiveAuditory:auditory];
    [viewController.tabBarController setSelectedIndex:2];
}

- (void)navigateTabBarToSettingsViewControllerFromViewController:(UIViewController *)viewController {
    NSUInteger totalControllers = [[viewController.tabBarController viewControllers] count];
    [viewController.tabBarController setSelectedIndex:totalControllers - 1];
}

@end
