//
//  BUInfoEntity.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUInfoEntity.h"

static NSString *kvcPropertyNames = {@"_name"};

@implementation BUInfoEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"";
    }
    return self;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BUInfoEntity *copyInfoEntity = [[[self class] alloc] init];
    copyInfoEntity.name = _name;
    return copyInfoEntity;
}

- (void)setkvcValue:(id)value
             forKey:(NSString *)key {
    if ([key isEqualToString:@"_name"]) {
        _name = value;
    }
}

@end
