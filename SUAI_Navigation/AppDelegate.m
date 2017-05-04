//
//  AppDelegate.m
//  SUAI_Navigation
//
//  Created by Виктор on 24.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "AppDelegate.h"
#import "BUMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BUMainViewController" bundle:nil];
    BUMainViewController *vc = [sb instantiateViewControllerWithIdentifier:@"BUMainVCID"];
    self.window.rootViewController = vc;
    return YES;
}

@end
