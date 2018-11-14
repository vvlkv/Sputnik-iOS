//
//  BUScheduleInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleInteractorOutput.h"
#import "BUScheduleInteractorInput.h"

@interface BUScheduleInteractor : NSObject <BUScheduleInteractorInput>

@property (weak, nonatomic) id<BUScheduleInteractorOutput> output;

- (instancetype)initWithEntity:(NSString *)e
                        ofType:(NSUInteger)t;

@end
