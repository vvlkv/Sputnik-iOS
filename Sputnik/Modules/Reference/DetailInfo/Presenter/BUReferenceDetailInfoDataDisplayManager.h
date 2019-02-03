//
//  BUReferenceDetailInfoDataDisplayManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 15/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceTableViewDataSource.h"
#import "BUReferenceViewModelTableProtocol.h"

@interface BUReferenceDetailInfoDataDisplayManager : NSObject <BUReferenceTableViewDataSource>

- (instancetype)initWithEntities:(NSArray *)e;
- (instancetype)initWithEntity:(id)e;

- (void)addViewModels:(NSArray *)e;
- (id)cathedraAtIndex:(NSUInteger)index;
- (BOOL)containsFaculties;
- (BOOL)containsSubDivisions;

@end
