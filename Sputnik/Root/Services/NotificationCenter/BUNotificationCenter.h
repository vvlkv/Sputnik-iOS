//
//  BUNotificationCenter.h
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUNotificationCenterOutput <NSObject>
@required
- (void)didChangeNotificationPermission:(BOOL)isGranted;

@end

@class BUNotificationSettings;
@class SUAISchedule;

@interface BUNotificationCenter : NSObject

@property (nonatomic, weak) id<BUNotificationCenterOutput> output;

@property (nonatomic, readonly) BOOL isGranted;

- (void)commitNotificationsSettings:(BUNotificationSettings *)settings
                       withSchedule:(SUAISchedule *)schedule;

@end

NS_ASSUME_NONNULL_END
