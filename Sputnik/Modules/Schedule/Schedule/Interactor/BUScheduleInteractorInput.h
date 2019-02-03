//
//  BUScheduleNewInteractorInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUScheduleInteractorInput_h
#define BUScheduleInteractorInput_h

@class SUAISchedule;
@protocol BUScheduleInteractorInput <NSObject>
@required
- (void)obtainScheduleFromNetworkForEntity:(NSString *)entity type:(NSUInteger)type;
- (void)obtainScheduleFromCoreDataForEntity:(NSString *)entity type:(NSUInteger)type;
- (void)writeScheduleToCoreData:(SUAISchedule *)schedule;
- (void)obtainDate;
- (void)obtainDayIndex;
- (void)obtainWeekIndex;

@end


#endif /* BUScheduleNewInteractorInput_h */
