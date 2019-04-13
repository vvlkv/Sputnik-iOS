//
//  BUScheduleNewInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUScheduleInteractorOutput_h
#define BUScheduleInteractorOutput_h

@class SUAISchedule;
@class SUAIError;
@protocol BUScheduleInteractorOutput <NSObject>
@required

- (void)didObtainSchedule:(SUAISchedule *)schedule;
- (void)didObtainDate:(NSString *)date andWeek:(NSString *)week;
- (void)didObtainDayIndex:(NSUInteger)index;
- (void)didObtainWeekIndex:(NSUInteger)index;

- (void)didScheduleFaultLoadingWithError:(SUAIError *)error;
- (void)didChangeInternetReachability:(BOOL)isReachable;
- (void)didLoadCodes;
- (void)didChangeEntityName:(NSString *)name andType:(NSUInteger)type;

@end

#endif /* BUScheduleNewInteractorOutput_h */
