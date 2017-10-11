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
- (void)obtainScheduleForEntity:(NSString *)entity andType:(NSUInteger)type;

@optional
- (void)obtainSchedule;

@end
