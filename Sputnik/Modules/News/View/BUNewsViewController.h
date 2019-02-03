//
//  BUNewsViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUNewsViewControllerInput.h"
#import "BUNewsViewControllerOutput.h"
#import "BUNewsDataSource.h"
#import "BURootViewController.h"

@interface BUNewsViewController : BURootViewController <BUNewsViewControllerInput>

@property (strong, nonatomic) id <BUNewsViewControllerOutput> output;
@property (strong, nonatomic) id <BUNewsDataSource> dataSource;

@end
