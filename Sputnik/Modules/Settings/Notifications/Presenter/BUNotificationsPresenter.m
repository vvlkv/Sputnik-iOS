//
//  BUNotificationsPresenter.m
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsPresenter.h"
#import "BUNotificationsDataDisplayManagerOutput.h"

#import "BUNotificationsDataDisplayManager.h"

#import "BUNotificationsViewControllerInput.h"
#import "BUNotificationsInteractorInput.h"

@interface BUNotificationsPresenter()<BUNotificationsDataDisplayManagerOutput> {
    BUNotificationsDataDisplayManager *_displayManager;
}

@end

@implementation BUNotificationsPresenter


#pragma mark - BUNotificationsInteractorOutput

- (void)didObtainNotificationSettings:(BUNotificationSettings *)settings {
    _displayManager = [[BUNotificationsDataDisplayManager alloc] initWithNotificationSettings:settings];
    _displayManager.output = self;
    [self.view dataSource:_displayManager];
}


#pragma mark - BUNotificationsViewControllerOutput

- (void)viewDidLoad {
    [self.input obtainNotificationsSettings];
}


#pragma mark - BUNotificationsDataDisplayManagerOutput

- (void)didChangeAllowNotificationsSwitch:(BOOL)newValue {
    if (newValue == YES)
        [self.view showNeedGrantNotificationsMessage];
}

@end
