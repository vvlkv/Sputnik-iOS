//
//  BUCalendarNewViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 21/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootViewController.h"
#import "BUCalendarViewControllerInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUCalendarViewControllerOutput;

@interface BUCalendarViewController : BURootViewController<BUCalendarViewControllerInput>

@property (nonatomic, strong) id<BUCalendarViewControllerOutput> output;

@end

NS_ASSUME_NONNULL_END
