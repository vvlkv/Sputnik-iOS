//
//  BUReferenceMainScreenContentProtocol.h
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUReferenceMainScreenContentDataSource <NSObject>

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSString *)titleForCellAtRow:(NSUInteger)index inSection:(NSUInteger)section;

@end

@protocol BUReferenceMainScreenContentDelegate <NSObject>

- (void)didPressCellAtIndex:(NSUInteger)index;

@end
