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
@protocol BUNotificationsViewModelItem;
@protocol BUNotificationsViewModelItemOutput <NSObject>
- (void)item:(id<BUNotificationsViewModelItem>)item didChangeSwitchStatus:(BOOL)newVal;

@end

@protocol BUNotificationsViewModelItem <NSObject>

@property(nonatomic, weak) id<BUNotificationsViewModelItemOutput> output;
@required
- (NSUInteger)rowsCount;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndex:(NSUInteger)index;

@optional
- (NSString *)footer;

@end


#endif /* BUNotificationsViewModelItem_h */
