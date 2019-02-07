//
//  BUNotificationsViewControllerInput.h
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUNotificationsViewControllerInput_h
#define BUNotificationsViewControllerInput_h

@protocol UITableViewDataSource;
@protocol BUNotificationsViewControllerInput <NSObject>

- (void)dataSource:(id <UITableViewDataSource>)dataSource;
- (void)showNeedGrantNotificationsMessage;

@end

#endif /* BUNotificationsViewControllerInput_h */
