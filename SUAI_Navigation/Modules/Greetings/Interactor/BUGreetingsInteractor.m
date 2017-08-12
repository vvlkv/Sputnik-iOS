//
//  BUGreetingsInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGreetingsInteractor.h"
#import "BUScheduleDownloader.h"
#import "BUAppDataContainer.h"

@interface BUGreetingsInteractor () <BUScheduleDownloaderDelegate> {
    BUScheduleDownloader *downloader;
}

@end

@implementation BUGreetingsInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        downloader = [[BUScheduleDownloader alloc] init];
        downloader.delegate = self;
    }
    return self;
}


#pragma mark - BUGreetingsInteractorInput

- (void)overwriteEntity:(NSString *)entity andType:(NSUInteger)type {
    [[BUAppDataContainer instance] overwriteEntityWithName:entity andType:type];
}


#pragma mark - BUScheduleDownloaderDelegate

- (void)codesLoaded {
    [[BUAppDataContainer instance] writeCodes:[downloader codes]];
    [self.output didObtainCodes:[downloader codes]];
}

- (void)failedConnection {
    [self.output didFailConnection];
    
}

@end
