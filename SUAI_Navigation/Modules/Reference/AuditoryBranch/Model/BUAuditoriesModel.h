//
//  BUAuditoriesModel.h
//  SUAI_Navigation
//
//  Created by Виктор on 28.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BUDean;
@interface BUAuditoriesModel : NSObject

- (void)prepareInformationData;

- (void)updateScope:(NSUInteger)scope;
- (NSUInteger)selectedScope;

- (NSUInteger)itemsCountForSection:(NSUInteger)section;
- (NSUInteger)sectionsCountAtIndex:(NSUInteger)index;
- (NSString *)headerAtIndex:(NSUInteger)index;
- (NSString *)titleAtIndex:(NSUInteger)index inSection:(NSUInteger)section;
- (NSString *)auditoryAtIndex:(NSUInteger)index inSection:(NSUInteger)section;

- (BUDean *)entityAtIndex:(NSUInteger)index inSection:(NSUInteger)section;
- (BOOL)isSelectableAtIndex:(NSUInteger)index inSection:(NSUInteger)section;

@end
