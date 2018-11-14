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
#import "BUAppDataContainer.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BURootTabBarViewController *tabBar = [[BURootTabBarViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    [self.window.layer setCornerRadius:5.f];
    [self.window.layer setMasksToBounds:YES];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buInternetBecomeReachable"
                                                                    object:nil];
                [[BUAppDataContainer instance] loadCodes];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
            default: {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buInternetBecomeUnreachable"
                                                                    object:nil];
                break;
            }
        }
        
    }];
    return YES;
}

@end
