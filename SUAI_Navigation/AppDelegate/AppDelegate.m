//
//  AppDelegate.m
//  SUAI_Navigation
//
//  Created by Виктор on 24.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "AppDelegate.h"
#import "BURootTabBarViewController.h"
#import "BUGreetingsWireFrame.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BURootTabBarViewController *tabBar = [[BURootTabBarViewController alloc] init];
    self.window.rootViewController = tabBar;
    return YES;
}

@end
