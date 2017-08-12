//
//  BUScheduleDataDisplayManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleContentDataSource.h"

@interface BUScheduleDataDisplayManager : NSObject <BUScheduleContentDataSource>

@property (assign, nonatomic) NSUInteger weekIndex;
@property (assign, nonatomic) NSUInteger scheduleIndex;
@property (assign, nonatomic) NSUInteger entityType;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSMutableArray *schedule;

- (NSArray *)semesterSchedule;
- (NSArray *)sessionSchedule;

@end
