//
//  BUNewsDetailInfoPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoPresenter.h"
#import "SUAINews.h"

@interface BUNewsDetailInfoPresenter () {
    NSString *_newsId;
    SUAINews *_loadedNews;
}

@end

@implementation BUNewsDetailInfoPresenter

- (instancetype)initWithNewsId:(NSString *)newsId;
{
    self = [super init];
    if (self) {
        _newsId = newsId;
    }
    return self;
}


#pragma mark - BUNewsDetailInfoViewControllerOutput

- (void)viewDidLoad {
    [self.input obtainNews:_newsId];
}


#pragma mark - BUNewsDetailInfoInteractorOutput

- (void)didObtainNews:(SUAINews *)news {
    _loadedNews = news;
    [self.view updateContent];
}


- (void)didLoadFailed {
    [self.view loadFailed];
}

- (void)didChangeInternetReachability:(BOOL)isReachable {
    if (_loadedNews == nil)
        [self.input obtainNews:_newsId];
}


#pragma mark - BUNewsDetailInfoDataSource

- (SUAINews *)newsModel {
    return _loadedNews;
}

@end
