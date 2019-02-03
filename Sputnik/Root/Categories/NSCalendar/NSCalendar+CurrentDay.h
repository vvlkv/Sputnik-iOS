//
//  NSCalendar+CurrentDay.h
//  SUAI_Navigation
//
//  Created by Виктор on 23.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (CurrentDay)

+ (NSUInteger)currentDay;
+ (NSUInteger)weekIndex;
+ (NSUInteger)weekIndexFromDate:(NSDate *)date;
+ (NSUInteger)dayFromDate:(NSDate *)date;

@end
