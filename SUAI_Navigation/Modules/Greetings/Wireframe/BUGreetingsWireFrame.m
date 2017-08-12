//
//  BUGreetingsWireFrame.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGreetingsWireFrame.h"
#import "BUGreetingsPresenter.h"
#import "BUGreetingsViewController.h"
#import "BUGreetingsInteractor.h"

@implementation BUGreetingsWireFrame

+ (UIViewController *)assemblyGreetings {
    BUGreetingsViewController *greetingsViewController = [[BUGreetingsViewController alloc] init];
    BUGreetingsPresenter *greetingsPresenter = [[BUGreetingsPresenter alloc] init];
    BUGreetingsInteractor *greetingsInteractor = [[BUGreetingsInteractor alloc] init];
    greetingsPresenter.view = greetingsViewController;
    greetingsPresenter.input = greetingsInteractor;
    greetingsInteractor.output = greetingsPresenter;
    greetingsViewController.output = greetingsPresenter;
    greetingsViewController.dataSource = greetingsPresenter;
    return greetingsViewController;
}

@end
