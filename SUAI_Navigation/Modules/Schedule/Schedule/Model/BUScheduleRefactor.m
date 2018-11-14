//
//  BUScheduleRefactor.m
//  SUAI_Navigation
//
//  Created by Виктор on 23.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleRefactor.h"
#import "BUAppDataContainer.h"
#import "BUDay.h"
#import "BUPair.h"

@interface BUScheduleRefactor () {
    NSDictionary *weekIndicators;
    NSArray *filledContent;
    NSArray *sortedSchedule;
}

@end

@implementation BUScheduleRefactor

- (instancetype)init
{
    self = [super init];
    if (self) {
        sortedSchedule = [[NSArray alloc] init];
    }
    return self;
}

- (void)refactorScheduleFromData:(NSArray *)data {
    filledContent = [self fillContentArrayFromData:data];
}

- (NSArray *)sortedScheduleForWeek:(NSUInteger)week {
    return [self sortScheduleArray:filledContent forWeek:week];
}

- (NSDictionary *)indicators {
    return [self fillIndicatorsFromArray:filledContent];
}

- (NSString *)findTeacher:(NSString *)teacher {
    return [self findEntity:teacher ofType:1];
}

- (NSString *)findGroup:(NSString *)teacher {
    return [self findEntity:teacher ofType:0];
}

- (NSString *)findEntity:(NSString *)entity OfType:(NSUInteger)type andCodes:(NSDictionary *)codes {
    for (NSString *name in [codes allKeys]) {
        if ([name containsString:entity]) {
            return name;
        }
    }
    return nil;
}

- (NSString *)findEntity:(NSString *)entity ofType:(NSUInteger)type {
    NSDictionary *codes = [[BUAppDataContainer instance] entityCodes];
    NSDictionary *searchCodes = (type == 0) ? codes[@"Semester"][@"Groups"] : codes[@"Semester"][@"Teachers"];
    for (NSString *name in [searchCodes allKeys]) {
        if ([name isEqualToString:entity]) {
            return name;
        }
    }
    for (NSString *name in [searchCodes allKeys]) {
        if ([name containsString:entity]) {
            return name;
        }
    }
    return nil;
}

- (NSArray *)sortScheduleArray:(NSArray *)array forWeek:(NSUInteger)week {
    NSMutableArray *outputArray = [NSMutableArray array];
    for (BUDay *day in array) {
        if ([day isKindOfClass:[BUDay class]]) {
            BUDay *newDay = [[BUDay alloc] initWithDay:[day day]];
            for (BUPair *pair in [day pairs]) {
                if ((NSUInteger)[pair color] == ((NSUInteger)week ^ 1) || (NSUInteger)[pair color] == 2) {
                    [newDay addPair:pair];
                }
            }
            if ([[newDay pairs] count] != 0) {
                [outputArray addObject:newDay];
            } else {
                [outputArray addObject:[NSArray array]];
            }
        } else {
            [outputArray addObject:[NSArray array]];
        }
    }
    return outputArray;
}

- (NSDictionary *)fillIndicatorsFromArray:(NSArray *)array {
    NSMutableDictionary *indicatorDictionary = [NSMutableDictionary dictionary];
    NSUInteger redPairs, bluePairs, bothPairs;
    
    for (NSInteger i = 0; i < [array count]; i++) {
        redPairs = bluePairs = bothPairs = 0;
        if ([array[i] isKindOfClass:[BUDay class]]) {
            BUDay *day = array[i];
            if ([[day pairs] count] == 0) {
                indicatorDictionary[[NSString stringWithFormat:@"%ld", (long)i]] = [NSNumber numberWithInteger:3];
            } else {
                for (BUPair *pair in day.pairs) {
                    switch ([pair color]) {
                        case DayColorRed:
                            redPairs++;
                            break;
                        case DayColorBlue:
                            bluePairs++;
                            break;
                        default:
                            bothPairs++;
                            break;
                    }
                }
                if (bothPairs > 0 || (bluePairs > 0 && redPairs > 0)) {
                    indicatorDictionary[[NSString stringWithFormat:@"%ld", (long)i]] = [NSNumber numberWithInteger:2];
                } else if (bluePairs > 0) {
                    indicatorDictionary[[NSString stringWithFormat:@"%ld", (long)i]] = [NSNumber numberWithInteger:1];
                } else {
                    indicatorDictionary[[NSString stringWithFormat:@"%ld", (long)i]] = [NSNumber numberWithInteger:0];
                }
            }
        } else {
            indicatorDictionary[[NSString stringWithFormat:@"%ld", (long)i]] = [NSNumber numberWithInteger:3];
        }
    }
    return indicatorDictionary;
}

- (NSArray *)fillContentArrayFromData:(NSArray *)data {
    NSArray *days = @[@"Понедельник", @"Вторник", @"Среда", @"Четверг", @"Пятница", @"Суббота", @"Вне"];
    NSMutableArray *contentArray = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        [contentArray addObject:[NSArray array]];
    }
    
    for (int i = 0; i < 7; i++) {
        NSUInteger barIndex = [data indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([[(BUDay *)obj day] containsString:days[i]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        if (barIndex != NSNotFound) {
            [contentArray replaceObjectAtIndex:i withObject:data[barIndex]];
        }
    }
    return contentArray;
}

@end
