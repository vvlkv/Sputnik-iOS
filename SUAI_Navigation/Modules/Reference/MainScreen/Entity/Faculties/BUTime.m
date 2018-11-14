//
//  BUTime.m
//  SUAI_Navigation
//
//  Created by Виктор on 26/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTime.h"

@implementation BUTime


#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BUTime *time = [[[self class] alloc] init];
    time.day = _day;
    time.time = _time;
    return time;
}

@end
