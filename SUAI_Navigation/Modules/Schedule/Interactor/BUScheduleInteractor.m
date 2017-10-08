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
#import "BUDay.h"
#import "BUPair.h"
#import "BUAppDataContainer.h"
#import "NSCalendar+CurrentDay.h"

@interface BUScheduleInteractor () <BUScheduleDownloaderDelegate> {
    BUScheduleDownloader *downloader;
    BUScheduleStorage *storage;
    BUDateFormatter *dateFormatter;
    BOOL isRoot;
}

@end

@implementation BUScheduleInteractor

- (instancetype)initAsRoot:(BOOL)root {
    self = [super init];
    if (self) {
        downloader = [[BUScheduleDownloader alloc] init];
        dateFormatter = [[BUDateFormatter alloc] init];
        downloader.delegate = self;
        [downloader loadCodes];
        isRoot = root;
        storage = [[BUScheduleStorage alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(settingsChanged:)
                                                     name:@"buSettingsChanged"
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

- (void)obtainScheduleForEntity:(NSString *)entity andType:(NSUInteger)type {
    if (entity != nil) {
         [downloader downloadScheduleForEntity:entity andType:type];
    } else {
        [self.output didEntityNotSelected];
    }
}

#pragma mark - Optional

- (void)obtainSchedule {
//    [self.output didObtainDate:[dateFormatter dateFromWeek:[[BUAppDataContainer instance] weekType]]];
    [self.output didObtainDate:[dateFormatter dateFromWeek:[NSCalendar weekIndex]]];
    if (isRoot) {
        NSArray *scheduleFromDataBase = [storage loadScheduleFromDataBase];
        if ([scheduleFromDataBase[0] count] != 0) {
            [self.output didObtainSchedule:scheduleFromDataBase];
        }
    }
    if ([[BUAppDataContainer instance] entity] == nil) {
        [self.output didEntityNotSelected];
    }
}


#pragma mark - BUScheduleDownloaderDelegate
#pragma mark - Required

- (void)codesLoaded {
    [[BUAppDataContainer instance] writeCodes:[downloader codes]];
    [self.output didDownloadCodes];
//    NSString *date = [downloader date];
    
//    NSUInteger weekType = [BUDateFormatter weekTypeFromDate:date];
//    NSUInteger weekType2 = [NSCalendar weekIndex];
//    [[BUAppDataContainer instance] writeWeekType:weekType];
    [self.output didObtainCodes:[downloader codes]];
}

- (void)failedConnection {
    [self.output didFailLoading];
}

#pragma mark - Optional

- (void)dataLoaded:(NSDictionary *)data {
    [self.output didObtainSchedule:@[data[@"Semester"], data[@"Session"]]];
    if ([[storage loadScheduleFromDataBase][0] count] == 0 && isRoot) {
        [storage writeScheduleToDataBase:@[data[@"Semester"], data[@"Session"]]];
    }
}


#pragma mark - Root

- (void)settingsChanged:(NSNotification *)notification {
    [storage deleteAllEntities];
    NSUInteger entityType = [[BUAppDataContainer instance] type];
    NSString *entityName = [[BUAppDataContainer instance] entity];
    [downloader downloadScheduleForEntity:entityName andType:entityType];
    [self.output didObtainEntityType:entityType];
    [self.output didObtainEntity:entityName];
}


#pragma mark - Internet

- (void)reachable:(NSNotification *)notification {
    if ([[downloader codes] count] != 0) {
        [downloader loadCodes];
    }
}

- (void)notReachable:(NSNotification *)notification {
    [self.output didFailLoading];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buSettingsChanged" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buInternetBecomeReachable" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buInternetBecomeUnreachable" object:nil];
}

@end
