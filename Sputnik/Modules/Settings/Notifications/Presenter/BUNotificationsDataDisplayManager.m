//
//  BUNotificationsDataDisplayManager.m
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsDataDisplayManager.h"
#import "BUNotificationsDataDisplayManagerOutput.h"
#import "BUNotificationSettings.h"
#import "BUNotificationsViewModelItem.h"
#import "BUNotificationsViewModelGrants.h"
#import "BUNotificationsViewModelDay.h"
#import "BUNotificationsViewModelPair.h"

@interface BUNotificationsDataDisplayManager()<BUNotificationsViewModelItemOutput> {
    BUNotificationSettings *_settings;
    BUNotificationsViewModelDay *_daySection;
    BUNotificationsViewModelPair *_pairSection;
    NSArray<id<BUNotificationsViewModelItem>> *_sections;
}

@end

@implementation BUNotificationsDataDisplayManager

- (instancetype)initWithNotificationSettings:(BUNotificationSettings *)settings {
    self = [super init];
    if (self) {
        _settings = settings;
        var grantsSection = [[BUNotificationsViewModelGrants alloc] initWithGrants:_settings.isGranted];
        grantsSection.output = self;
        _daySection = [[BUNotificationsViewModelDay alloc] initWithGrants:_settings.isNotifyDay initialValue:0];
        _daySection.output = self;
        _pairSection = [[BUNotificationsViewModelPair alloc] initWithGrants:_settings.isNotifyPair initialValue:10];
        _pairSection.output = self;
        _sections = @[grantsSection, _daySection, _pairSection];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [_sections[indexPath.section] tableView:tableView cellForRowAtIndex:indexPath.row];
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sections[section] rowsCount];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _settings.isGranted ? [_sections count] : 1;
}


#pragma mark - BUNotificationsViewModelItemOutput

- (void)item:(id<BUNotificationsViewModelItem>)item didChangeSwitchStatus:(BOOL)newVal {
    if ([item isMemberOfClass:[BUNotificationsViewModelGrants class]])
        [self.output didChangeAllowNotificationsSwitch:newVal];
    else
        [self.output didChangeSwitchState];
}


- (BUNotificationSettings *)settings {
    _settings.isNotifyDay = _daySection.isGranted;
    _settings.isNotifyPair = _pairSection.isGranted;
    _settings.pairNotifyTime = _pairSection.value;
    return _settings;
}
@end
