//
//  BUScheduleNewPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BUScheduleInteractorOutput.h"
#import "BUScheduleViewControllerOutput.h"
#import "BUScheduleRouterOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUScheduleInteractorInput;
@protocol BUScheduleViewControllerInput;
@protocol BUScheduleRouterInput;

@interface BUSchedulePresenter : NSObject<BUScheduleInteractorOutput, BUScheduleViewControllerOutput, BUScheduleRouterOutput>

@property (nonatomic, weak) id <BUScheduleViewControllerInput> view;
@property (nonatomic, strong) id <BUScheduleInteractorInput> input;
@property (nonatomic, strong) id <BUScheduleRouterInput> router;

- (instancetype)initWithEntityName:(NSString *)name andType:(NSUInteger)type;

@end

NS_ASSUME_NONNULL_END
