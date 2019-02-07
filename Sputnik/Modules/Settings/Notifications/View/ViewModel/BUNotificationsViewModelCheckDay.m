//
//  BUNotificationsViewModelCheckDay.m
//  Sputnik
//
//  Created by Виктор on 08/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsViewModelCheckDay.h"
#import <UIKit/UIKit.h>

@interface BUNotificationsViewModelCheckDay() {
    BOOL _isGranted;
    NSUInteger _value;
}

@end

@implementation BUNotificationsViewModelCheckDay

- (instancetype)initWithGrants:(BOOL)isGranted
                  initialValue:(NSUInteger)initial {
    self = [super init];
    if (self) {
        _isGranted = isGranted;
        _value = initial;
    }
    return self;
}

- (void)p_allowPairNotificationsChanged:(UISwitch *)sw {
    
}

- (UITableViewCell *)p_configureGrantsCellForTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectZero];
//    [sw setOn:[_settings isNotifyPair]];
    [sw addTarget:self action:@selector(p_allowPairNotificationsChanged:) forControlEvents:UIControlEventValueChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"Напоминать о начале пары";
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return [self p_configureGrantsCellForTableView:tableView];
        case 1:
            return nil;
    }
    return nil;
}

- (NSUInteger)rowsCount {
    return _isGranted ? 2 : 1;
}

@end
