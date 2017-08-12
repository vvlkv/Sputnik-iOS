//
//  BUSettingsInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSettingsInteractorInput.h"
#import "BUSettingsInteractorOutput.h"

@interface BUSettingsInteractor : NSObject <BUSettingsInteractorInput>

@property (weak, nonatomic) id <BUSettingsInteractorOutput> output;

@end
