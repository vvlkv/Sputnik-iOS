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
#import "SUAI.h"
#import "BUNotificationCenter.h"
#import "SputnikConst.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [SUAI instance];
    [BUNotificationCenter instance];
    var *tabBar = [[BUTabBarViewController alloc] init];
    var *presenter = [[BUTabBarPresenter alloc] init];
    tabBar.output = presenter;
    presenter.view = tabBar;
    if (@available(iOS 13.0, *)) {
        self.window.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.window.backgroundColor = [UIColor whiteColor];
    }
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    [self.window.layer setCornerRadius:5.f];
    [self.window.layer setMasksToBounds:YES];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kSputnikApplicationDidBecomeActive
                                                            object:self];
    });
}

@end
