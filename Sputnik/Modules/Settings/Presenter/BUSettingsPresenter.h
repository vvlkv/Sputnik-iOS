//
//  BUSettingsPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSettingsViewControllerInput.h"
#import "BUSettingsViewControllerOutput.h"
#import "BUSettingsRouterInput.h"
#import "BUSettingsRouterOutput.h"
#import "BUSettingsInteractorInput.h"
#import "BUSettingsInteractorOutput.h"
#import "BUSettingsViewControllerDataSource.h"

@interface BUSettingsPresenter : NSObject <BUSettingsViewControllerOutput, BUSettingsInteractorOutput, BUSettingsRouterOutput>

@property (weak, nonatomic) id <BUSettingsViewControllerInput> view;
@property (strong, nonatomic) id <BUSettingsRouterInput> router;
@property (strong, nonatomic) id <BUSettingsInteractorInput> input;

@end
