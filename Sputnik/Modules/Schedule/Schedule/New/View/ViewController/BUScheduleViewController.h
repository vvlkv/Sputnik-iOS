//
//  BUScheduleNewViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 03/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootViewController.h"
#import "BUScheduleViewControllerInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUScheduleViewControllerOutput;

@interface BUScheduleViewController : BURootViewController<BUScheduleViewControllerInput>

@property (strong, nonatomic) id <BUScheduleViewControllerOutput> output;


@end

NS_ASSUME_NONNULL_END
