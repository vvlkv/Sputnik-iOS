//
//  BUNotificationsDataDisplayManagerOutput.h
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUNotificationsDataDisplayManagerOutput_h
#define BUNotificationsDataDisplayManagerOutput_h

@protocol BUNotificationsDataDisplayManagerOutput <NSObject>

- (void)didChangeAllowNotificationsSwitch:(BOOL)newValue;

@end

#endif /* BUNotificationsDataDisplayManagerOutput_h */
