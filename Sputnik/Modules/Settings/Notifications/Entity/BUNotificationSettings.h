//
//  BUNotificationSettings.h
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUNotificationSettings : NSObject

@property (nonatomic, assign) BOOL isGranted;
@property (nonatomic, assign) BOOL isNotifyDay;
@property (nonatomic, assign) BOOL isNotifyPair;
@property (nonatomic, assign) NSUInteger pairNotifyTime;

@end

NS_ASSUME_NONNULL_END
