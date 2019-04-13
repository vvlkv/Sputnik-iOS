//
//  BUSearchResultsViewModel.m
//  Sputnik
//
//  Created by Виктор on 02/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUSearchResultsViewModel.h"

@implementation BUSearchResultsViewModel

- (instancetype)init {
    return [self initWithName:@"" andEntities:[NSArray array]];
}

- (instancetype)initWithName:(NSString *)name andEntities:(NSArray<SUAIEntity *> *)entities {
    self = [super init];
    if (self) {
        _name = name;
        _entities = entities;
    }
    return self;
}

@end
