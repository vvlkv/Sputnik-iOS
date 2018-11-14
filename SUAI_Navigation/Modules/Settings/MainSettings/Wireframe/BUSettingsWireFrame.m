//
//  BUSettingsWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsWireFrame.h"
#import "BUSettingsViewController.h"
#import "BUSettingsInteractor.h"
#import "BUSettingsPresenter.h"
#import "BUSettingsRouter.h"

@implementation BUSettingsWireFrame

+ (UIViewController *)assembly {
    BUSettingsViewController *settingsVC = [[BUSettingsViewController alloc] init];
    BUSettingsRouter *router = [[BUSettingsRouter alloc] init];
    BUSettingsInteractor *interactor = [[BUSettingsInteractor alloc] init];
    BUSettingsPresenter *presenter = [[BUSettingsPresenter alloc] init];
    presenter.view = settingsVC;
    presenter.router = router;
    presenter.input = interactor;
    interactor.output = presenter;
    settingsVC.output = presenter;
//    settingsVC.dataSource = presenter;
    return settingsVC;
}

@end
