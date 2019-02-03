//
//  BUNavigationPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUMainScreenViewControllerOutput.h"
#import "BUMainScreenViewControllerInput.h"
#import "BUNavigationRouterInput.h"
#import "BUNavigationRouterOutput.h"

@interface BUNavigationPresenter : NSObject <BUMainScreenViewControllerOutput, BUNavigationRouterOutput>

@property (weak, nonatomic) id <BUMainScreenViewControllerInput> view;
@property (strong, nonatomic) id <BUNavigationRouterInput> router;

@end
