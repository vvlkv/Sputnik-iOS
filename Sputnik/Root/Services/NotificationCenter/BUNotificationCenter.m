//
//  BUNotificationCenter.m
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationCenter.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>

@interface BUNotificationCenter() {
    UNUserNotificationCenter *_defaultCenter;
}

@property (nonatomic, readwrite) BOOL isGranted;

@end

@implementation BUNotificationCenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _defaultCenter = [UNUserNotificationCenter currentNotificationCenter];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_notificationsSettingsChanged)
                                                     name:@"wakeUP"
                                                   object:nil];
        __weak typeof(self) welf = self;
        [_defaultCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            welf.isGranted = settings.authorizationStatus == UNAuthorizationStatusAuthorized;
        }];
    }
    return self;
}


- (void)p_notificationsSettingsChanged {
    __weak typeof(self) welf = self;
    [_defaultCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        welf.isGranted = settings.authorizationStatus == UNAuthorizationStatusAuthorized;
        dispatch_async(dispatch_get_main_queue(), ^{
            [welf.output didChangeNotificationPermission:[welf isGranted]];
        });
    }];
}

- (void)commitNotificationsSettings:(BUNotificationSettings *)settings
                       withSchedule:(SUAISchedule *)schedule {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

@end
