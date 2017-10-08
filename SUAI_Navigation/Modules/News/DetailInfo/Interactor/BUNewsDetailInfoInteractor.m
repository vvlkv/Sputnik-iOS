//
//  BUNewsDetailInfoInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoInteractor.h"
#import "BUNewsDetailInfoDownloader.h"

@interface BUNewsDetailInfoInteractor () <BUNewsDetailInfoDownloaderDelegate> {
    BUNewsDetailInfoDownloader *downloader;
    NSString *newsIdentificator;
}

@end

@implementation BUNewsDetailInfoInteractor

- (instancetype)initWithNewsId:(NSString *)newsId
{
    self = [super init];
    if (self) {
        downloader = [[BUNewsDetailInfoDownloader alloc] init];
        downloader.delegate = self;
        newsIdentificator = newsId;
    }
    return self;
}


#pragma mark - BUNewsDetailInfoDownloaderDelegate

- (void)newsLoaded:(id)news {
    [self.output didObtainNews:news];
}

- (void)loadFailed {
    [self.output didLoadFailed];
}


#pragma mark - BUNewsDetailInfoInteractorInput

- (void)obtainNews {
    [downloader loadNews:newsIdentificator];
}

@end
