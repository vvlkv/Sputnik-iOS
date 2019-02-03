//
//  BUDepartment.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUDepartment.h"
#import "BUHeader.h"
#import "BULink.h"
#import "BUSubdivision.h"

@interface BUDepartment () {
    NSMutableArray *subdivisions;
}

@end

@implementation BUDepartment

- (instancetype)init
{
    self = [super init];
    if (self) {
        subdivisions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (nonnull id)copyWithZone:(NSZone *)zone {
    BUDepartment *copyDepartment = [super copyWithZone:zone];
    copyDepartment.header = [[self header] copyWithZone:zone];
    copyDepartment.link = [[self link] copyWithZone:zone];
    return copyDepartment;
}

- (void)setkvcValue:(id)value
             forKey:(NSString *)key {
    [super setkvcValue:value forKey:key];
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
    
    if ([key isEqualToString:@"Subdivisions"]) {
        NSArray *subdivisionsArray = [[value objectForKey:@"subdivision"] allObjects];
        for (NSDictionary *subdivision in subdivisionsArray) {
            BUSubdivision *subdivisionModel = [[BUSubdivision alloc] init];
            for (NSString *key in [subdivision allKeys]) {
                [subdivisionModel setkvcValue:[subdivision valueForKey:key] forKey:key];
            }
            [subdivisions addObject:subdivisionModel];
        }
    }
}

- (NSArray <BUSubdivision *> *)subdivisions {
    return [subdivisions copy];
}
@end
