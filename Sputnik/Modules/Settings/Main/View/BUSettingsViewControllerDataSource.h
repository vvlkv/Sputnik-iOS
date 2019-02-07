//
//  BUSettingsViewControllerDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSettingsViewModelItemType.h"

@protocol BUSettingsViewControllerDataSource <NSObject>

@required
- (BUSettingsViewModelItemType)itemTypeAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSString *)titleForHeaderInSection:(NSUInteger)index;
- (NSString *)titleForCellAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSString *)subTitleForCellAtSection:(NSUInteger)section andRow:(NSUInteger)row;
- (NSUInteger)startScreenIndex;

@end
