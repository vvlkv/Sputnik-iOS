//
//  BUScheduleNewRouter.h
//  SUAI_Navigation
//
//  Created by Виктор on 20/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleRouterInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUScheduleRouterOutput;
@interface BUScheduleRouter : NSObject<BUScheduleRouterInput>

@property (nonatomic, weak) id <BUScheduleRouterOutput> output;

@end

NS_ASSUME_NONNULL_END
