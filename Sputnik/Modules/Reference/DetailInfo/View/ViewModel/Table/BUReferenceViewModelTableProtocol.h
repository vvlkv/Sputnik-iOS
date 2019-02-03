//
//  BUReferenceViewModelItemProtocol.h
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceViewModelTableType.h"
#import "BUReferenceViewModelItemProtocol.h"

@protocol BUReferenceViewModelTableProtocol <NSObject>
@required
- (NSUInteger)rowCount;
- (id <BUReferenceViewModelItemProtocol>)modelForRow:(NSUInteger)index;
- (ViewModelTable)ViewModelTableType;
- (void)addModel:(id)model;

@end
