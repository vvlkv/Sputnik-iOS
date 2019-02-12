//
//  BUNotificationsViewModelGrants.h
//  Sputnik
//
//  Created by Виктор on 08/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUNotificationsViewModelItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUNotificationsViewModelGrants : NSObject<BUNotificationsViewModelItem>

@property (nonatomic, assign, readonly) BOOL isGranted;

- (instancetype)initWithGrants:(BOOL)isGranted;

- (UITableViewCell *)configureSwitchCell:(UITableView *)tableView withTextLabel:(NSString *)textLabel;

@end

NS_ASSUME_NONNULL_END
