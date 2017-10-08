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
#import "AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BURootTabBarViewController *tabBar = [[BURootTabBarViewController alloc] init];
    self.window.rootViewController = tabBar;
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buInternetBecomeReachable"
                                                                    object:nil];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buInternetBecomeUnreachable"
                                                                    object:nil];
                break;
        }
        
    }];
    return YES;
}

@end
