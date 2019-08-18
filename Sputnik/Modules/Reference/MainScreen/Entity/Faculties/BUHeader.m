//
//  BUHeader.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUHeader.h"

@interface BUHeader () {
    NSArray *kvcFields;
}

@end

@implementation BUHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = _phone = _mail = @"";
        kvcFields = @[@"_type", @"_phone", @"_mail"];
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BUHeader *copyHeader = [super copyWithZone:zone];
    copyHeader.type = _type;
    copyHeader.phone = _phone;
    copyHeader.mail = _mail;
    return copyHeader;
}

- (void)setkvcValue:(id)value
             forKey:(NSString *)key {
    [super setkvcValue:value forKey:key];
    for (NSString *field in kvcFields) {
        if ([key isEqualToString:field]) {
            [self setValue:value forKey:field];
            break;
        }
    }
}

@end
