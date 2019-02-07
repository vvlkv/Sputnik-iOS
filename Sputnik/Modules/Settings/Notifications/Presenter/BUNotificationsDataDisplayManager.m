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


@interface BUNotificationsDataDisplayManager() {
    BUNotificationSettings *_settings;
}

@end

@implementation BUNotificationsDataDisplayManager

- (instancetype)initWithNotificationSettings:(BUNotificationSettings *)settings {
    self = [super init];
    if (self) {
        _settings = settings;
    }
    return self;
}

- (void)p_allowNotificationsChanged:(UISwitch *)sw {
    [self.output didChangeAllowNotificationsSwitch:[sw isOn]];
}

- (void)p_allowDayNotificationsChanged:(UISwitch *)sw {
    
}

- (void)p_allowPairNotificationsChanged:(UISwitch *)sw {
    
}

- (void)p_configureGrantNotificationsCell:(UITableViewCell *)cell {
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectZero];
    [sw setOn:[_settings isGranted]];
    [sw addTarget:self action:@selector(p_allowNotificationsChanged:) forControlEvents:UIControlEventValueChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = sw;
    cell.textLabel.text = @"Допуск уведомлений";
}

- (void)p_configureAllowDayNotificationsCell:(UITableViewCell *)cell {
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectZero];
    [sw setOn:[_settings isNotifyDay]];
    [sw addTarget:self action:@selector(p_allowDayNotificationsChanged:) forControlEvents:UIControlEventValueChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = sw;
    cell.textLabel.text = @"Напоминать о начале учебного дня";
}

- (void)p_configureAllowPairNotificationsCell:(UITableViewCell *)cell {
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectZero];
    [sw setOn:[_settings isNotifyPair]];
    [sw addTarget:self action:@selector(p_allowPairNotificationsChanged:) forControlEvents:UIControlEventValueChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"Напоминать о начале пары";
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    switch (indexPath.section) {
        case 0:
            [self p_configureGrantNotificationsCell:cell];
            break;
        case 1:
            [self p_configureAllowDayNotificationsCell:cell];
            break;
        case 2:
            [self p_configureAllowPairNotificationsCell:cell];
            break;
        default:
            break;
    }
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _settings.isGranted ? 3 : 1;
}

@end
