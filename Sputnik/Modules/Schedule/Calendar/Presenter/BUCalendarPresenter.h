//
//  BUCalendarNewPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 21/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUCalendarViewControllerOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUCalendarViewControllerInput;

@class SUAISchedule;

@interface BUCalendarPresenter : NSObject<BUCalendarViewControllerOutput>

@property (nonatomic, strong) void(^foundEntity)(NSString *entity, NSUInteger type);
@property (nonatomic, strong) void(^foundAuditory)(NSString *auditory);
@property (nonatomic, weak) id<BUCalendarViewControllerInput> view;

- (instancetype)initWithSchedule:(SUAISchedule *)schedule;

@end

NS_ASSUME_NONNULL_END
