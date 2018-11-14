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

@interface BUGreetingsInteractor () {
//    BUScheduleDownloader *downloader;
    BOOL internetWasUnreachable;
}

@end

@implementation BUGreetingsInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        internetWasUnreachable = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachable:) name:@"buInternetBecomeReachable" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(unreachable:) name:@"buInternetBecomeUnreachable" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(gotCodes:) name:@"buCodesLoaded" object:nil];
    }
    return self;
}


#pragma mark - BUGreetingsInteractorInput

- (void)overwriteEntity:(NSString *)entity andType:(NSUInteger)type {
    [[BUAppDataContainer instance] overwriteEntityWithName:entity andType:type];
}


#pragma mark - BUScheduleDownloaderDelegate

//- (void)codesLoaded {
//    [[BUAppDataContainer instance] writeCodes:[downloader codes]];
//    [self.output didInternetBecomeReachable];
//    [self.output didObtainCodes:[downloader codes]];
//}

- (void)gotCodes:(NSNotification *)notification {
    NSDictionary *codes = [notification.userInfo valueForKey:@"codes"];
    [self.output didInternetBecomeReachable];
    if (codes != nil) {
        [self.output didObtainCodes:codes];
    }
}

- (void)failedConnection {
    [self.output didFailConnection];
}

- (void)reachable:(NSNotification *)notification {
}

- (void)unreachable:(NSNotification *)notification {
    [self.output didFailConnection];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"buInternetBecomeReachable"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"buCodesLoaded"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"buInternetBecomeUnreachable"
                                                  object:nil];
}

@end
