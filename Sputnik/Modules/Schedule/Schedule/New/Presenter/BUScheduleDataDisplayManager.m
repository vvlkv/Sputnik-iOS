//
//  BUScheduleNewDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUScheduleDataDisplayManager.h"
#import "BUPairViewModel.h"

#import "SUAISchedule.h"
#import "SUAIDay.h"
#import "SUAIPair.h"
#import "SUAIAuditory.h"
#import "SUAIEntity.h"
#import "SUAITime.h"
#import "SUAITeacher.h"
#import "UIColor+SUAI.h"

@interface BUScheduleDataDisplayManager() {
    SUAISchedule *_schedule;
    NSArray <SUAIDay *> *_expandedDays;
}

@end

@implementation BUScheduleDataDisplayManager

- (instancetype)initWithSchedule:(SUAISchedule *)schedule
{
    self = [super init];
    if (self) {
        _schedule = schedule;
    }
    return self;
}

- (SUAISchedule *)schedule {
    return _schedule;
}

- (void)setWeekIndex:(NSUInteger)weekIndex {
    _weekIndex = weekIndex;
    if (_weekIndex == 0) {
        _expandedDays = [_schedule expandedScheduleToFullWeek:_schedule.blueSemester];
    } else {
        _expandedDays = [_schedule expandedScheduleToFullWeek:_schedule.redSemester];
    }
}

- (SUAIPair *)pairAtIndex:(NSUInteger)pairIndex
                      day:(NSUInteger)day
             scheduleType:(ScheduleType)type {
    if (type == ScheduleTypeSemester) {
        return [_expandedDays[day] pairs][pairIndex];
    }
    return [_schedule.session[pairIndex] pairs][0];
}

- (NSArray *)createMarkers {
    NSMutableArray *markers = [NSMutableArray array];
    NSArray<SUAIDay *> *redSemester = [_schedule expandedScheduleToFullWeek:_schedule.redSemester];
    NSArray<SUAIDay *> *blueSemester = [_schedule expandedScheduleToFullWeek:_schedule.blueSemester];
    for (int i = 0; i < [redSemester count]; i++) {
        NSUInteger redPairsCount = [[redSemester[i] pairs] count];
        NSUInteger bluePairsCount = [[blueSemester[i] pairs] count];
        NSUInteger marker = 0;
        if (redPairsCount != 0 && bluePairsCount != 0)
            marker = 3;
        else if (redPairsCount != 0)
            marker = 1;
        else if (bluePairsCount != 0)
            marker = 2;
        [markers addObject:[NSNumber numberWithUnsignedInteger:marker]];
    }
    return [markers copy];
}

#pragma mark - BUScheduleTableViewControllerDataSource

- (NSUInteger)tableView:(BUScheduleTableViewController *)tableView numberOfPairsAtIndex:(NSUInteger)index {
    if ([tableView type] == ScheduleTypeSemester)
        return [[_expandedDays[index] pairs] count];
    return [_schedule.session count];
}

- (NSString *)tableView:(BUScheduleTableViewController *)tableView titleForAustronautAtIndex:(NSUInteger)index {
    if ([tableView type] == ScheduleTypeSemester)
        return index == 6 ? @"Предметов вне сетки расписания нет!" : @"Выходной!";
    return [[_schedule session] count] == 0 ? @"Расписания сессии нет!" : @"";
}

- (BUPairViewModel *)tableView:(BUScheduleTableViewController *)tableView
              viewModelForPair:(NSUInteger)pair
                         atDay:(NSUInteger)day {
    BUPairViewModel *pairVM = [[BUPairViewModel alloc] init];
    SUAIPair *pairModel;
    if ([tableView type] == ScheduleTypeSemester) {
        pairModel = [_expandedDays[day] pairs][pair];
        pairVM.time = [[pairModel time] stringValue];
        pairVM.type = [pairModel lessonType];
    } else {
        SUAIDay *day = _schedule.session[pair];
        pairModel = [day pairs][0];
        let *pairTime = [[pairModel time] stringValue];
        pairVM.time = [NSString stringWithFormat:@"%@ (%@:00-...)", [day name], [pairTime containsString:@"1"] ? @"10" : @"14"];
        pairVM.type = [[pairTime componentsSeparatedByString:@" "] firstObject];
    }
    pairVM.name = [pairModel name];
    if ([[_schedule entity] type] == EntityTypeGroup) {
        let *teacher = pairModel.teachers.firstObject;
        pairVM.subInfo = teacher.name;
        pairVM.teacherDegree = teacher.degree;
    } else {
        pairVM.subInfo = [[pairModel groups] componentsJoinedByString:@"; "];
    }
    pairVM.auditory = [[pairModel auditory] fullDescription];
    return pairVM;
}

- (UIColor *)headerColorForTableView:(BUScheduleTableViewController *)tableView {
    if ([tableView type] == ScheduleTypeSession)
        return [UIColor suaiPurpleColor];
    if (_weekIndex == 0)
        return [UIColor suaiBlueColor];
    return [UIColor suaiRedColor];
}

@end
