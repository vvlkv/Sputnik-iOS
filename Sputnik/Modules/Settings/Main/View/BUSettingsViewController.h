//
//  BUSettingsViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUSettingsViewControllerInput.h"
#import "BUSettingsViewControllerOutput.h"
#import "BUSettingsViewControllerDataSource.h"

@interface BUSettingsViewController : BURootViewController <BUSettingsViewControllerInput>

@property (strong, nonatomic) id <BUSettingsViewControllerOutput> output;
@property (strong, nonatomic) id <BUSettingsViewControllerDataSource> dataSource;

@end
