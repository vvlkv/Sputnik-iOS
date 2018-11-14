//
//  BUNewsDownloader.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDownloader.h"
#import "BUDownloader+News.h"
#import "BUSUAIParser+News.h"
#import "BUNews.h"
#import <UIKit/UIKit.h>

@interface BUNewsDownloader () {
    __block NSArray *news;
    NSUInteger totalNews;
}

@property (assign, nonatomic) NSUInteger loadingCounter;

@end

@implementation BUNewsDownloader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loadingCounter = 0;
        [self addObserver:self
               forKeyPath:@"loadingCounter"
                  options:0
                  context:nil];
    }
    return self;
}

- (void)loadNews {
    __weak typeof(self) welf = self;
    [BUDownloader loadNewsPageWithSuccess:^(NSData *data) {
        self->news = [BUSUAIParser allNewsFromData:data];
        self->totalNews = [self->news count];
        for (BUNews *currentNews in self->news) {
            [BUDownloader loadImage:currentNews.imageSource success:^(NSData *data) {
                currentNews.image = [UIImage imageWithData:data];
                welf.loadingCounter++;
            } fail:^(NSString *fail) {
            }];
        }
    } fail:^(NSString *fail) {
        [welf.delegate failureLoading:fail];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (_loadingCounter == totalNews) {
        [self.delegate newsLoaded:news];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"loadingCounter"];
}

@end
