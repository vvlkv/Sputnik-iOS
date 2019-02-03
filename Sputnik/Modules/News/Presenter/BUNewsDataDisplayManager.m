//
//  BUNewsDataDisplayManager.m
//  SUAI_Navigation
//
//  Created by Виктор on 23/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNewsDataDisplayManager.h"

#import "SUAINews.h"

#import <UIKit/UIKit.h>

@interface BUNewsDataDisplayManager() {
    NSArray <SUAINews *> *_news;
}

@end

@implementation BUNewsDataDisplayManager

- (instancetype)initWithData:(NSArray <SUAINews *> *)news {
    self = [super init];
    if (self) {
        _news = news;
    }
    return self;
}


#pragma mark - UITableViewDataSource ??

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
