//
//  BUSettingsEntityViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUSettingsRouterOutput.h"

@interface BUSettingsEntityViewController : BURootViewController

@property (strong, nonatomic) id <BUSettingsRouterOutput> output;

- (instancetype)initWithContents:(NSArray *)contents;

@end
