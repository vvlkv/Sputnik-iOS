//
//  BUSettingsRouter.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsRouter.h"
#import "BUSettingsEntityViewController.h"
#import "BUAboutAppViewController.h"
#import "BURootNavigationController.h"
#import "BUScheduleSearchViewController.h"

@implementation BUSettingsRouter


#pragma mark - BUSettingsRouterInput

- (void)presentSearchViewControllerWithItems:(NSArray *)items
                          fromViewController:(UIViewController *)viewController
                                andPresenter:(id)presenter {
    BUSettingsEntityViewController *entityVc = [[BUSettingsEntityViewController alloc] initWithContents:items];
    BURootNavigationController *rootVc = [[BURootNavigationController alloc] initWithRootViewController:entityVc];
    entityVc.output = presenter;
    [viewController presentViewController:rootVc animated:YES completion:nil];
}

- (void)presentSearchViewControllerFromViewController:(__kindof UIViewController *)vc {
    var *searchVC = [[BUScheduleSearchViewController alloc] init];
    __weak typeof(self) welf = self;
    searchVC.foundEntity = ^(SUAIEntity * _Nonnull entity) {
        [welf.output didFindEntity:entity];
    };
    var *navVC = [[BURootNavigationController alloc] initWithRootViewController:searchVC];
    [vc presentViewController:navVC animated:YES completion:nil];
}

- (void)pushAboutAppViewControllerFromViewController:(UIViewController *)viewController {
    BUAboutAppViewController *aboutViewController = [[BUAboutAppViewController alloc] init];
    [viewController.navigationController pushViewController:aboutViewController animated:YES];
}

@end
