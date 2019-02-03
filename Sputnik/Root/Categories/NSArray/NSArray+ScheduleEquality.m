//
//  NSArray+ScheduleEquality.m
//  SUAI_Navigation
//
//  Created by Виктор on 17/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "NSArray+ScheduleEquality.h"

@implementation NSArray (ScheduleEquality)

- (BOOL)isScheduleEqual:(NSArray *)schedule {
    
    if (self[0] == nil && schedule[0] != nil)
        return false;
    if (self[0] != nil && schedule[0] == nil)
        return false;
    
    if (self[1] == nil && schedule[1] != nil)
        return false;
    if (self[1] != nil && schedule[1] == nil)
        return false;
    
    if ([self[0] count] != [schedule[0] count])
        return false;
    
    if ([self[1] count] != [schedule[1] count])
        return false;
    
    return true;
}

@end
