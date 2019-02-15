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

@property (nonatomic, assign) BOOL accessRequested;
@property (nonatomic, assign) BOOL isNotificationAllowed;
@property (nonatomic, assign) BOOL isNotifyDay;
@property (nonatomic, assign) BOOL isNotifyPair;
@property (nonatomic, assign) NSUInteger notifyPairBeforeTime;

@property (nonatomic, readonly) BOOL isSystemGranted;

+ (instancetype)instance;

- (void)activatePermissions;
- (BUNotificationSettings *)currentSettings;
- (void)commitNotificationsWithSchedule:(SUAISchedule *)schedule;
- (void)commitNotificationsSettings:(BUNotificationSettings *)settings
                       withSchedule:(SUAISchedule *)schedule;

@end

NS_ASSUME_NONNULL_END
