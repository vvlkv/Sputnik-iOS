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
    BOOL internetWasUnreachable;
}

@end

@implementation BUGreetingsInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        downloader = [[BUScheduleDownloader alloc] init];
        [downloader loadCodes];
        internetWasUnreachable = NO;
        downloader.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachable:) name:@"buInternetBecomeReachable" object:nil];
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
    [self.output didInternetBecomeReachable];
    [self.output didObtainCodes:[downloader codes]];
}

- (void)failedConnection {
    internetWasUnreachable = YES;
    [self.output didFailConnection];
}

- (void)reachable:(NSNotification *)notification {
    if (internetWasUnreachable) {
        [downloader loadCodes];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"buInternetBecomeReachable"
                                                  object:nil];
}

@end
