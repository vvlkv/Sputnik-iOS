//
//  BUNotificationsDataDisplayManager.h
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BUNotificationSettings;

@protocol BUNotificationsDataDisplayManagerOutput;

@interface BUNotificationsDataDisplayManager : NSObject<UITableViewDataSource>

@property (nonatomic, weak) id<BUNotificationsDataDisplayManagerOutput> output;

- (instancetype)initWithNotificationSettings:(BUNotificationSettings *)settings;

@end

NS_ASSUME_NONNULL_END
