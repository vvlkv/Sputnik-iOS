//
//  BUNewsDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUNews;
@protocol BUNewsDataSource <NSObject>

@required
- (NSUInteger)numberOfItems;
- (BUNews *)newsAtIndex:(NSUInteger)index;

@end
