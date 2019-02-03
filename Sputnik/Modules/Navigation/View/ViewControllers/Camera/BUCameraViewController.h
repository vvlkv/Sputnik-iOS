//
//  BUCameraViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 24.06.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUNavigationRouterOutput.h"
#import "BUNavigationRouterInput.h"
#import "BURootViewController.h"

@interface BUCameraViewController : BURootViewController

@property (nonatomic, copy) void (^didDismiss)(NSString *data);
@property (strong, nonatomic) id <BUNavigationRouterOutput> output;

@end
