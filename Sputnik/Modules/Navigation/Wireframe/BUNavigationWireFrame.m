//
//  BUNavigationWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNavigationWireFrame.h"
#import "BUMainScreenViewController.h"
#import "BUNavigationPresenter.h"
#import "BUNavigationRouter.h"

@implementation BUNavigationWireFrame

+ (UIViewController *)assembly {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BUMainScreenViewController" bundle:nil];
//    BUMainScreenViewController *navigationVC = [[BUMainScreenViewController alloc] init];
    BUMainScreenViewController *navigationVC = (BUMainScreenViewController *)[sb instantiateViewControllerWithIdentifier:@"MainNavigationID"];
    BUNavigationPresenter *navigationPresenter = [[BUNavigationPresenter alloc] init];
    BUNavigationRouter *navigationRouter = [[BUNavigationRouter alloc] init];
    navigationVC.output = navigationPresenter;
    navigationPresenter.view = navigationVC;
    navigationPresenter.router = navigationRouter;
    return navigationVC;
}

@end
