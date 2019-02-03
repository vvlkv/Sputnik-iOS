//
//  BUSubdivision.m
//  JSONParser
//
//  Created by Виктор on 18/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUSubdivision.h"
#import "BUHeader.h"
#import "BULink.h"
#import "BUTime.h"

@implementation BUSubdivision

- (void)setkvcValue:(id)value forKey:(NSString *)key {
    [super setkvcValue:value forKey:key];
    if ([key isEqualToString:@"_time"]) {
        _time = [self appendTime:value];
    }
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
}

- (NSArray *)appendTime:(NSString *)time {
    NSMutableArray *timesArray = [NSMutableArray array];
    if ([time isEqualToString:@""])
        return [timesArray copy];
    
    NSArray *days = [time componentsSeparatedByString:@";"];
    
    for (NSString *day in days) {
        NSArray *daysAndTimes = [day componentsSeparatedByString:@": "];
        BUTime *timeObject = [[BUTime alloc] init];
        timeObject.day = [daysAndTimes firstObject];
        timeObject.time = [daysAndTimes lastObject];
        [timesArray addObject:timeObject];
    }
    return [timesArray copy];
}
@end
