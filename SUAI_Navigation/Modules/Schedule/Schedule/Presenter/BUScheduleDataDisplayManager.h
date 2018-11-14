//
//  BUScheduleDataDisplayManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Typedef.h"
#import "BUScheduleContentDataSource.h"
#import "BUCapsPageViewDataSource.h"

@interface BUScheduleDataDisplayManager : NSObject <BUScheduleContentDataSource, BUCapsPageViewDataSource>

@property (assign, nonatomic) NSUInteger weekIndex;
@property (assign, nonatomic) NSUInteger scheduleIndex;
@property (assign, nonatomic) EntityType entityType;
@property (strong, nonatomic) NSArray *semesterSchedule;
@property (strong, nonatomic) NSArray *sessionSchedule;
@property (strong, nonatomic) NSDictionary *weekIndicators;

@end
