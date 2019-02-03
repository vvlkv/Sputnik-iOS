//
//  BUNavigationRouter.m
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNavigationRouter.h"
#import "BUCameraViewController.h"
#import "BUNavigationSearchScreenViewController.h"
#import "BURootNavigationController.h"

@implementation BUNavigationRouter


#pragma mark - BUNavigationRouterInput

- (void)presentSearchViewControllerFromViewController:(UIViewController *)viewController andPresenter:(id)presenter {
    BUNavigationSearchScreenViewController *searchVC = [[BUNavigationSearchScreenViewController alloc] init];
    searchVC.output = presenter;
    BURootNavigationController *searchNC = [[BURootNavigationController alloc] initWithRootViewController:searchVC];
    [viewController presentViewController:searchNC animated:YES completion:nil];
}

- (void)presentCameraViewControllerFromViewController:(UIViewController *)viewController andPresenter:(id)presenter {
    BUCameraViewController *cameraViewController = [[BUCameraViewController alloc] init];
    BURootNavigationController *cameraNC = [[BURootNavigationController alloc] initWithRootViewController:cameraViewController];
    cameraViewController.output = presenter;
    [viewController presentViewController:cameraNC animated:YES completion:nil];
}

@end
