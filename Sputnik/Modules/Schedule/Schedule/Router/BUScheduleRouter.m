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

#import "BUSearchViewController.h"
#import "BUSearchPresenter.h"

#import "BUMainScreenViewController.h"

#import "BUCalendarPresenter.h"
#import "BUCalendarViewController.h"
#import "BUCustomTransitioner.h"

@interface BUScheduleRouter() {
    
}

@property (strong, nonatomic) BUCustomTransitioner *transitioner;

@end

@implementation BUScheduleRouter

#pragma mark - BUScheduleNewRouterInput

- (void)pushScheduleViewControllerFromViewController:(__kindof UIViewController *)vc
                                          withEntity:(NSString *)entity
                                                type:(NSUInteger)type {
    var *newVC = [[BUScheduleViewController alloc] init];
    var *presenter = [[BUSchedulePresenter alloc] initWithEntityName:entity andType:type];
    var *interactor = [[BUScheduleInteractor alloc] init];
    var *router = [[BUScheduleRouter alloc] init];
    newVC.output = presenter;
    presenter.view = newVC;
    presenter.input = interactor;
    presenter.router = router;
    interactor.output = presenter;
    [vc.navigationController pushViewController:newVC animated:YES];
}

- (void)presentCalendarViewControllerFromViewController:(__kindof UIViewController *)vc withSchedule:(SUAISchedule *)schedule {
    var *cVC = [[BUCalendarViewController alloc] init];
    var *navVC = [[BURootNavigationController alloc] initWithRootViewController:cVC];
    var *presenter = [[BUCalendarPresenter alloc] initWithSchedule:schedule];
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
    BUSearchViewController *searchVC = [[BUSearchViewController alloc] init];
    var *presenter = [[BUSearchPresenter alloc] init];
    __weak typeof(self) welf = self;
    __weak BUSearchViewController *welfVC = searchVC;
    presenter.didFindEntity = ^(SUAIEntity * _Nonnull entity) {
        [welfVC dismissViewControllerAnimated:YES completion:^{
            [welf.output didFindEntity:entity];
        }];
    };
    presenter.view = searchVC;
    searchVC.output = presenter;
    _transitioner = [[BUCustomTransitioner alloc] init];
    searchVC.transitioningDelegate = _transitioner;
    searchVC.modalPresentationStyle = UIModalPresentationCustom;
    [vc presentViewController:searchVC animated:YES completion:nil];
}

- (void)showAuditory:(NSString *)auditory fromViewController:(__kindof UIViewController *)vc {
    NSArray *viewControllers = [vc.tabBarController viewControllers];
    UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
    BUMainScreenViewController *navigationController = [[myNavController childViewControllers] firstObject];
    [navigationController receiveAuditory:auditory];
    [vc.tabBarController setSelectedIndex:2];
}

@end
