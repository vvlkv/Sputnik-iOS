//
//  BUNotificationsPresenter.h
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNotificationsViewControllerOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUNotificationsViewControllerInput;

@interface BUNotificationsPresenter : NSObject <BUNotificationsViewControllerOutput>

@property (nonatomic, weak) id<BUNotificationsViewControllerInput> view;

@end

NS_ASSUME_NONNULL_END
