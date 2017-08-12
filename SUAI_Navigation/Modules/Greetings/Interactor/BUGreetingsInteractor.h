//
//  BUGreetingsInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUGreetingsInteractorInput.h"
#import "BUGreetingsInteractorOutput.h"

@interface BUGreetingsInteractor : NSObject <BUGreetingsInteractorInput>

@property (weak, nonatomic) id <BUGreetingsInteractorOutput> output;

@end
