//
//  BUSearchViewController.h
//  Sputnik
//
//  Created by Виктор on 02/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUScheduleSearchViewControllerInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUScheduleSearchViewControllerOutput;

@interface BUSearchViewController : UIViewController <BUScheduleSearchViewControllerInput>

@property (strong, nonatomic) id <BUScheduleSearchViewControllerOutput> output;

@end

NS_ASSUME_NONNULL_END
