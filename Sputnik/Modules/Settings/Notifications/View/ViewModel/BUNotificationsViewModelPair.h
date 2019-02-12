//
//  BUNotificationsViewModelPair.h
//  Sputnik
//
//  Created by Виктор on 08/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNotificationsViewModelGrants.h"
#import "BUNotificationsViewModelItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUNotificationsViewModelPair : BUNotificationsViewModelGrants<BUNotificationsViewModelItem>

@property (nonatomic, assign, readonly) NSUInteger value;

- (instancetype)initWithGrants:(BOOL)isGranted
                  initialValue:(NSUInteger)initial;

@end

NS_ASSUME_NONNULL_END
