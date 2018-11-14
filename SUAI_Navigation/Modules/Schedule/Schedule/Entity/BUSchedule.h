//
//  BUSchedule.h
//  SUAI_Navigation
//
//  Created by Виктор on 18/03/2018.
//  Copyright © 2018 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WeekType) {
    WeekTypeBlue = 0,
    WeekTypeRed,
    WeekTypeFull
};

@interface BUSchedule : NSObject

//Так ли надо или нет?
- (instancetype)initWithSemester:(NSArray *)semester andSession:(NSArray *)session;

- (NSArray *)semesterForWeekType:(WeekType)type;
- (NSArray *)session;

@end
