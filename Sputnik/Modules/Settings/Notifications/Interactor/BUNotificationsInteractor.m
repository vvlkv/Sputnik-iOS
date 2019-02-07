//
//  BUNotificationsInteractor.m
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsInteractor.h"
#import "BUNotificationSettings.h"

#import "BUNotificationsInteractorOutput.h"

#import "BUNotificationCenter.h"

@interface BUNotificationsInteractor()<BUNotificationCenterOutput> {
    BUNotificationCenter *_center;
}

@end

@implementation BUNotificationsInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _center = [[BUNotificationCenter alloc] init];
        _center.output = self;
    }
    return self;
}


#pragma mark - BUNotificationsInteractorInput

- (void)obtainNotificationsSettings {
    var *settings = [[BUNotificationSettings alloc] init];
    settings.isGranted = [_center isGranted];
    [self.output didObtainNotificationSettings:settings];
}


#pragma mark - BUNotificationCenterOutput

- (void)didChangeNotificationPermission:(BOOL)isGranted {
    var *settings = [[BUNotificationSettings alloc] init];
    settings.isGranted = [_center isGranted];
    [self.output didObtainNotificationSettings:settings];
}

@end
