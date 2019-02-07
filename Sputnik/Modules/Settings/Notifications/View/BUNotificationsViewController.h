//
//  BUNotificationsViewController.h
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootViewController.h"
#import "BUNotificationsViewControllerInput.h"

NS_ASSUME_NONNULL_BEGIN
@protocol BUNotificationsViewControllerOutput;
@interface BUNotificationsViewController : BURootViewController <BUNotificationsViewControllerInput>

@property (nonatomic, strong) id <BUNotificationsViewControllerOutput> output;

@end

NS_ASSUME_NONNULL_END
