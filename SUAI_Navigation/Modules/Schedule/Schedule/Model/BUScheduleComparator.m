//
//  BUScheduleComparator.m
//  SUAI_Navigation
//
//  Created by Виктор on 27/01/2018.
//  Copyright © 2018 Viktor. All rights reserved.
//

#import "BUScheduleComparator.h"
#import "BUDay.h"
#import "BUPair.h"

@implementation BUScheduleComparator

+ (NSComparisonResult)compareActualSchedule:(NSArray *)actualSchedule
              withNewSchedule:(NSArray *)newSchedule {
    for (int i = 0; i < [actualSchedule count]; i++) {
        NSArray *actualSched = actualSchedule[i];
        NSArray *newSched = newSchedule[i];
        //check number of pairs
        if ([actualSched count] == [newSched count]) {
            BOOL isFoundDay;
            for (int j = 0; j < [actualSched count]; j++) {
                BUDay *oldDay = actualSched[j];
                isFoundDay = NO;
                for (BUDay *newDay in newSched) {
                    if ([[oldDay day] isEqualToString:[newDay day]]) {
                        isFoundDay = YES;
                        if ([[oldDay pairs] count] == [[newDay pairs] count]) {
                            for (int k = 0; k < [[oldDay pairs] count]; k++) {
                                BUPair *oldPair = [oldDay pairs][k];
                                BUPair *newPair = [newDay pairs][k];
                                if (![[oldPair name] isEqualToString:[newPair name]])
                                    return NSOrderedAscending;
                                    
                                if (![[oldPair teacherName] isEqualToString:[newPair teacherName]])
                                    return NSOrderedAscending;
                                
                                if (![[oldPair groups] isEqualToString:[newPair groups]])
                                    return NSOrderedAscending;
                                
//                                if (![[oldPair lessonType] isEqualToString:[newPair lessonType]])
//                                    return NSOrderedAscending;
                                
                                if (![[oldPair time] isEqualToString:[newPair time]])
                                    return NSOrderedAscending;
                                
                                if (![[oldPair auditory] isEqualToString:[newPair auditory]])
                                    return NSOrderedAscending;
                            }
                        }
                    }
                }
                if (isFoundDay == NO)
                    return NSOrderedAscending;
            }
        } else {
            return NSOrderedAscending;
        }
    }
    return NSOrderedSame;
}

@end
