//
//  BUSettingsRouter.h
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSettingsRouterInput.h"
#import "BUSettingsRouterOutput.h"

@interface BUSettingsRouter : NSObject <BUSettingsRouterInput>

@property (weak, nonatomic) id <BUSettingsRouterOutput> output;

@end
