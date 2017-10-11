//
//  BUSchedulePresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleViewControllerInput.h"
#import "BUScheduleContentDataSource.h"
#import "BUScheduleViewControllerOutput.h"
#import "BUScheduleInteractorInput.h"
#import "BUScheduleInteractorOutput.h"
#import "BUScheduleRouterInput.h"
#import "BUScheduleRouterOutput.h"


@interface BUSchedulePresenter : NSObject <BUScheduleViewControllerOutput, BUScheduleInteractorOutput, BUScheduleRouterOutput, BUScheduleContentDelegate>

@property (weak, nonatomic) id <BUScheduleViewControllerInput> view;
@property (strong, nonatomic) id <BUScheduleInteractorInput> input;
@property (strong, nonatomic) id <BUScheduleRouterInput> router;

- (instancetype)initWithEntity:(NSString *)entity andType:(NSUInteger)type;

@end
