 //
//  BUSchedulePresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSchedulePresenter.h"
#import "BUScheduleStorage.h"
#import "BUDay.h"
#import "BUPair.h"
#import "BUScheduleDataDisplayManager.h"
#import "BUSchedulePresenterState.h"
#import "NSArray+Codes.h"
#import "NSCalendar+CurrentDay.h"

@interface BUSchedulePresenter () {
    BUSchedulePresenterState *state;
    BUScheduleDataDisplayManager *displayManager;
}

@end

@implementation BUSchedulePresenter


#pragma mark - Root

- (instancetype)initWithEntity:(NSString *)entity andType:(NSUInteger)type
{
    self = [super init];
    if (self) {
        state = [[BUSchedulePresenterState alloc] init];
        displayManager = [[BUScheduleDataDisplayManager alloc] init];
        state.isOnline = NO;
        state.entityName = entity;
        displayManager.entityType = type;
    }
    return self;
}


#pragma mark - BUScheduleViewControllerOutput
#pragma mark - Required

- (void)viewDidLoad {
    [self.input obtainSchedule];
}

- (void)didChangeWeekSegment:(NSUInteger)index {
    displayManager.weekIndex = index;
    displayManager.schedule[0] = [self prepareDataToOutput:state.unfilteredSchedule forWeek:index];
    [self.view updateView];
}

#pragma mark - Optional

- (void)didChangeScheduleSegment:(NSUInteger)index {
    displayManager.scheduleIndex = index;
}

- (void)didPressSearchButton {
    NSArray *searchItems = @[[NSArray codesFromDictionary:state.codes[@"Semester"][@"Groups"]],
                             [NSArray codesFromDictionary:state.codes[@"Semester"][@"Teachers"]]];
    [self.router presentSearchViewControllerWithItems:searchItems fromViewController:(UIViewController *)self.view andPresenter:self];
}

- (void)didPressAlertAction:(NSString *)action {
    BOOL isDataSended = NO;
    for (NSString *name in [state.codes[@"Semester"][@"Teachers"] allKeys]) {
        if ([name containsString:action]) {
            state.entityName = action;
            [self.router pushDetailViewControllerFromViewController:(UIViewController *)self.view withEntity:name andType:1];
            isDataSended = YES;
        }
    }
    for (NSString *name in [state.codes[@"Semester"][@"Groups"] allKeys]) {
        if ([name containsString:action]) {
            state.entityName = action;
            [self.router pushDetailViewControllerFromViewController:(UIViewController *)self.view withEntity:name andType:0];
            isDataSended = YES;
        }
    }
    if (!isDataSended) {
        [self.router passAuditory:action fromNavigationViewController:(UIViewController *)self.view];
    }
}

- (id <BUScheduleContentDataSource>)dataSource {
    return displayManager;
}

- (id <BUScheduleContentDelegate>)delegate {
    return self;
}


#pragma mark - BUScheduleInteractorOutput
#pragma mark - Required

- (void)didObtainSchedule:(NSArray *)schedule {
    state.unfilteredSchedule = schedule[0];
    displayManager.schedule = [@[[self prepareDataToOutput:state.unfilteredSchedule forWeek:displayManager.weekIndex], schedule[1]] mutableCopy];
    [self.view updateWeekSegmentWithIndex:displayManager.weekIndex];
    [self.view obtainStartScheduleScreen:[NSCalendar currentDay]];
    [self.view updateView];
}

- (void)didObtainDate:(NSString *)date {
    displayManager.date = date;
    displayManager.weekIndex = ([date containsString:@"нечетная"]) ? 1 : 0;
}

- (void)didObtainCodes:(NSDictionary *)codes {
    state.codes = codes;
}

- (void)didDownloadCodes {
    state.isOnline = YES;
    if ([self.view respondsToSelector:@selector(showSearchIcon)]) {
        [self.view showSearchIcon];
    }
    [self.input obtainScheduleForEntity:state.entityName andType:displayManager.entityType];
}


#pragma mark - BUScheduleRouterOutput

- (void)didObtainNewSchedule:(NSString *)entity ofType:(NSUInteger)type {
    [self.router pushDetailViewControllerFromViewController:(UIViewController *)self.view withEntity:entity andType:type];
}


#pragma mark - BUScheduleContentDelegate

- (void)didPressedCellAtIndex:(NSUInteger)index fromDay:(NSUInteger)day {
    BUPair *pair;
    if (displayManager.scheduleIndex == 0) {
        BUDay *currentDay = (BUDay *)[displayManager semesterSchedule][day];
        pair = (BUPair *)[currentDay pairs][index];
    } else {
        BUDay *currentDay = (BUDay *)[displayManager sessionSchedule][index];
        pair = (BUPair *)[currentDay pairs][0];
    }
    
    NSString *teacher = [[[[[pair teacherName] componentsSeparatedByString:@" -"] firstObject] componentsSeparatedByString:@": "] lastObject];
    NSArray *groups = [[[[[pair groups] componentsSeparatedByString:@":"] lastObject] substringFromIndex:1] componentsSeparatedByString:@"; "];
    NSString *auditory = [pair auditory];
    NSMutableArray *contents = [NSMutableArray array];
    if (state.codes != nil) {
        if (displayManager.entityType != 1 && ![teacher containsString:@";"])
            [contents addObject:teacher];
        for (NSString *group in groups) {
            if (![state.entityName containsString:group])
                [contents addObject:group];
        }
    }
    [contents addObject:auditory];
    [self.view addAlertViewWithItems:contents];
}


#pragma mark - Other

- (NSArray *)prepareDataToOutput:(NSArray *)data forWeek:(NSUInteger)week {
    NSArray *days = @[@"Понедельник", @"Вторник", @"Среда", @"Четверг", @"Пятница", @"Суббота", @"Вне"];
    NSMutableArray *outputData = [[NSMutableArray alloc] initWithCapacity:7];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        [array addObject:[NSArray array]];
    }
    for (BUDay *day in data) {
        BUDay *newDay = [[BUDay alloc] initWithDay:[day day]];
        for (BUPair *pair in [day pairs]) {
            if ((NSUInteger)[pair color] == (NSUInteger)week || (NSUInteger)[pair color] == 2) {
                [newDay addPair:pair];
            }
        }
        if ([[newDay pairs] count] != 0) {
            [outputData addObject:newDay];
        }
    }
    for (int i = 0; i < 7; i++) {
        NSUInteger barIndex = [outputData indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([[(BUDay *)obj day] containsString:days[i]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        if (barIndex != NSNotFound) {
            [array replaceObjectAtIndex:i withObject:outputData[barIndex]];
        }
    }
    return array;
}

@end
