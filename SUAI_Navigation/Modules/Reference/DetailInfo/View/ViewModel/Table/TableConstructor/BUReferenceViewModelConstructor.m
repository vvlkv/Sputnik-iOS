//
//  BUReferenceViewModelConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelConstructor.h"
#import "BUReferenceViewModelHeadConstructor.h"
#import "BUReferenceViewModelCathedraConstructor.h"
#import "BURefrerenceViewModelDirectorConstructor.h"
#import "BURefrerenceViewModelLinksConstructor.h"
#import "BURefrerenceViewModelSubHeadersConstructor.h"
#import "BURefrerenceViewModelAboutConstructor.h"
#import "BUReferenceViewModelSubDivisionsConstructor.h"
#import "BUReferenceViewModelTimeConstructor.h"

@implementation BUReferenceViewModelConstructor

+ (id <BUReferenceViewModelTableConstructorProtocol>)constructorForType:(ViewModelTable)tableType {
    switch (tableType) {
        case ViewModelTableHead:
            return [[BUReferenceViewModelHeadConstructor alloc] init];
        case ViewModelTableLink:
            return [[BURefrerenceViewModelLinksConstructor alloc] init];
        case ViewModelTableDirector:
            return [[BURefrerenceViewModelDirectorConstructor alloc] init];
        case ViewModelTableCathedras:
            return [[BUReferenceViewModelCathedraConstructor alloc] init];
        case ViewModelTableSubHeaders:
            return [[BURefrerenceViewModelSubHeadersConstructor alloc] init];
        case ViewModelTableAbout:
            return [[BURefrerenceViewModelAboutConstructor alloc] init];
        case ViewModelTableSubDivisions:
            return [[BUReferenceViewModelSubDivisionsConstructor alloc] init];
            case ViewModelTableTime:
            return [[BUReferenceViewModelTimeConstructor alloc] init];
        default:
            return nil;
            break;
    }
}

@end
