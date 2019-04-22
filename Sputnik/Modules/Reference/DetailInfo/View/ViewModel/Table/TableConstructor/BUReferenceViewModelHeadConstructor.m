//
//  BUReferenceViewModelHeadConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelHeadConstructor.h"
#import "BUInfoEntity.h"
#import "BUFaculty.h"
#import "BUReferenceViewModelIconItem.h"

@implementation BUReferenceViewModelHeadConstructor


- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    if ([model isKindOfClass:[BUInfoEntity class]]) {
        BUReferenceViewModelBaseItem *item = nil;
        
        if ([model isKindOfClass:[BUFaculty class]]) {
            item = (BUReferenceViewModelIconItem *)[[BUReferenceViewModelIconItem alloc] init];
            ((BUReferenceViewModelIconItem *)item).icon = [(BUFaculty *)model icon];
        } else {
            item = [[BUReferenceViewModelBaseItem alloc] init];
        }
        item.value = [(BUInfoEntity *)model name];
        [rows addObject:item];
    }
    return rows;
}

@end
