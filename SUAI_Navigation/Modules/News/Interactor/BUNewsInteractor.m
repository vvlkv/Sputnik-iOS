//
//  BUNewsInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsInteractor.h"
#import "BUNewsDownloader.h"

@interface BUNewsInteractor () <BUNewsDownloaderDelegate> {
    BUNewsDownloader *downloader;
}

@end

@implementation BUNewsInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        downloader = [[BUNewsDownloader alloc] init];
        downloader.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachable:) name:@"buInternetBecomeReachable" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notReachable:) name:@"buInternetBecomeUnreachable" object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"buInternetBecomeReachable"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"buInternetBecomeUnreachable"
                                                  object:nil];
}


#pragma mark - BUNewsDownloaderDelegate

- (void)newsLoaded:(NSArray *)news {
    [self.output didObtainNews:news];
}

- (void)failureLoading:(NSString *)failureText {
    [self.output didObtainFail];
}

#pragma mark - Internet connection

- (void)reachable:(NSNotification *)notification {
    [downloader loadNews];
}

//TODO
- (void)notReachable:(NSNotification *)notification {
    [self.output didObtainFail];
}

@end
