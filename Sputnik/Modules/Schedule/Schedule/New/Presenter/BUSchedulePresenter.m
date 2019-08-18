//
//  BUScheduleNewPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUSchedulePresenter.h"
#import "BUScheduleInteractorInput.h"
#import "BUScheduleViewControllerInput.h"

#import "BUScheduleDataDisplayManager.h"
#import "SUAISchedule.h"

#import "BUScheduleRouter.h"

#import "BUAppDataContainer.h"

#import "SUAIEntity.h"
#import "SUAIPair.h"
#import "SUAIAuditory.h"
#import "SUAIError.h"

@interface BUSchedulePresenter()<BUScheduleTableViewControllerDelegate> {
    BUScheduleDataDisplayManager *_dataManager;
    NSString *_entity;
    NSUInteger _type;
    NSUInteger _dayIndex;
    NSUInteger _weekIndex;
    BOOL codesAvailable;
    BOOL isInitial;
}

@end

@implementation BUSchedulePresenter


#pragma mark - Init

- (instancetype)init {
    self = [self initWithEntityName:[BUAppDataContainer instance].entity
                            andType:[BUAppDataContainer instance].type];
    if (self) {
        isInitial = YES;
    }
    return self;
}

- (instancetype)initWithEntityName:(NSString *)name
                           andType:(NSUInteger)type {
    self = [super init];
    if (self) {
        _entity = name;
        _type = type;
        codesAvailable = NO;
        isInitial = NO;
    }
    return self;
}

- (void)p_showSchedule:(SUAISchedule *)schedule {
    [self.view hideProgress];
    _dataManager = [[BUScheduleDataDisplayManager alloc] initWithSchedule:schedule];
    _dataManager.weekIndex = _weekIndex;
    [self.view dataSource:_dataManager];
    [self.view delegate:self];
    [self.view updateDayMarkers:[_dataManager createMarkers]];
}

#pragma mark - BUScheduleNewInteractorOutput

- (void)didObtainSchedule:(SUAISchedule *)schedule {
    if (_dataManager != nil) {
        if (![_dataManager.schedule isEqual:schedule]) {
            [self.input writeScheduleToCoreData:schedule];
            if ([schedule.entity isEqual:_dataManager.schedule.entity])
                [self.view showAlertController:@"Обновление расписания" message:@"Обнаружено новое расписание."];
            [self p_showSchedule:schedule];
        }
    } else {
        [self.view createScheduleViews:_dayIndex];
        [self p_showSchedule:schedule];
    }
}

- (void)didScheduleFaultLoadingWithError:(SUAIError *)error {
    if (_dataManager != nil)
        return;
    switch ([error code]) {
        case SUAIErrorNetworkFault:
            [self.view showFailMessage:@"Отсутствует подключение к сети :(" withButton:NO];
            break;
        default:
            [self.view showFailMessage:@"Hе удалось загрузить расписание с сервера :(" withButton:NO];
            break;
    }
}

- (void)didObtainDate:(NSString *)date andWeek:(NSString *)week {
    [self.view updateDate:date andWeek:week];
}

- (void)didObtainDayIndex:(NSUInteger)index {
    _dayIndex = index;
}

- (void)didObtainWeekIndex:(NSUInteger)index {
    _weekIndex = index;
    [self.view updateWeekIndex:_weekIndex];
}

- (void)didChangeInternetReachability:(BOOL)isReachable {
    if (codesAvailable)
        [self.view showSearchIconVisibility:isReachable];
    if (_dataManager == nil && _entity != nil) {
        [self.input obtainScheduleFromNetworkForEntity:_entity type:_type];
        [self.view showProgress];
    }
}

- (void)didLoadCodes {
    codesAvailable = YES;
    if (_dataManager == nil && _entity != nil) {
        [self.input obtainScheduleFromNetworkForEntity:_entity type:_type];
        [self.view showProgress];
    } else {
        [self.view hideProgress];
    }
    if (isInitial)
        [self.view showSearchIconVisibility:YES];
}

- (void)didChangeEntityName:(NSString *)name andType:(NSUInteger)type {
    if (!isInitial)
        return;
    _entity = name;
    _type = type;
    [self.input obtainScheduleFromNetworkForEntity:_entity type:_type];
    [self.view updateEntityName:_entity];
}


#pragma mark - BUScheduleNewViewControllerOutput

- (void)viewDidLoad {
    if (_entity == nil) {
        [self.view showChooseEntityMessage];
    } else {
        [self.input obtainDate];
        [self.input obtainDayIndex];
        if (isInitial) {
            [self.input obtainWeekIndex];
            [self.input obtainScheduleFromCoreDataForEntity:_entity type:_type];
        } else {
            [self.view showProgress];
        }
        [self.input obtainScheduleFromNetworkForEntity:_entity type:_type];
        [self.view updateEntityName:_entity];
    }
}

- (void)didChangeWeekIndex:(NSUInteger)index {
    _weekIndex = index;
    [_dataManager setWeekIndex:_weekIndex];
    [self.view updateSemester];
}

- (void)didTapOnCalendar {
    [self.router presentCalendarViewControllerFromViewController:(UIViewController *)self.view withSchedule:_dataManager.schedule];
}

- (void)didTapOnSearch {
    [self.router presentSearchViewControllerFromViewController:(UIViewController *)self.view];
}


#pragma mark - BUScheduleTableViewControllerDelegate

- (void)tableView:(BUScheduleTableViewController *)tableView
    didSelectPair:(NSUInteger)pairIndex
            atDay:(NSUInteger)dayIndex {
    
    SUAIPair *pair = [_dataManager pairAtIndex:pairIndex day:dayIndex scheduleType:[tableView type]];
    
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
    if ([[pair auditory] building] == BM && ![[[pair auditory] number] isEqualToString:@""]) {
        [items addObject:[[pair auditory] number]];
        [items addObject:@"Показать на карте"];
    }
    
    __weak typeof(self) welf = self;
    if ([items count] > 0) {
        [welf.view showAlertControllerWithItems:items selected:^(NSInteger index) {
            NSInteger type = -1;
            if ([groups containsObject:items[index]])
                type = 0;
            else if ([teachers containsObject:items[index]])
                type = 1;
            else if ([[[pair auditory] number] containsString:items[index]])
                type = 2;
            if (type == -1) {
                [welf.router showAuditory:[[pair auditory] number] fromViewController:(UIViewController *)welf.view];
            } else {
                [welf.router pushScheduleViewControllerFromViewController:(UIViewController *)welf.view withEntity:items[index] type:type];
            }
        }];
    }
}


#pragma mark - BUScheduleNewRouterOutput

- (void)didFindEntity:(SUAIEntity *)entity {
    [self.router pushScheduleViewControllerFromViewController:(UIViewController *)self.view withEntity:[entity name] type:[entity type]];
}

@end
