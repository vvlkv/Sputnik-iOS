//
//  BUReferenceEntityAssembler.h
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUInfoEntity;
@protocol BUReferenceViewModelTableProtocol;
@interface BUReferenceEntityAssembler : NSObject

- (NSArray<id<BUReferenceViewModelTableProtocol>> *)assemblyDataFromEntity:(BUInfoEntity *)entity;

@end
