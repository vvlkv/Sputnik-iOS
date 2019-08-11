//
//  NSString+Dash.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "NSString+Dash.h"

@implementation NSString (Dash)

+ (NSString *)prepareToCall:(NSString *)number {
    NSString *goodNumber = [number stringByReplacingOccurrencesOfString:@"(" withString:@""];
    goodNumber = [goodNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    goodNumber = [goodNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    goodNumber = [goodNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return goodNumber;
}

+ (NSString *)deleteDash:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSString *)prepareAuditoryToLoad:(NSString *)string {

    NSString *result = string;

    if ([string containsString:@"Г"] || [string containsString:@"Л"])
        return @"";

    if ([string containsString:@"Б.М. "])
        result = [result stringByReplacingOccurrencesOfString:@"Б.М. " withString:@""];

    if ([string containsString:@"-"])
        result = [NSString deleteDash:[[string componentsSeparatedByString:@" "] lastObject]];

    return result;
}

@end
