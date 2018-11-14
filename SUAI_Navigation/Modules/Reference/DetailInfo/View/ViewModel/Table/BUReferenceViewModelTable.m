//
//  BUReferenceViewModelTable.m
//  SUAI_Navigation
//
//  Created by Виктор on 21/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelTable.h"
#import "BUReferenceViewModelTableConstructorProtocol.h"
#import "BUReferenceViewModelConstructor.h"

@interface BUReferenceViewModelTable () {
    ViewModelTable tableType;
    NSArray *rows;
    id <BUReferenceViewModelTableConstructorProtocol> constructor;
}

@end
@implementation BUReferenceViewModelTable


#pragma mark - BUReferenceViewModelTableProtocol

- (instancetype)initWithType:(ViewModelTable)type
{
    self = [super init];
    if (self) {
        tableType = type;
        constructor = [BUReferenceViewModelConstructor constructorForType:type];
    }
    return self;
}

- (NSUInteger)rowCount {
    return [rows count];
}

- (id <BUReferenceViewModelItemProtocol>)modelForRow:(NSUInteger)index {
    return rows[index];
}

- (ViewModelTable)ViewModelTableType {
    return tableType;
}

- (void)addModel:(id)model {
    rows = [constructor createModelFrom:model];
}

@end
