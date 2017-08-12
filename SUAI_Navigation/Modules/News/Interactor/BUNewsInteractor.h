//
//  BUNewsInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNewsInteractorOutput.h"
#import "BUNewsInteractorInput.h"

@interface BUNewsInteractor : NSObject <BUNewsInteractorInput>

@property (strong, nonatomic) id <BUNewsInteractorOutput> output;

@end
