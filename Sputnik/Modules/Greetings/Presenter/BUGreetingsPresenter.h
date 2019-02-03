//
//  BUGreetingsPresenter.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUGreetingsViewControllerInput.h"
#import "BUGreetingsViewControllerOutput.h"
#import "BUSecondStepViewDataSource.h"
#import "BUGreetingsInteractorInput.h"
#import "BUGreetingsInteractorOutput.h"

@interface BUGreetingsPresenter : NSObject <BUGreetingsViewControllerOutput, BUSecondStepViewDataSource, BUGreetingsInteractorOutput>

@property (weak, nonatomic) id <BUGreetingsViewControllerInput> view;
@property (strong, nonatomic) id <BUGreetingsInteractorInput> input;

@end
