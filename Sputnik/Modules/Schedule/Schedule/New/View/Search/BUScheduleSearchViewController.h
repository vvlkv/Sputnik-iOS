//
//  BUScheduleNewSearchViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 20/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BURootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class SUAIEntity;

@interface BUScheduleSearchViewController : BURootViewController

@property (nonatomic, strong) void(^foundEntity)(SUAIEntity *entity);

@end

NS_ASSUME_NONNULL_END
