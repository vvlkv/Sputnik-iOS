//
//  BUCalendarViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 12.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootViewController.h"
#import "BUCalendarViewControllerInput.h"
#import "BUCalendarViewControllerOutput.h"

@interface BUCalendarViewController : BURootViewController <BUCalendarViewControllerInput>

@property (strong, nonatomic) id <BUCalendarViewControllerOutput> output;

@end
