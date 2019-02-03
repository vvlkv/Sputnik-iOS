//
//  BUScheduleNewInteractor.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUScheduleInteractorOutput;

@interface BUScheduleInteractor : NSObject<BUScheduleInteractorInput>

@property (weak, nonatomic) id <BUScheduleInteractorOutput> output;

@end

NS_ASSUME_NONNULL_END
