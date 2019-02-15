//
//  BUNotificationsWireframe.m
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsWireframe.h"
#import "BUNotificationsViewController.h"
#import "BUNotificationsPresenter.h"

@implementation BUNotificationsWireframe

+ (UIViewController *)assembly {
    var *vc = [[BUNotificationsViewController alloc] init];
    var *presenter = [[BUNotificationsPresenter alloc] init];
    presenter.view = vc;
    vc.output = presenter;
    return vc;
}

@end
