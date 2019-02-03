//
//  BUCalendarNewPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 21/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUCalendarPresenter.h"
#import "BUScheduleDataDisplayManager.h"
#import "BUCalendarViewControllerInput.h"

#import "NSCalendar+CurrentDay.h"

#import "SUAISchedule.h"
#import "SUAIEntity.h"
#import "SUAIPair.h"
#import "SUAIAuditory.h"

@interface BUCalendarPresenter()<BUScheduleTableViewControllerDelegate, BUCalendarViewControllerOutput> {
    NSString *_entity;
    BUScheduleDataDisplayManager *_dataManager;
}

@end

@implementation BUCalendarPresenter


#pragma mark - BUScheduleTableViewControllerDelegate

- (instancetype)initWithSchedule:(SUAISchedule *)schedule {
    self = [super init];
    if (self) {
        _entity = [[schedule entity] name];
        _dataManager = [[BUScheduleDataDisplayManager alloc] initWithSchedule:schedule];
    }
    return self;
}

- (void)tableView:(BUScheduleTableViewController *)tableView
    didSelectPair:(NSUInteger)pairIndex
            atDay:(NSUInteger)dayIndex {
    SUAIPair *pair = [_dataManager pairAtIndex:pairIndex day:dayIndex scheduleType:(NSUInteger)[tableView type]];
    
    NSMutableArray <NSString *> *groups = [NSMutableArray array];
    NSMutableArray <NSString *> *teachers = [NSMutableArray array];
    for (NSString *group in [pair groups]) {
        if (![group isEqualToString:_entity])
            [groups addObject:group];
    }
    for (NSString *teacher in [pair teachers]) {
        if (![teacher containsString:_entity])
            [teachers addObject:[[teacher componentsSeparatedByString:@" -"] firstObject]];
    }
    NSMutableArray <NSString *> *items = [NSMutableArray array];
    [items addObjectsFromArray:groups];
    [items addObjectsFromArray:teachers];
    if ([[pair auditory] building] == BM) {
        [items addObject:[[pair auditory] number]];
        [items addObject:@"Показать на карте"];
    }
    __weak typeof(self) welf = self;
    if ([items count] > 0) {
        [self.view showAlertControllerWithItems:items selected:^(NSInteger index) {
            [welf.view dismiss];
            NSInteger type = -1;
            if ([groups containsObject:items[index]])
                type = 0;
            else if ([teachers containsObject:items[index]])
                type = 1;
            else if ([[[pair auditory] number] containsString:items[index]])
                type = 2;
            if (type == -1) {
                welf.foundAuditory([[pair auditory] number]);
            } else {
                welf.foundEntity(items[index], type);
            }
        }];
    }
}

#pragma mark - BUCalendarNewViewControllerOutput

- (void)viewDidLoad {
    [self.view dataSource:_dataManager];
    [self.view delegate:self];
}

- (void)didSelectDate:(NSDate *)date {
    _dataManager.weekIndex = [NSCalendar weekIndexFromDate:date];
    [self.view updateSchedule];
}

@end
