//
//  BUCalendarPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 14.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCalendarPresenter.h"
#import "BUAppDataContainer.h"
#import "BUSchedulePresenterState.h"
#import "NSCalendar+CurrentDay.h"
#import "BUPairViewModel.h"
#import "BUScheduleDataDisplayManager.h"
#import "BUAppDataContainer.h"
#import "BUScheduleRefactor.h"
#import "BUDay.h"
#import "BUPair.h"
#import "BUScheduleContentDataSource.h"

@class UITableView;
@interface BUCalendarPresenter () <BUScheduleContentDelegate> {
    BUScheduleDataDisplayManager *displayManager;
    BUSchedulePresenterState *state;
    BUScheduleRefactor *refactor;
    id rootViewController;
}

@end

@implementation BUCalendarPresenter

- (instancetype)initWithData:(NSArray *)data
{
    self = [super init];
    if (self) {
        displayManager = [[BUScheduleDataDisplayManager alloc] init];
        displayManager.semesterSchedule = [data copy];
        state = [[BUSchedulePresenterState alloc] init];
        state.connectionStatus = ConnectionStatusOnline;
        state.codes = [[BUAppDataContainer instance] entityCodes];
        refactor = [[BUScheduleRefactor alloc] init];
    }
    return self;
}

- (instancetype)initWithData:(NSArray *)data andRootViewController:(id)viewController
{
    self = [super init];
    if (self) {
        rootViewController = viewController;
        displayManager = [[BUScheduleDataDisplayManager alloc] init];
        displayManager.semesterSchedule = [data copy];
        state = [[BUSchedulePresenterState alloc] init];
        state.connectionStatus = ConnectionStatusOnline;
        state.codes = [[BUAppDataContainer instance] entityCodes];
        refactor = [[BUScheduleRefactor alloc] init];
    }
    return self;
}

#pragma mark - BUCalendarViewControllerOutput

- (void)viewDidLoad {
    [self.view setDayIndex:[NSCalendar currentDay]];
    displayManager.weekIndex = [NSCalendar weekIndexFromDate:[NSDate date]];
    [self.view reloadView];
}

- (void)didSelectDate:(NSDate *)date {
    displayManager.weekIndex = [NSCalendar weekIndexFromDate:date];
    [self.view setDayIndex:[NSCalendar dayFromDate:date]];
    [self.view reloadView];
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

- (void)didPressAlertAction:(NSString *)action {
    [self.view dismiss];
    BOOL isDataSended = NO;
    NSUInteger foundedEntityIndex = 2;
    NSString *searchResult = nil;
    
    if ((searchResult = [refactor findTeacher:action inCodes:state.codes]) != nil) {
        state.entityName = searchResult;
        foundedEntityIndex = 1;
        isDataSended = YES;
    }
    else if ((searchResult = [refactor findFroup:action inCodes:state.codes]) != nil) {
        state.entityName = searchResult;
        foundedEntityIndex = 0;
        isDataSended = YES;
    }
    
    if (searchResult == nil) {
        [self.router passAuditory:action fromNavigationViewController:(UIViewController *)rootViewController];
    } else {
        [self.router pushDetailViewControllerFromViewController:(UIViewController *)rootViewController
                                                     withEntity:searchResult
                                                        andType:foundedEntityIndex];
    }
}

- (id)dataSource {
    return displayManager;
}

- (id)delegate {
    return self;
}

@end
