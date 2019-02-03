//
//  BUReferenceDetailInfoInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceDetailInfoInteractorInput.h"
#import "BUReferenceDetailInfoInteractorOutput.h"

@interface BUReferenceDetailInfoInteractor : NSObject <BUReferenceDetailInfoInteractorInput>

@property (weak, nonatomic) id <BUReferenceDetailInfoInteractorOutput> output;

- (instancetype)initWithEntity:(id)entity;
- (void)modulesAssembled;

@end
