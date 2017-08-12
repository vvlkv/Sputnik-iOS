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
#import "BUScheduleViewController.h"
#import "BUScheduleInteractor.h"
#import "BUMainScreenViewController.h"
#import "BURootNavigationController.h"
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
    BUScheduleDetailInfoViewController *scheduleVC = [[BUScheduleDetailInfoViewController alloc] init];
    scheduleVC.title = [[entity componentsSeparatedByString:@"-"] firstObject];
    BUSchedulePresenter *schedulePresenter = [[BUSchedulePresenter alloc] initWithEntity:entity andType:type];
    BUScheduleInteractor *scheduleInteractor = [[BUScheduleInteractor alloc] initAsRoot:NO];
    BUScheduleRouter *scheduleRouter = [[BUScheduleRouter alloc] init];
    schedulePresenter.input = scheduleInteractor;
    schedulePresenter.router = scheduleRouter;
    scheduleInteractor.output = schedulePresenter;
    scheduleVC.output = schedulePresenter;
    schedulePresenter.view = scheduleVC;
    
    [viewController.navigationController pushViewController:scheduleVC
                                                   animated:YES];
}

- (void)passAuditory:(NSString *)auditory fromNavigationViewController:(UIViewController *)viewController {
    NSArray *viewControllers = [viewController.tabBarController viewControllers];
    UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
    BUMainScreenViewController *navigationController = [[myNavController childViewControllers] firstObject];
    [navigationController receiveAuditory:auditory];
    [viewController.tabBarController setSelectedIndex:2];
}

@end
