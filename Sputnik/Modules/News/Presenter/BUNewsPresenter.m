//
//  BUNewsPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsPresenter.h"
#import "SUAINews.h"

@interface BUNewsPresenter () {
    NSArray <SUAINews *> *_news;
}

@end

@implementation BUNewsPresenter

#pragma mark - BUNewsViewControllerOutput

- (void)didSelectedCellAtIndex:(NSUInteger)index {
    [self.router pushDetailNewsInfo:[_news[index] publicationId]
                 fromViewController:(UIViewController *)self.view];
}

- (void)viewDidLoad {
    if (_news == nil)
        [self.input obtainNews];
    else
        [self.view updateContent];
}


#pragma mark - BUNewsInteractorOutput

- (void)didObtainNews:(NSArray<SUAINews *> *)news {
    _news = news;
    [self.view updateContent];
}

- (void)didObtainFail {
    [self.view showFailMessage];
}

- (void)didChangeInternetReachability:(BOOL)isReachable {
    if (_news == nil)
        [self.input obtainNews];
}


#pragma mark - BUNewsDataSource

- (NSUInteger)numberOfItems {
    return [_news count];
}

- (SUAINews *)newsAtIndex:(NSUInteger)index {
    return _news[index];
}

@end
