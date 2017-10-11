//
//  BUday.m
//  SUAI_Parser_New
//
//  Created by Виктор on 08.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUDay.h"

@interface BUDay () {
    NSMutableArray <BUPair *> *internalPairs;
}

@end

@implementation BUDay

- (instancetype)initWithDay:(NSString *)day
{
    self = [super init];
    if (self) {
        _day = day;
        internalPairs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addPair:(BUPair *)pair {
    [internalPairs addObject:pair];
}

- (NSArray *)pairs {
    return [internalPairs copy];
}

@end
