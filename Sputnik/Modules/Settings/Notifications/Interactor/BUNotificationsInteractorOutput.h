//
//  BUNotificationsInteractorOutput.h
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUNotificationsInteractorOutput_h
#define BUNotificationsInteractorOutput_h

@class BUNotificationSettings;
@protocol BUNotificationsInteractorOutput <NSObject>

- (void)didObtainNotificationSettings:(BUNotificationSettings *)settings;

@end

#endif /* BUNotificationsInteractorOutput_h */
