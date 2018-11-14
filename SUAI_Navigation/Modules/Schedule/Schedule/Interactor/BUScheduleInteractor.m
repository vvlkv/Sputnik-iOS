//
//  BUScheduleInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleInteractor.h"
#import "BUScheduleStorage.h"
#import "BUScheduleDownloader.h"
#import "BUDateFormatter.h"
#import "BUAppDataContainer.h"
#import "NSCalendar+CurrentDay.h"

@interface BUScheduleInteractor () <BUScheduleDownloaderDelegate> {
    BUScheduleDownloader *downloader;
    BUScheduleStorage *storage;
    BUDateFormatter *dateFormatter;
    NSString *entity;
    NSUInteger type;
    BOOL isRoot;
    BOOL isCheckedNewSchedule;
}

@end

@implementation BUScheduleInteractor

- (instancetype)init
{
    self = [self initWithEntity:[[BUAppDataContainer instance] entity]
                         ofType:[[BUAppDataContainer instance] type]];
    if (self) {
        isRoot = YES;
        isCheckedNewSchedule = NO;
    }
    return self;
}

- (instancetype)initWithEntity:(NSString *)e
                        ofType:(NSUInteger)t
{
    self = [super init];
    if (self) {
        isRoot = NO;
        entity = e;
        type = t;
        downloader = [[BUScheduleDownloader alloc] init];
        dateFormatter = [[BUDateFormatter alloc] init];
        downloader.delegate = self;
        storage = [[BUScheduleStorage alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(settingsChanged:)
                                                     name:@"buSettingsChanged"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(haveCodes:)
                                                     name:@"buCodesLoaded"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachable:)
                                                     name:@"buInternetBecomeReachable"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notReachable:)
                                                     name:@"buInternetBecomeUnreachable"
                                                   object:nil];
    }
    return self;
}

#pragma mark - BUScheduleInteractorInput
#pragma mark - Required

- (void)obtainSchedule {
    NSDictionary *codes = [[BUAppDataContainer instance] entityCodes];
    if (isRoot) {
        NSArray *scheduleFromDataBase = [storage loadScheduleFromDataBase];
        if ([scheduleFromDataBase[0] count] != 0) {
            [self.output didObtainSchedule:scheduleFromDataBase];
            [self obtainPersonInfo];
            if (codes != nil) {
                [downloader loadScheduleForEntity:entity ofType:type usingCodes:codes];
            }
        } else if (entity == nil) {
            [self.output didEntityNotSelected];
        }
    } else {
        [downloader loadScheduleForEntity:entity
                                   ofType:type
                               usingCodes:codes];
    }
}

- (void)obtainDate {
    if (isRoot)
        [self.output didObtainDate:[dateFormatter dateFromWeek:[NSCalendar weekIndex]]];
}

- (void)reloadSchedule:(NSArray *)schedule {
    [storage deleteAllEntities];
    [storage writeScheduleToDataBase:schedule];
}


#pragma mark - BUScheduleDownloaderDelegate
#pragma mark - Required

- (void)codesLoaded {
    [self.output didObtainCodes:[downloader codes]];
    if (isRoot) {
        [downloader loadScheduleForEntity:entity andType:type];
    }
}

- (void)failedConnection {
    [self.output didFailLoading];
}


#pragma mark - Optional

- (void)scheduleLoaded:(NSDictionary *)data {
    BOOL isMock = NO;
    NSArray *mock = isMock ? [NSArray array] : data[@"Session"];
    [self.output didObtainSchedule:@[data[@"Semester"], mock]];
    [self obtainPersonInfo];
    if ([[storage loadScheduleFromDataBase][0] count] == 0 && isRoot) {
        [storage writeScheduleToDataBase:@[data[@"Semester"], mock]];
    }
}

#pragma mark - Root

- (void)settingsChanged:(NSNotification *)notification {
    [storage deleteAllEntities];
    type = [[BUAppDataContainer instance] type];
    entity = [[BUAppDataContainer instance] entity];
    NSDictionary *codes = [[BUAppDataContainer instance] entityCodes];
    [downloader loadScheduleForEntity:entity ofType:type usingCodes:codes];
    [self.output didNotShowAlert];
}

- (void)obtainPersonInfo {
    [self.output didObtainEntityType:type];
    [self.output didObtainEntity:entity];
}

#pragma mark - Internet

- (void)haveCodes:(NSNotification *)notification {
    NSDictionary *codes = [[BUAppDataContainer instance] entityCodes];
    if (codes != NULL) {
        [self.output didObtainCodes:codes];
        if (isRoot) {
            [downloader loadScheduleForEntity:entity andType:type];
        }
    }
}

- (void)reachable:(NSNotification *)notification {
    NSDictionary *codes = [[BUAppDataContainer instance] entityCodes];
    if (codes != NULL) {
        [self.output didObtainCodes:codes];
    }
}

- (void)notReachable:(NSNotification *)notification {
    [self.output didFailLoading];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buSettingsChanged" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buCodesLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buInternetBecomeReachable" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buInternetBecomeUnreachable" object:nil];
}

@end
