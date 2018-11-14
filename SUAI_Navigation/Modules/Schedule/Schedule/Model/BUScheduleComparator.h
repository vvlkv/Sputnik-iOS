//
//  BUScheduleComparator.h
//  SUAI_Navigation
//
//  Created by Виктор on 27/01/2018.
//  Copyright © 2018 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUScheduleComparator : NSObject

+ (NSComparisonResult)compareActualSchedule:(NSArray *)actualSchedule
              withNewSchedule:(NSArray *)newSchedule;

@end
