//
//  BUSettingsDataDisplayManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 23/12/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUSettingsViewControllerDataSource.h"

@interface BUSettingsDataDisplayManager : NSObject <BUSettingsViewControllerDataSource>

- (void)entityName:(NSString *)name;
- (void)entityType:(NSString *)type;
- (void)startScreen:(NSUInteger)startScreenIndex;

@end
