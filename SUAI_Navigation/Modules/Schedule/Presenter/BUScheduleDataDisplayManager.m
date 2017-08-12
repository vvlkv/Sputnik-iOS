//
//  BUScheduleDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleDataDisplayManager.h"
#import "BUPair.h"
#import "BUPairViewModel.h"
#import "BUDay.h"

@implementation BUScheduleDataDisplayManager


#pragma mark - BUScheduleContentDataSource

- (NSUInteger)viewTypeAtIndex:(NSUInteger)index andType:(NSUInteger)type {
    if ([[self schedule] count] == 0) {
        return -1;
    }
    if (type == 0) {
        if ([[self semesterSchedule][index] isKindOfClass:[NSArray class]]) {
            return 0;
        }
    } else if ([[self sessionSchedule] count] == 0) {
        return 0;
    }
    return 1;
}

- (NSString *)titleForViewAtIndex:(NSUInteger)index andType:(NSUInteger)type {
    NSString *title;
    if (type == 0) {
        title = (index == 6) ? @"Курсовых проектов нет!" : @"Сегодня выходной!";
    } else {
        title = @"Сессии нет!";
    }
    return title;
}

- (NSUInteger)numberOfSectionsInTableView:(BUScheduleContentViewController *)tableView atIndex:(NSUInteger)index andType:(NSUInteger)type {
    BUDay *day;
    if (type == 0) {
        day = (BUDay *)[self semesterSchedule][index];
    } else {
        return [[self sessionSchedule] count];
    }
    return [[day pairs] count];
}

- (BUPairViewModel *)pairAtIndex:(NSUInteger)index dayIndex:(NSUInteger)day andType:(NSUInteger)type {
    BUPair *currentPair;
    BUPairViewModel *pairViewModel = [[BUPairViewModel alloc] init];
    if (type == 0) {
        BUDay *currentDay = (BUDay *)[self semesterSchedule][day];
        currentPair = (BUPair *)[currentDay pairs][index];
    } else {
        BUDay *currentDay = (BUDay *)[self sessionSchedule][index];
        currentPair = (BUPair *)[currentDay pairs][0];
    }
    
    pairViewModel.name = currentPair.name;
    pairViewModel.auditory = currentPair.auditory;
    if (type == 0)
    {
        pairViewModel.time = currentPair.time;
        pairViewModel.type = currentPair.lessonType;
    } else {
        BUDay *currentDay = (BUDay *)[self sessionSchedule][index];
        pairViewModel.time = [currentDay day];
        pairViewModel.type = [[currentPair.time componentsSeparatedByString:@" "] firstObject];
    }
    
    if ([self entityType] == 0) {
        pairViewModel.subInfo = [[[[currentPair teacherName] componentsSeparatedByString:@":"] lastObject] substringFromIndex:1];
    } else {
        pairViewModel.subInfo = [[[[currentPair groups] componentsSeparatedByString:@":"] lastObject] substringFromIndex:1];
    }
    
    return pairViewModel;
}

- (NSUInteger)colorForHeaderCellType:(NSUInteger)type {
    if (type == 1) {
        return 3;
    }
    return [self weekIndex];
}

- (NSString *)dateForTableView:(BUScheduleContentViewController *)tableView {
    NSArray* items = [[self date] componentsSeparatedByString:@" "];
    if ([items count] != 1) {
        NSString *date = [NSString stringWithFormat:@"%@ %@ %@", [items[2] capitalizedString], items[3], items[4]];
        return date;
    }
    return @"";
}

- (NSString *)weekForTableView:(BUScheduleContentViewController *)tableView {
    NSArray* items = [[self date] componentsSeparatedByString:@" "];
    if ([items count] != 1) {
        NSString *week = [NSString stringWithFormat:@"%@ %@ %@", [items[7] capitalizedString], items[8], [items[11] substringToIndex:[items[11] length] - 1]];
        return week;
    }
    return @"";
}


#pragma mark - Root

- (NSArray *)semesterSchedule {
    return _schedule[0];
}

- (NSArray *)sessionSchedule {
    return _schedule[1];
}

@end
