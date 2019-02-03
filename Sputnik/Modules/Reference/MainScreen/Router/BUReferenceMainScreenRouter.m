//
//  BUReferenceMainScreenRouter.m
//  SUAI_Navigation
//
//  Created by Виктор on 13/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceMainScreenRouter.h"
#import "BUReferenceDetailInfoInteractor.h"
#import "BUReferenceDetailInfoViewController.h"
#import "BUReferenceDetailInfoPresenter.h"
#import "BUMainScreenViewController.h"

@class UIViewController;
@implementation BUReferenceMainScreenRouter

- (void)presentDetailInfoViewControllerWithEntity:(id)entity fromViewController:(UIViewController *)viewController {
    BUReferenceDetailInfoInteractor *interactor = [[BUReferenceDetailInfoInteractor alloc] initWithEntity:entity];
    BUReferenceDetailInfoPresenter *presenter = [[BUReferenceDetailInfoPresenter alloc] init];
    BUReferenceDetailInfoViewController *infoVc = [[BUReferenceDetailInfoViewController alloc] init];
    BUReferenceMainScreenRouter *router = [[BUReferenceMainScreenRouter alloc] init];
    interactor.output = presenter;
    presenter.view = infoVc;
    presenter.input = interactor;
    presenter.router = router;
    infoVc.output = presenter;
    [interactor modulesAssembled];
    [viewController.navigationController pushViewController:infoVc animated:YES];
}

- (void)viewController:(UIViewController *)viewController
         foundAuditory:(NSString *)auditory {
    NSArray *viewControllers = [viewController.tabBarController viewControllers];
    UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
    BUMainScreenViewController *navigationController = [[myNavController childViewControllers] firstObject];
    [navigationController receiveAuditory:auditory];
    [viewController.tabBarController setSelectedIndex:2];
}

@end
