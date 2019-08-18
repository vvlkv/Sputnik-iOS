//
//  BUInfoPlacedEntity.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUInfoPlacedEntity.h"

@implementation BUInfoPlacedEntity

- (instancetype)init {
    self = [super init];
    if (self) {
        _pos = _aud = @"";
    }
    return self;
}

- (void)setkvcValue:(id)value forKey:(NSString *)key {
    [super setkvcValue:value forKey:key];
    if ([key isEqualToString:@"_pos"])
        _pos = value;
    
    if ([key isEqualToString:@"_aud"])
        _aud = value;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BUInfoPlacedEntity *copyInfoEntity = [super copyWithZone:zone];
    copyInfoEntity.pos = _pos;
    copyInfoEntity.aud = _aud;
    return copyInfoEntity;
}

@end
