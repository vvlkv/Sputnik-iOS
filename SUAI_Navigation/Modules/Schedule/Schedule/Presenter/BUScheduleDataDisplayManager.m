//
//  BUScheduleDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleDataDisplayManager.h"
#import "BUScheduleContentViewController.h"
#import "BUPair.h"
#import "BUPairViewModel.h"
#import "BUDay.h"

@class BUCapsPageView;
@implementation BUScheduleDataDisplayManager

#pragma mark - BUScheduleContentDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _weekIndex = 3;
    }
    return self;
}

- (void)typeOfViewForViewController:(BUScheduleContentViewController *)vc {
    NSUInteger index = [vc index];
    ScheduleType type = [vc type];
    
    if (type == ScheduleTypeSemester) {
        if ([[self semesterSchedule][index] isKindOfClass:[NSArray class]]) {
            [vc showAustronaut];
        } else {
            [vc showSchedule];
        }
    } else {
        if ([[self sessionSchedule] count] == 0) {
            [vc showAustronaut];
        } else {
            [vc showSchedule];
        }
    }
}

- (NSString *)titleForViewAtIndex:(NSUInteger)index andType:(NSUInteger)type {
    NSString *title;
    if (type == 0) {
        title = (index == 6) ? @"Предметов вне сетки расписания нет!" : @"Выходной!";
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
    if ([currentPair.auditory containsString:@"КАФЕДРА"]) {
        pairViewModel.auditory = [currentPair.auditory stringByReplacingOccurrencesOfString:@"КАФЕДРА " withString:@""];
    } else {
        pairViewModel.auditory = currentPair.auditory;
    }
    
    
    if (type == 0)
    {
        pairViewModel.time = currentPair.time;
        pairViewModel.type = currentPair.lessonType;
    } else {
        BUDay *currentDay = (BUDay *)[self sessionSchedule][index];
        pairViewModel.time = [currentDay day];
        pairViewModel.type = [[currentPair.time componentsSeparatedByString:@" "] firstObject];
    }
    
    if (day == 6) {
        pairViewModel.subInfo = @"";
    } else if ([self entityType] == EntityTypeGroup) {
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


#pragma mark - BUCapsPageViewDataSource

- (NSUInteger)capsPageView:(BUCapsPageView *)pageView dayTypeAtIndex:(NSUInteger)dayType {
    NSUInteger value = [_weekIndicators[[NSString stringWithFormat:@"%ld", (unsigned long)dayType]] integerValue];
    return value;
}


#pragma mark - Root

- (NSArray *)semesterSchedule {
    return _semesterSchedule[_weekIndex];
}

- (NSArray *)sessionSchedule {
    return _sessionSchedule[0];
}

@end
