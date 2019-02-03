//
//  BUReferenceViewModelTable.h
//  SUAI_Navigation
//
//  Created by Виктор on 21/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceViewModelTableProtocol.h"

@interface BUReferenceViewModelTable : NSObject <BUReferenceViewModelTableProtocol>

- (instancetype)initWithType:(ViewModelTable)type;

@end
