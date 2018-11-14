//
//  BUScheduleInteractorInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 18.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUScheduleInteractorInput <NSObject>

@required
- (void)obtainSchedule;

@optional
- (void)obtainDate;
- (void)reloadSchedule:(NSArray *)schedule;

@end
