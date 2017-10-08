//
//  BUCalendarPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 14.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUCalendarViewControllerOutput.h"
#import "BUCalendarViewControllerInput.h"
#import "BUScheduleRouter.h"

@interface BUCalendarPresenter : NSObject <BUCalendarViewControllerOutput>

@property (weak, nonatomic) id <BUCalendarViewControllerInput> view;
@property (strong, nonatomic) id <BUScheduleRouterInput> router;

- (instancetype)initWithData:(NSArray *)data;
- (instancetype)initWithData:(NSArray *)data andRootViewController:(id)viewController;

@end
