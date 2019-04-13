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

#import "BUSearchPresenter.h"
#import "BUSearchViewController.h"
#import "BUCustomTransitioner.h"

#import "BUNotificationsWireframe.h"

@interface BUSettingsRouter() {
    
}

@property (strong, nonatomic) BUCustomTransitioner *transitioner;

@end

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
    var *searchVC = [[BUSearchViewController alloc] init];
    var *presenter = [[BUSearchPresenter alloc] init];
    searchVC.output = presenter;
    presenter.view = searchVC;
    __weak typeof(self) welf = self;
    presenter.didFindEntity = ^(SUAIEntity * _Nonnull entity) {
        [welf.output didFindEntity:entity];
        [searchVC dismissViewControllerAnimated:YES completion:nil];
    };
    _transitioner = [[BUCustomTransitioner alloc] init];
    searchVC.transitioningDelegate = _transitioner;
    searchVC.modalPresentationStyle = UIModalPresentationCustom;
    [vc presentViewController:searchVC animated:YES completion:nil];
}

- (void)pushNotificationCenterFromViewController:(UIViewController *)vc {
    var *notificationsVC = [BUNotificationsWireframe assembly];
    [vc.navigationController pushViewController:notificationsVC animated:YES];
}

- (void)pushAboutAppViewControllerFromViewController:(UIViewController *)viewController {
    BUAboutAppViewController *aboutViewController = [[BUAboutAppViewController alloc] init];
    [viewController.navigationController pushViewController:aboutViewController animated:YES];
}



@end
