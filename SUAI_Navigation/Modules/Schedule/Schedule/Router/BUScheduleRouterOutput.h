//
//  BUScheduleRouterOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUScheduleRouterOutput <NSObject>

@required
- (void)didObtainNewSchedule:(NSString *)entity ofType:(NSUInteger)type;

@end
