//
//  BUNewsDetailInfoDownloader.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoDownloader.h"
#import "BUDownloader+News.h"
#import "BUSUAIParser+News.h"
#import "BUNews.h"
#import <UIKit/UIKit.h>

@interface BUNewsDetailInfoDownloader () {
}

@end

@implementation BUNewsDetailInfoDownloader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)loadNews:(NSString *)newsId {
    [BUDownloader loadNewsPage:newsId success:^(NSData *data) {
        BUNews *loadedNews = [BUSUAIParser loadNewsFromData:data];
        [BUDownloader loadImage:loadedNews.imageSource success:^(NSData *data) {
            loadedNews.image = [UIImage imageWithData:data];
            [self.delegate newsLoaded:loadedNews];
        } fail:^(NSString *fail) {
            NSLog(@"ERROR:%@", fail);
        }];
    } fail:^(NSString *fail) {
        NSLog(@"ERROR:%@", fail);
    }];
}

@end
