//
//  BUNewsDetailInfoViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootViewController.h"
#import "BUNewsDetailInfoViewControllerInput.h"
#import "BUNewsDetailInfoViewControllerOutput.h"
#import "BUNewsDetailInfoDataSource.h"

@interface BUNewsDetailInfoViewController : BURootViewController <BUNewsDetailInfoViewControllerInput>

@property (strong, nonatomic) id <BUNewsDetailInfoViewControllerOutput> output;
@property (strong, nonatomic) id <BUNewsDetailInfoDataSource> dataSource;

@end
