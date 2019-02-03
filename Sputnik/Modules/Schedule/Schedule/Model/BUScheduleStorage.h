//
//  BUScheduleStorage.h
//  BUSUAIParser
//
//  Created by Виктор on 10.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUAISchedule;
@interface BUScheduleStorage : NSObject

- (void)save:(SUAISchedule *)schedule;
- (SUAISchedule *)load;
- (void)clear;

@end
