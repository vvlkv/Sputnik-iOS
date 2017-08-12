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
#import "BUScheduleStorage.h"
#import "BUDay.h"
#import "BUPair.h"
#import "BUAppDataContainer.h"

@interface BUScheduleInteractor () <BUScheduleDownloaderDelegate> {
    BUScheduleDownloader *downloader;
    BUScheduleStorage *storage;
    BOOL isRoot;
}

@end

@implementation BUScheduleInteractor

- (instancetype)initAsRoot:(BOOL)root {
    self = [super init];
    if (self) {
        downloader = [[BUScheduleDownloader alloc] init];
        downloader.delegate = self;
        isRoot = root;
        storage = [[BUScheduleStorage alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(settingsChanged:)
                                                     name:@"buSettingsChanged"
                                                   object:nil];
    }
    return self;
}


#pragma mark - BUScheduleInteractorInput
#pragma mark - Required

- (void)obtainScheduleForEntity:(NSString *)entity andType:(NSUInteger)type {
    if (entity != nil) {
         [downloader downloadScheduleForEntity:entity andType:type];
    }
}

#pragma mark - Optional

- (void)obtainSchedule {
    if (isRoot) {
        NSArray *scheduleFromDataBase = [storage loadScheduleFromDataBase];
        if ([scheduleFromDataBase[0] count] != 0) {
            [self.output didObtainSchedule:scheduleFromDataBase];
        }
    }
}


#pragma mark - BUScheduleDownloaderDelegate
#pragma mark - Required

- (void)codesLoaded {
    [[BUAppDataContainer instance] writeCodes:[downloader codes]];
    [self.output didDownloadCodes];
    [self.output didObtainDate:[downloader date]];
    [self.output didObtainCodes:[downloader codes]];
}

//TODO
- (void)failedConnection {
    
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
    [downloader downloadScheduleForEntity:[[BUAppDataContainer instance] entity] andType:[[BUAppDataContainer instance] type]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buSettingsChanged" object:nil];
}

@end
