//
//  BURootTabBarViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 11.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUTabBarViewControllerInput.h"

@protocol BUTabBarViewControllerOutput;

@interface BUTabBarViewController : UITabBarController <BUTabBarViewControllerInput>

@property (strong, nonatomic) id <BUTabBarViewControllerOutput> output;

@end
