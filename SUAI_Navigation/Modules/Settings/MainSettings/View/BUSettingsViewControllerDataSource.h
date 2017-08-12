//
//  BUSettingsViewControllerDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUSettingsViewControllerDataSource <NSObject>

@required
- (NSString *)entityType;
- (NSString *)entityName;
- (NSUInteger)startIndex;

@end
