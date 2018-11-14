//
//  BUDean.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUDean.h"
#import "BUHeader.h"
#import "BULink.h"

@interface BUDean () {
    NSMutableArray *subHeaders;
}

@end

@implementation BUDean

- (instancetype)init
{
    self = [super init];
    if (self) {
        subHeaders = [[NSMutableArray alloc] init];
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BUDean *copyDean = [[[self class] alloc] init];
    copyDean.header = [[self header] copyWithZone:zone];
    copyDean.link = [[self link] copyWithZone:zone];
    [copyDean appendSubHeaders:[[NSArray alloc] initWithArray:subHeaders copyItems:YES]];
    return copyDean;
}

- (void)setkvcValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"Header"]) {
        BUHeader *header = [[BUHeader alloc] init];
        for (NSString *key in [value allKeys]) {
            [header setkvcValue:[value valueForKey:key] forKey:key];
        }
        _header = header;
    }
    
    if ([key isEqualToString:@"Link"]) {
        BULink *link = [[BULink alloc] init];
        for (NSString *key in [value allKeys]) {
            [link setkvcValue:[value valueForKey:key] forKey:key];
        }
        _link = link;
    }
    
    if ([key isEqualToString:@"SubHeaders"] && ![value isKindOfClass:[NSString class]]) {
        NSArray *subHeadersArray = [[value objectForKey:@"Header"] allObjects];
        for (NSDictionary *header in subHeadersArray) {
            BUHeader *subHeaderModel = [[BUHeader alloc] init];
            for (NSString *key in [header allKeys]) {
                [subHeaderModel setkvcValue:[header valueForKey:key] forKey:key];
            }
            [subHeaders addObject:subHeaderModel];
        }
    }
}

- (NSArray <BUHeader *> *)subHeaders {
    return [subHeaders copy];
}

- (void)appendSubHeaders:(NSArray<BUHeader *> *)copySubHeaders {
    subHeaders = [copySubHeaders copy];
}

@end
