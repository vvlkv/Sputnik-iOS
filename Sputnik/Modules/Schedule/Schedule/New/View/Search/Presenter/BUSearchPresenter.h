//
//  BUSearchPresenter.h
//  Sputnik
//
//  Created by Виктор on 02/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUScheduleSearchViewControllerOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUScheduleSearchViewControllerInput;
@class SUAIEntity;
@interface BUSearchPresenter : NSObject <BUScheduleSearchViewControllerOutput>

@property (weak, nonatomic) id <BUScheduleSearchViewControllerInput> view;

@property (nonatomic, strong) void(^didFindEntity)(SUAIEntity *entity);

@end

NS_ASSUME_NONNULL_END
