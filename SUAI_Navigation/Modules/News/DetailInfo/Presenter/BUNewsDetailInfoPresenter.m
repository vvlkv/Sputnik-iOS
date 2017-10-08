//
//  BUNewsDetailInfoPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoPresenter.h"
#import "BUNews.h"

@interface BUNewsDetailInfoPresenter () {
    BUNews *loadedNews;
}

@end

@implementation BUNewsDetailInfoPresenter


#pragma mark - BUNewsDetailInfoViewControllerOutput

- (void)viewDidLoad {
    [self.input obtainNews];
}


#pragma mark - BUNewsDetailInfoInteractorOutput

- (void)didObtainNews:(id)news {
    loadedNews = (BUNews *)news;
    [self.view updateContent];
}

- (void)didLoadFailed {
    [self.view loadFailed];
}


#pragma mark - BUNewsDetailInfoDataSource

- (BUNews *)newsModel {
    return loadedNews;
}

@end
