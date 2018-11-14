//
//  BUReferenceWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 05/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceWireFrame.h"
#import "BUReferenceViewController.h"
#import "BUReferenceMainScreenPresenter.h"
#import "BUReferenceMainScreenInteractor.h"
#import "BUReferenceMainScreenRouter.h"

@implementation BUReferenceWireFrame

+ (UIViewController *)assembly {
    BUReferenceViewController *vc = [[BUReferenceViewController alloc] init];
    BUReferenceMainScreenPresenter *presenter = [[BUReferenceMainScreenPresenter alloc] init];
    BUReferenceMainScreenInteractor *interactor = [[BUReferenceMainScreenInteractor alloc] init];
    BUReferenceMainScreenRouter *router = [[BUReferenceMainScreenRouter alloc] init];
    
    presenter.view = vc;
    presenter.input = interactor;
    presenter.router = router;
    vc.output = presenter;
    interactor.output = presenter;
    [interactor activate];
    return vc;
}

@end
