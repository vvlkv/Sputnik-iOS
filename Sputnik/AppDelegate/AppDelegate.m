//
//  AppDelegate.m
//  SUAI_Navigation
//
//  Created by Виктор on 24.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "AppDelegate.h"
#import "BUTabBarViewController.h"
#import "BUTabBarPresenter.h"
#import "BUGreetingsWireFrame.h"
#import "BUAppDataContainer.h"
#import "SUAI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [SUAI instance];
    BUTabBarViewController *tabBar = [[BUTabBarViewController alloc] init];
    BUTabBarPresenter *presenter = [[BUTabBarPresenter alloc] init];
    tabBar.output = presenter;
    presenter.view = tabBar;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    [self.window.layer setCornerRadius:5.f];
    [self.window.layer setMasksToBounds:YES];
    return YES;
}

@end
