//
//  BUNotificationsViewModelItem.h
//  Sputnik
//
//  Created by Виктор on 07/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#ifndef BUNotificationsViewModelItem_h
#define BUNotificationsViewModelItem_h

@class UITableViewCell;
@class UITableView;
@protocol BUNotificationsViewModelItem <NSObject>

@required
- (NSUInteger)rowsCount;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSString *)footer;

@end


#endif /* BUNotificationsViewModelItem_h */
