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
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSUInteger weekday = ([comps weekday] + 5) % 7;
    return weekday;
}

@end
