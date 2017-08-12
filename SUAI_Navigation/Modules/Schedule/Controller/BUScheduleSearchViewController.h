//
//  BUScheduleSearchViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 19.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootViewController.h"
#import "BUScheduleRouterOutput.h"
#import "BURootNavigationController.h"

@interface BUScheduleSearchViewController : BURootViewController

@property (strong, nonatomic) id <BUScheduleRouterOutput> output;

- (instancetype)initWithContents:(NSArray *)contents;

@end
