//
//  BUSchedule.m
//  SUAI_Navigation
//
//  Created by Виктор on 18/03/2018.
//  Copyright © 2018 Viktor. All rights reserved.
//

#import "BUSchedule.h"
#import "BUDay.h"
#import "BUPair.h"

@interface BUSchedule () {
    NSArray *semester;
    NSArray *session;
}

@end

@implementation BUSchedule

- (instancetype)initWithSemester:(NSArray *)sem
                      andSession:(NSArray *)sess {
    self = [super init];
    if (self) {
        session = sess;
        semester = [self fillSemesterScheduleToFullWeek:sem];
    }
    return self;
}

- (instancetype)init
{
    return nil;
}

- (NSArray *)semesterForWeekType:(WeekType)type {
    
    return nil;
}

- (NSArray *)session {
    return session;
}

- (NSArray *)fillSemesterScheduleToFullWeek:(NSArray *)unfilledSemester {
    NSMutableArray *semester = [NSMutableArray array];
    NSArray *days = @[@"Понедельник", @"Вторник", @"Среда", @"Четверг", @"Пятница", @"Суббота", @"Вне"];
    
    for (int i = 0; i < [days count]; i++) {
        [semester addObject:[NSArray array]];
    }
    
    for (int i = 0; i < [days count]; i++) {
        NSUInteger barIndex = [unfilledSemester indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([[(BUDay *)obj day] containsString:days[i]]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        if (barIndex != NSNotFound) {
            [semester replaceObjectAtIndex:i withObject:unfilledSemester[barIndex]];
        }
    }
    
    return [semester copy];
}

@end
