//
//  BUNotificationsViewModelPair.m
//  Sputnik
//
//  Created by Виктор on 08/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsViewModelPair.h"
#import "BUSliderTableViewCell.h"
#import <UIKit/UIKit.h>

@interface BUNotificationsViewModelPair() {
    NSUInteger _value;
}

@property (nonatomic, weak) BUSliderTableViewCell *cell;

@end

@implementation BUNotificationsViewModelPair

@synthesize output;

- (instancetype)initWithGrants:(BOOL)isGranted
                  initialValue:(NSUInteger)initial {
    self = [super initWithGrants:isGranted];
    if (self) {
        _value = initial;
    }
    return self;
}

- (NSUInteger)value {
    return [_cell sliderValue];
}

- (UITableViewCell *)p_configureSliderTableViewCell:(UITableView *)tableView {
    _cell = (BUSliderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"sliderID"];
    _cell.sliderValue = _value;
    _cell.titleValue = @"Присылать уведомления за %d %@";
    return _cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [super configureSwitchCell:tableView withTextLabel:@"Напоминать о начале пары"];
        case 1:
            return [self p_configureSliderTableViewCell:tableView];
    }
    return nil;
}

- (NSUInteger)rowsCount {
    return [super isGranted] ? 2 : 1;
}

@end
