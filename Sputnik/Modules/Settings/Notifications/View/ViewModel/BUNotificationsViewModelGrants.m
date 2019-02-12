//
//  BUNotificationsViewModelGrants.m
//  Sputnik
//
//  Created by Виктор on 08/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsViewModelGrants.h"
#import <UIKit/UIKit.h>

@interface BUNotificationsViewModelGrants() {
    BOOL _isGranted;
}

@end

@implementation BUNotificationsViewModelGrants

@synthesize output;

- (instancetype)initWithGrants:(BOOL)isGranted {
    self = [super init];
    if (self) {
        _isGranted = isGranted;
    }
    return self;
}

- (UITableViewCell *)configureSwitchCell:(UITableView *)tableView withTextLabel:(NSString *)textLabel {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectZero];
    [sw setOn:_isGranted];
    [sw addTarget:self action:@selector(p_allowNotificationsChanged:) forControlEvents:UIControlEventValueChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = sw;
    cell.textLabel.text = textLabel;
    return cell;
}

- (BOOL)isGranted {
    return _isGranted;
}


#pragma mark - BUNotificationsViewModelItem

- (NSUInteger)rowsCount {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSUInteger)index {
    return [self configureSwitchCell:tableView withTextLabel:@"Допуск уведомлений"];
}

- (void)p_allowNotificationsChanged:(UISwitch *)sw {
    _isGranted = [sw isOn];
    [self.output item:self didChangeSwitchStatus:_isGranted];
}

@end
