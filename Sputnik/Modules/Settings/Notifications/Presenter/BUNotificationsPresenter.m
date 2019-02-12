//
//  BUNotificationsPresenter.m
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsPresenter.h"
#import "BUNotificationsDataDisplayManagerOutput.h"
#import "BUNotificationSettings.h"

#import "BUNotificationsDataDisplayManager.h"

#import "BUNotificationCenter.h"
#import "BUScheduleStorage.h"

#import "BUNotificationsViewControllerInput.h"
#import "BUNotificationsInteractorInput.h"

@interface BUNotificationsPresenter()<BUNotificationsDataDisplayManagerOutput, BUNotificationCenterOutput> {
    BUNotificationsDataDisplayManager *_displayManager;
//    BUNotificationCenter *_center;
    BUScheduleStorage *_storage;
}

@end

@implementation BUNotificationsPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storage = [[BUScheduleStorage alloc] init];
//        _center = [[BUNotificationCenter alloc] init];
//        _center.output = self;
    }
    return self;
}

#pragma mark - BUNotificationsInteractorOutput

//- (void)didObtainNotificationSettings:(BUNotificationSettings *)settings {
//    _displayManager = [[BUNotificationsDataDisplayManager alloc] initWithNotificationSettings:settings];
//    _displayManager.output = self;
//    [self.view dataSource:_displayManager];
//}


#pragma mark - BUNotificationsViewControllerOutput

- (void)viewDidLoad {
//    [self.input obtainNotificationsSettings];
    var *settings = [[BUNotificationCenter instance] currentSettings];
    _displayManager = [[BUNotificationsDataDisplayManager alloc] initWithNotificationSettings:settings];
    _displayManager.output = self;
    [self.view dataSource:_displayManager];
}

- (void)didTapOnSave {
    [[BUNotificationCenter instance] commitNotificationsSettings:_displayManager.settings withSchedule:[_storage load]];
}


#pragma mark - BUNotificationsDataDisplayManagerOutput

- (void)didChangeSwitchState {
    [self.view reloadData];
}

- (void)didChangeAllowNotificationsSwitch:(BOOL)newValue {
    if (![[BUNotificationCenter instance] isSystemGranted] && newValue == YES)
        [self.view showNeedGrantNotificationsMessage];
    else
        [self.view reloadData];
}


#pragma mark - BUNotificationCenterOutput

- (void)didChangeNotificationPermission:(BOOL)isGranted {
    var *settings = [[BUNotificationSettings alloc] init];
    settings.isGranted = [[BUNotificationCenter instance] isSystemGranted];
    _displayManager = [[BUNotificationsDataDisplayManager alloc] initWithNotificationSettings:settings];
    _displayManager.output = self;
    [self.view dataSource:_displayManager];
}

@end
