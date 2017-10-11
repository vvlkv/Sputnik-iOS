//
//  BUConcreteInfoModel.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUConcreteInfoModel : NSObject

- (instancetype)initWithData:(id)data;

- (NSUInteger)itemsCount;
- (NSString *)titleAtIndex:(NSUInteger)index;
- (NSString *)tableHeader;

- (NSUInteger)cellTypeAtIndex:(NSUInteger)index;
- (NSString *)cellDescription;

- (NSString *)auditory;

- (NSString *)imageNameAtIndex:(NSUInteger)index;
- (BOOL)isSelectableAtIndex:(NSUInteger)index;

@end
