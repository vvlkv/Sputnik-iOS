//
//  BUNewsPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsPresenter.h"
#import "BUNewsPresenterState.h"
#import "BUNews.h"

@interface BUNewsPresenter () {
    BUNewsPresenterState *state;
}

@end

@implementation BUNewsPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        state = [[BUNewsPresenterState alloc] init];
    }
    return self;
}


#pragma mark - BUNewsViewControllerOutput

- (void)viewDidLoad {
}

- (void)didSelectedCellAtIndex:(NSUInteger)index {
    BUNews *news = (BUNews *)[state news][index];
    [self.router pushDetailNewsInfo:news.publicationId fromViewController:(UIViewController *)self.view];
}


#pragma mark - BUNewsInteractorOutput

- (void)didObtainNews:(NSArray *)news {
    state.news = news;
    [self.view updateContent];
}

- (void)didObtainFail {
    [self.view failedConnection];
}


#pragma mark - BUNewsDataSource

- (NSUInteger)numberOfItems {
    return [[state news] count];
}

- (BUNews *)newsAtIndex:(NSUInteger)index {
    BUNews *news = [state news][index];
    return news;
}

@end
