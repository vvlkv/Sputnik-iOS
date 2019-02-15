//
//  BUNotificationsViewModelCheckDay.m
//  Sputnik
//
//  Created by Виктор on 08/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsViewModelDay.h"
#import "BUSliderTableViewCell.h"
#import <UIKit/UIKit.h>

@interface BUNotificationsViewModelDay() {
    NSUInteger _value;
}

@end

@implementation BUNotificationsViewModelDay

@synthesize output;

- (instancetype)initWithGrants:(BOOL)isGranted
                  initialValue:(NSUInteger)initial {
    self = [super initWithGrants:isGranted];
    if (self) {
        _value = initial;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSUInteger)index {
    return [super configureSwitchCell:tableView withTextLabel:@"Напоминать об учебном дне"];
}

- (NSUInteger)rowsCount {
    return 1;
}

- (NSString *)footer {
    return @"В 12 часов придет уведомление о начале учебного дня";
}

@end
