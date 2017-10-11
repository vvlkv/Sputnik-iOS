//
//  BUNavigationSearchScreenViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUNavigationRouterOutput.h"

@interface BUNavigationSearchScreenViewController : BURootViewController

@property (weak, nonatomic) id <BUNavigationRouterOutput> output;

@end
