//
//  BUReferenceViewModelConstructor.h
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceViewModelTableType.h"
#import "BUReferenceViewModelTableConstructorProtocol.h"

@interface BUReferenceViewModelConstructor : NSObject

+ (id <BUReferenceViewModelTableConstructorProtocol>)constructorForType:(ViewModelTable)tableType;

@end
