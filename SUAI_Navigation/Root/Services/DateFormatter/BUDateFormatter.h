//
//  BUDateFormatter.h
//  SUAI_Navigation
//
//  Created by Виктор on 13.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUDateFormatter : NSObject


+ (NSUInteger)weekTypeFromDate:(NSString *)date;
+ (NSString *)dateFromData:(NSDate *)date;
- (NSArray *)dateFromWeek:(NSUInteger)weekType;

@end
