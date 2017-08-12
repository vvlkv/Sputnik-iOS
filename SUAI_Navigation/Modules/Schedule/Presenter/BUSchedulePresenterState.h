//
//  BUSchedulePresenterState.h
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUSchedulePresenterState : NSObject

@property (assign, nonatomic) BOOL isOnline;
@property (assign, nonatomic) NSUInteger currentWeek;
@property (strong, nonatomic) NSString *entityName;
@property (strong, nonatomic) NSArray *unfilteredSchedule;
@property (strong, nonatomic) NSDictionary *codes;

@end
