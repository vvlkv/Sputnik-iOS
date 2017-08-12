//
//  NSArray+Codes.m
//  SUAI_Navigation
//
//  Created by Виктор on 23.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "NSArray+Codes.h"

@implementation NSArray (Codes)

+ (NSArray *)codesFromDictionary:(NSDictionary *)codes {
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *value in [codes allKeys]) {
        [values addObject:value];
    }
    [values sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 compare:str2 options:(NSLiteralSearch)];
    }];
    [values removeObjectAtIndex:0];
    return values;
}

+ (NSArray *)codesFromDictionaryWithoutInfo:(NSDictionary *)codes {
    NSMutableArray *values = [NSMutableArray array];
    for (NSString *value in [codes allKeys]) {
        [values addObject:[value componentsSeparatedByString:@" - "][0]];
    }
    [values sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 compare:str2 options:(NSLiteralSearch)];
    }];
    [values removeObjectAtIndex:0];
    return values;
}

@end
