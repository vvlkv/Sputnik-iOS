//
//  BUScheduleInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 18.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUScheduleInteractorOutput <NSObject>

@required
- (void)didObtainSchedule:(NSArray *)schedule;
- (void)didObtainDate:(NSString *)date;
- (void)didObtainCodes:(NSDictionary *)codes;
- (void)didDownloadCodes;

@end
