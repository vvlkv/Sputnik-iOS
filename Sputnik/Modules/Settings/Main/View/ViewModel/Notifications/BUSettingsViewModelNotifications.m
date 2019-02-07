//
//  BUSettingsViewModelNotifications.m
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUSettingsViewModelNotifications.h"

@implementation BUSettingsViewModelNotifications

- (NSString *)headerTitle {
    return @"";
}

- (BUSettingsViewModelItemType)itemType {
    return BUSettingsViewModelItemTypeNotificationCenter;
}


- (NSUInteger)rowsCount {
    return 1;
}


- (NSString *)titleForCellAtIndex:(NSUInteger)index {
    return @"Центр уведомлений";
}



@end
