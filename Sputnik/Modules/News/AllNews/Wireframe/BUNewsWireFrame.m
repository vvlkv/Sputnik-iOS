//
//  BUNewsWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsWireFrame.h"
#import "BUNewsRouter.h"
#import "BUNewsInteractor.h"
#import "BUNewsViewController.h"
#import "BUNewsPresenter.h"

@implementation BUNewsWireFrame

+ (UIViewController *)assembly {
    BUNewsRouter *router = [[BUNewsRouter alloc] init];
    BUNewsPresenter *presenter = [[BUNewsPresenter alloc] init];
    BUNewsInteractor *interactor = [[BUNewsInteractor alloc] init];
    BUNewsViewController *viewController = [[BUNewsViewController alloc] init];
    presenter.view = viewController;
    presenter.input = interactor;
    presenter.router = router;
    interactor.output = presenter;
    viewController.dataSource = presenter;
    viewController.output = presenter;
    return viewController;
}

@end
