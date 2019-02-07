//
//  BUSettingsDataDisplayManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 23/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BUSettingsViewModelItemType.h"

@interface BUSettingsDataDisplayManager : NSObject <UITableViewDataSource>

@property (nonatomic, assign) NSUInteger startScreenIndex;

- (BUSettingsViewModelItemType)typeForItemAtIndex:(NSUInteger)index;
- (void)entityName:(NSString *)name;
- (void)entityType:(NSString *)type;

@end
