//
//  BUSettingsViewModelItem.h
//  SUAI_Navigation
//
//  Created by Виктор on 24/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSettingsViewModelItemType.h"

@protocol BUSettingsViewModelItem <NSObject>

@required
- (NSString *)headerTitle;
- (NSUInteger)rowsCount;
- (BUSettingsViewModelItemType)itemType;
- (NSString *)titleForCellAtIndex:(NSUInteger)index;

@optional
- (NSString *)subTitleForCellAtIndex:(NSUInteger)index;

@end
