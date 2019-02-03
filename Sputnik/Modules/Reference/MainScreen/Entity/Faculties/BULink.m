//
//  BULink.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BULink.h"

@implementation BULink

- (void)setkvcValue:(id)value
             forKey:(NSString *)key {
    if ([key isEqualToString:@"_site"]) {
        _site = value;
    }
    if ([key isEqualToString:@"_mail"]) {
        _mail = value;
    }
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BULink *link = [[[self class] alloc] init];
    link.site = _site;
    link.mail = _mail;
    return link;
}

@end
