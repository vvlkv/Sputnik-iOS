//
//  BUDateFormatter.m
//  SUAI_Navigation
//
//  Created by Виктор on 13.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUDateFormatter.h"
#import "NSCalendar+CurrentDay.h"

@implementation BUDateFormatter

+ (NSUInteger)weekTypeFromDate:(NSString *)date {
    return [date containsString:@"нечетная"] ? 1 : 0;
}

+ (NSString *)dateFromData:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ru-RU"];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:date];
    NSString *month = [calendar monthSymbols][([components month] + 11) % 12];
    NSString *weekDay = [calendar weekdaySymbols][([components weekday] + 6) % 7];
    return [NSString stringWithFormat:@"%@, %ld %@", [weekDay capitalizedString], (long)[components day], month];
}

- (NSArray *)dateFromWeek:(NSUInteger)weekType {
    return @[[BUDateFormatter dateFromData:[NSDate date]], [self weekTypeDescriptionForWeek:weekType]];
}

- (NSString *)currentDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:[NSDate date]];
    NSString *month = [calendar monthSymbols][([components month] + 11) % 12];
    NSString *weekDay = [calendar weekdaySymbols][([components weekday] + 6) % 7];
    return [NSString stringWithFormat:@"%@, %ld %@", [weekDay capitalizedString], (long)[components day], month];
}

- (NSString *)weekTypeDescriptionForWeek:(NSUInteger)weekType {
    return (weekType == 0) ? @"Нижняя четная неделя" : @"Верхняя нечетная неделя";
}

@end
