//
//  BUDownloader.h
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Typedef.h"

typedef enum ScheduleType {
    ScheduleTypeSession,
    ScheduleTypeSemester
}ScheduleType;


@interface BUDownloader : NSObject

+ (void)loadURLWithType:(ScheduleType)type
                success:(void (^) (NSData *data))success
                   fail:(void (^) (NSString *fail))fail;

+ (void)loadScheduleOfType:(ScheduleType)scheduleType
                    entity:(EntityType)entityType
                   entityId:(NSString *)identificator
                    success:(void (^) (NSData *data))success
                       fail:(void (^) (NSString *fail))fail;

@end
