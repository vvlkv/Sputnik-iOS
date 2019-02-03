//
//  NSCalendar+CurrentDay.m
//  SUAI_Navigation
//
//  Created by Виктор on 23.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "NSCalendar+CurrentDay.h"

@implementation NSCalendar (CurrentDay)

+ (NSUInteger)currentDay {
    return [NSCalendar dayFromDate:[NSDate date]];
}

+ (NSUInteger)weekIndex {
    return [self weekIndexFromDate:[NSDate date]];
}

+ (NSUInteger)weekIndexFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.minimumDaysInFirstWeek = 7;
    calendar.firstWeekday = 2;
    NSUInteger dayIndex = [[calendar components: NSCalendarUnitWeekOfYear fromDate:date] weekOfYear];
    return dayIndex % 2;
}

+ (NSUInteger)dayFromDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSUInteger weekday = ([comps weekday] + 5) % 7;
    return weekday;
}

@end
