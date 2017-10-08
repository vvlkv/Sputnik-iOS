//
//  BUSchedulePresenterState.h
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ConnectionStatus {
    ConnectionStatusOnline,
    ConnectionStatusOffline
} ConnectionStatus;

@interface BUSchedulePresenterState : NSObject

@property (assign, nonatomic) NSUInteger currentWeek;
@property (strong, nonatomic) NSString *entityName;
@property (strong, nonatomic) NSArray *unfilteredSchedule;
@property (strong, nonatomic) NSDictionary *codes;
@property (assign, nonatomic) ConnectionStatus connectionStatus;

@end
