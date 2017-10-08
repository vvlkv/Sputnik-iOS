//
//  BUScheduleRefactor.h
//  SUAI_Navigation
//
//  Created by Виктор on 23.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUScheduleRefactor : NSObject

@property (readonly, nonatomic) NSDictionary *indicators;

- (void)refactorScheduleFromData:(NSArray *)data;
- (NSArray *)sortedScheduleForWeek:(NSUInteger)week;
- (NSString *)findTeacher:(NSString *)teacher inCodes:(NSDictionary *)codes;
- (NSString *)findFroup:(NSString *)group inCodes:(NSDictionary *)codes;

@end
