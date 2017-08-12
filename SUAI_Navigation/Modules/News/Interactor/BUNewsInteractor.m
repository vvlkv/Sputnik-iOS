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
    }
    return self;
}


#pragma mark - BUNewsDownloaderDelegate

- (void)newsLoaded:(NSArray *)news {
    [self.output didObtainNews:news];
}

- (void)failureLoading:(NSString *)failureText {
    [self.output didObtainFail];
}


- (void)obtainNews {
    
}

@end
