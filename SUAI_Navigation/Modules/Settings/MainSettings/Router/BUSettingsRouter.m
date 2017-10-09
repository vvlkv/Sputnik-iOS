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

- (void)pushAboutAppViewControllerFromViewController:(UIViewController *)viewController {
    BUAboutAppViewController *aboutViewController = [[BUAboutAppViewController alloc] init];
    [viewController.navigationController pushViewController:aboutViewController animated:YES];
}

@end