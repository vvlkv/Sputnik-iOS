//
//  BUReferenceMainScreenInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceMainScreenInteractorInput.h"
#import "BUreferenceMainScreenInteractorOutput.h"

@interface BUReferenceMainScreenInteractor : NSObject <BUReferenceMainScreenInteractorInput>

@property (weak, nonatomic) id <BUreferenceMainScreenInteractorOutput> output;

- (void)activate;

@end
