//
//  BUNotificationsInteractor.h
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNotificationsInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BUNotificationsInteractorOutput;
@interface BUNotificationsInteractor : NSObject<BUNotificationsInteractorInput>

@property (nonatomic, weak) id<BUNotificationsInteractorOutput> output;

@end

NS_ASSUME_NONNULL_END
