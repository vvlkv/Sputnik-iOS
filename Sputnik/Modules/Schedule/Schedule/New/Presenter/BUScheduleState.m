//
//  BUScheduleNewState.m
//  SUAI_Navigation
//
//  Created by Виктор on 26/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUScheduleState.h"

@implementation BUScheduleState

- (instancetype)initWithEntity:(NSString *)name type:(NSUInteger)type
{
    self = [super init];
    if (self) {
//        _state = BUScheduleStateNone;
        [self setEntity:name type:type];
    }
    return self;
}

- (void)setEntity:(NSString *)name type:(NSUInteger)type {
    if (name == nil)
        return;
//    _state |= BUScheduleStateEntitySelected;
    _name = name;
    _type = type;
}

@end
