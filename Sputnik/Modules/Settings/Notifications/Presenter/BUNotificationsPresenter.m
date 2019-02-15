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

@interface BUNotificationsPresenter()<BUNotificationsDataDisplayManagerOutput, BUNotificationCenterOutput> {
    BUNotificationsDataDisplayManager *_displayManager;
    BUScheduleStorage *_storage;
}

@end

@implementation BUNotificationsPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        _storage = [[BUScheduleStorage alloc] init];
        [BUNotificationCenter instance].output = self;
    }
    return self;
}


#pragma mark - BUNotificationsViewControllerOutput

- (void)viewDidLoad {
    var *settings = [[BUNotificationCenter instance] currentSettings];
    let isSystemGranted = [[BUNotificationCenter instance] isSystemGranted];
    if (isSystemGranted == NO)
        settings.isGranted = NO;
    _displayManager = [[BUNotificationsDataDisplayManager alloc] initWithNotificationSettings:settings];
    _displayManager.output = self;
    [self.view dataSource:_displayManager];
}

- (void)didTapOnSave {
    [[BUNotificationCenter instance] commitNotificationsSettings:_displayManager.settings withSchedule:[_storage load]];
    [((UIViewController *)self.view).navigationController popViewControllerAnimated:YES];
}


#pragma mark - BUNotificationsDataDisplayManagerOutput

- (void)didChangeSwitch:(BOOL)newValue atSection:(NSUInteger)sectionIndex {
    if (sectionIndex == 0) {
        if (newValue == YES) {
            if (![[BUNotificationCenter instance] isSystemGranted]) {
                if ([[BUNotificationCenter instance] accessRequested])
                    [self.view showNeedGrantNotificationsMessage];
                else
                    [[BUNotificationCenter instance] activatePermissions];
            } else
                [self.view insertSections];
        }
        else
            [self.view deleteSections];
    }
    if (sectionIndex == 2)
        [self.view reloadSectionsInSet:[NSIndexSet indexSetWithIndex:sectionIndex]];
}

#pragma mark - BUNotificationCenterOutput

- (void)didChangeNotificationPermission:(BOOL)isGranted {
    var *settings = [[BUNotificationCenter instance] currentSettings];
    settings.isGranted = [[BUNotificationCenter instance] isSystemGranted];
    _displayManager = [[BUNotificationsDataDisplayManager alloc] initWithNotificationSettings:settings];
    _displayManager.output = self;
    [self.view dataSource:_displayManager];
}

@end
