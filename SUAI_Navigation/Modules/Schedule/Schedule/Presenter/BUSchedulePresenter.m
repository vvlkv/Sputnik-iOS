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
#import "BUScheduleComparator.h"

@interface BUSchedulePresenter () {
    BUSchedulePresenterState *state;
    BUScheduleDataDisplayManager *displayManager;
    BUScheduleRefactor *refactor;
    BOOL isShowAlert;
}

@end

@implementation BUSchedulePresenter


#pragma mark - Root

- (instancetype)init
{
    self = [super init];
    if (self) {
        state = [[BUSchedulePresenterState alloc] init];
        displayManager = [[BUScheduleDataDisplayManager alloc] init];
        refactor = [[BUScheduleRefactor alloc] init];
        isShowAlert = YES;
    }
    return self;
}

#pragma mark - BUScheduleViewControllerOutput
#pragma mark - Required

- (void)didChangeWeekSegment:(NSUInteger)index {
    
    if ([displayManager weekIndex] != index) {
        displayManager.weekIndex = index;
        [self.view update];
    }
}

#pragma mark - Optional

- (void)didChangeScheduleSegment:(NSUInteger)index {
    displayManager.scheduleIndex = index;
}

- (void)didPressSearchButton {
    NSArray *searchItems = @[[NSArray codesFromDictionary:state.codes[@"Semester"][@"Groups"]],
                             [NSArray codesFromDictionary:state.codes[@"Semester"][@"Teachers"]]];
    [self.router presentSearchViewControllerWithItems:searchItems
                                   fromViewController:(UIViewController *)self.view
                                         andPresenter:self];
}

- (void)didPressAlertAction:(NSString *)action {
    NSUInteger foundedEntityIndex = 2;
    NSString *searchResult = nil;
    if ((searchResult = [refactor findTeacher:action]) != nil) {
        foundedEntityIndex = 1;
    }
    else if ((searchResult = [refactor findGroup:action]) != nil) {
        foundedEntityIndex = 0;
    }
    
    if (searchResult != nil) {
        [self.router pushDetailViewControllerFromViewController:(UIViewController *)self.view
                                                     withEntity:searchResult
                                                        andType:foundedEntityIndex];
    } else {
        [self.router passAuditory:action fromNavigationViewController:(UIViewController *)self.view];
    }
}

- (void)didPressCalendarAction {
    NSArray *data = @[[self prepareDataToOutput:state.unfilteredSchedule[0] forWeek:0],
                      [self prepareDataToOutput:state.unfilteredSchedule[0] forWeek:1]];
    [self.router presentCalendarViewControllerFromViewController:(UIViewController *)self.view withData:data];
}

- (id)dataSource {
    return displayManager;
}

- (id <BUScheduleContentDelegate>)delegate {
    return self;
}

- (void)viewDidLoad {
    [self.input obtainDate];
    [self.view obtainStartScheduleScreen:[NSCalendar currentDay]];
    [self.input obtainSchedule];
}

- (void)viewDidLoadWithWeekSegmentIndex:(NSUInteger)index {
    displayManager.weekIndex = index;
    [self.view obtainStartScheduleScreen:[NSCalendar currentDay]];
    [self.input obtainSchedule];
}

#pragma mark - BUScheduleInteractorOutput
#pragma mark - Required

- (void)didObtainSchedule:(NSArray *)schedule {
    if (state.unfilteredSchedule != nil) {
        if ([BUScheduleComparator compareActualSchedule:state.unfilteredSchedule withNewSchedule:schedule] != NSOrderedSame) {
            state.unfilteredSchedule = schedule;
//            if (isShowAlert)
//                [self.view showNewScheduleAlert];
            isShowAlert = YES;
            [self loadUnfilteredScheduleAndShow:schedule];
            [self.input reloadSchedule:schedule];
        }
        else {
            [self loadUnfilteredScheduleAndShow:state.unfilteredSchedule];
        }
    } else {
        [self loadUnfilteredScheduleAndShow:schedule];
    }
}

- (void)didObtainDate:(NSArray *)date {
    displayManager.weekIndex = ([date[1] containsString:@"нечетная"]) ? 1 : 0;
    [self.view updateWeekSegmentWithIndex:displayManager.weekIndex];
    if ([self.view respondsToSelector:@selector(updateDate:andWeek:)]) {
        [self.view updateDate:date[0] andWeek:date[1]];
    }
}

- (void)didObtainCodes:(NSDictionary *)codes {
    state.connectionStatus = ConnectionStatusOnline;
    if ([self.view respondsToSelector:@selector(showSearchIcon)]) {
        [self.view showSearchIcon];
    }
    state.codes = codes;
}

- (void)didFailLoading {
    state.connectionStatus = ConnectionStatusOffline;
    if ([self.view respondsToSelector:@selector(hideSearchIcon)]) {
        [self.view hideSearchIcon];
    }
}

- (void)didEntityNotSelected {
    [self.view loadFailView];
}

- (void)didObtainEntityType:(NSUInteger)entityType {
    displayManager.entityType = (EntityType)entityType;
}

- (void)didObtainEntity:(NSString *)entity {
    state.entityName = entity;
}

- (void)didNotShowAlert {
    isShowAlert = NO;
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
    NSMutableArray *contents = [NSMutableArray array];
    if (state.connectionStatus == ConnectionStatusOnline) {
        if (displayManager.entityType == EntityTypeGroup && ![teacher containsString:@";"])
            [contents addObject:teacher];
        for (NSString *group in groups) {
            if (![state.entityName containsString:group])
                [contents addObject:group];
        }
    }
    NSString *auditory = [pair auditory];
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
        return [NSArray array];
    [refactor refactorScheduleFromData:data];
    displayManager.weekIndicators = [refactor indicators];
    return [refactor sortedScheduleForWeek:week];
}

- (void)loadUnfilteredScheduleAndShow:(NSArray *)schedule {
    state.unfilteredSchedule = schedule;
    displayManager.semesterSchedule = [@[[self prepareDataToOutput:state.unfilteredSchedule[0] forWeek:0],
                                         [self prepareDataToOutput:state.unfilteredSchedule[0] forWeek:1]] copy];
    displayManager.sessionSchedule = [@[schedule[1]] copy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0001 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.view loadScheduleView];
    });
}

@end
