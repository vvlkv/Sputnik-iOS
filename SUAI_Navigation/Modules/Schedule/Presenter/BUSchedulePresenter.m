 //
//  BUSchedulePresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSchedulePresenter.h"
#import "BUScheduleStorage.h"
#import "BUScheduleRefactor.h"
#import "BUDay.h"
#import "BUPair.h"
#import "BUScheduleDataDisplayManager.h"
#import "BUSchedulePresenterState.h"
#import "NSArray+Codes.h"
#import "NSCalendar+CurrentDay.h"

@interface BUSchedulePresenter () {
    BUSchedulePresenterState *state;
    BUScheduleDataDisplayManager *displayManager;
    BUScheduleRefactor *refactor;
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
        refactor = [[BUScheduleRefactor alloc] init];
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
    NSUInteger foundedEntityIndex = 2;
    NSString *searchResult = nil;
    if ((searchResult = [refactor findTeacher:action inCodes:state.codes]) != nil) {
        foundedEntityIndex = 1;
        isDataSended = YES;
    }
    else if ((searchResult = [refactor findFroup:action inCodes:state.codes]) != nil) {
        foundedEntityIndex = 0;
        isDataSended = YES;
    }
    
    if (searchResult == nil) {
        [self.router passAuditory:action fromNavigationViewController:(UIViewController *)self.view];
    } else {
        [self.router pushDetailViewControllerFromViewController:(UIViewController *)self.view
                                                     withEntity:searchResult
                                                        andType:foundedEntityIndex];
    }
}

- (void)didPressCalendarAction {
    NSArray *data = @[[self prepareDataToOutput:state.unfilteredSchedule forWeek:0], [self prepareDataToOutput:state.unfilteredSchedule forWeek:1]];
    [self.router presentCalendarViewControllerFromViewController:(UIViewController *)self.view withData:data];
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
    displayManager.semesterSchedule = [@[[self prepareDataToOutput:state.unfilteredSchedule forWeek:0],
                                        [self prepareDataToOutput:state.unfilteredSchedule forWeek:1]] copy];
    displayManager.sessionSchedule = [@[schedule[1]] copy];
    [self.view updateView];
}

- (void)didObtainDate:(NSArray *)date {
    displayManager.date = date;
    displayManager.weekIndex = ([date[1] containsString:@"нечетная"]) ? 1 : 0;
    [self.view obtainStartScheduleScreen:[NSCalendar currentDay]];
    [NSCalendar weekIndex];
    [self.view updateWeekSegmentWithIndex:displayManager.weekIndex];
    [self.view updateDate];
}

- (void)didObtainCodes:(NSDictionary *)codes {
    state.codes = codes;
}

- (void)didDownloadCodes {
    state.connectionStatus = ConnectionStatusOnline;
    if ([self.view respondsToSelector:@selector(showSearchIcon)]) {
        [self.view showSearchIcon];
    }
    if (state.unfilteredSchedule == nil) {
        [self.input obtainScheduleForEntity:state.entityName andType:displayManager.entityType];
    }
}

- (void)didFailLoading {
    state.connectionStatus = ConnectionStatusOffline;
    if ([self.view respondsToSelector:@selector(hideSearchIcon)]) {
        [self.view hideSearchIcon];
    }
}

- (void)didEntityNotSelected {
    [self.view updateView];
}

- (void)didObtainEntityType:(NSUInteger)entityType {
    displayManager.entityType = entityType;
}

- (void)didObtainEntity:(NSString *)entity {
    state.entityName = entity;
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
    if (state.codes != nil && state.connectionStatus == ConnectionStatusOnline) {
        if (displayManager.entityType != 1 && ![teacher containsString:@";"])
            [contents addObject:teacher];
        for (NSString *group in groups) {
            if (![state.entityName containsString:group])
                [contents addObject:group];
        }
    }
    if (![auditory containsString:@"кафедры"]) {
        [contents addObject:auditory];
    }
    [self.view addAlertViewWithItems:contents];
}

- (void)didPressGoToSettingsButton {
    [self.router navigateTabBarToSettingsViewControllerFromViewController:(UIViewController *)self.view];
}


#pragma mark - Other

- (NSArray *)prepareDataToOutput:(NSArray *)data forWeek:(NSUInteger)week {
    if (data == nil)
        return nil;
    [refactor refactorScheduleFromData:data];
    displayManager.weekIndicators = [refactor indicators];
    return [refactor sortedScheduleForWeek:week];
}

@end
