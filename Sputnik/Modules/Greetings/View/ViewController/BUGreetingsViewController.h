//
//  BUGreetingsViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUGreetingsViewControllerInput.h"
#import "BUSecondStepViewDataSource.h"
#import "BUGreetingsViewControllerOutput.h"

@interface BUGreetingsViewController : UIViewController <BUGreetingsViewControllerInput>

@property (strong, nonatomic) id <BUGreetingsViewControllerOutput> output;
@property (strong, nonatomic) id <BUSecondStepViewDataSource> dataSource;

@end
