//
//  BUNotificationsPresenter.h
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNotificationsInteractorOutput.h"
#import "BUNotificationsViewControllerOutput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUNotificationsInteractorInput;
@protocol BUNotificationsViewControllerInput;

@interface BUNotificationsPresenter : NSObject <BUNotificationsInteractorOutput, BUNotificationsViewControllerOutput>

@property (nonatomic, strong) id<BUNotificationsInteractorInput> input;
@property (nonatomic, weak) id<BUNotificationsViewControllerInput> view;

@end

NS_ASSUME_NONNULL_END
