//
//  BUScheduleNewDataDisplayManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class SUAISchedule;
@class SUAIPair;

@interface BUScheduleDataDisplayManager : NSObject<BUScheduleTableViewControllerDataSource>

@property (assign, nonatomic) NSUInteger weekIndex;
@property (nonatomic, readonly) SUAISchedule *schedule;

- (instancetype)initWithSchedule:(SUAISchedule *)schedule;

- (SUAIPair *)pairAtIndex:(NSUInteger)pairIndex day:(NSUInteger)day scheduleType:(ScheduleType)type;
- (NSArray *)createMarkers;

@end

NS_ASSUME_NONNULL_END
