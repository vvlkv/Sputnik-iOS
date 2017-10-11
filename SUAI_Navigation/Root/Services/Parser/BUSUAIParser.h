//
//  BUSUAIParser.h
//  BUSUAIParser
//
//  Created by Виктор on 09.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

/*typedef enum ScheduleType {
    ScheduleTypeSession,
    ScheduleTypeSemester
}ScheduleType;*/

@interface BUSUAIParser : NSObject

+ (NSDictionary *)codesFromData:(NSData *)data;
+ (NSArray *)scheduleFromData:(NSData *)data;

@end
