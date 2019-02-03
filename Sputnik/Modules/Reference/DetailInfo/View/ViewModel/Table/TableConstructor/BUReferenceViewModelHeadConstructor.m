//
//  BUReferenceViewModelHeadConstructor.m
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewModelHeadConstructor.h"
#import "BUInfoEntity.h"
#import "BUReferenceViewModelBaseItem.h"

@implementation BUReferenceViewModelHeadConstructor


- (NSArray *)createModelFrom:(id)model {
    NSMutableArray *rows = [NSMutableArray array];
    if ([model isKindOfClass:[BUInfoEntity class]]) {
        BUReferenceViewModelBaseItem *headItem = [[BUReferenceViewModelBaseItem alloc] init];
        headItem.value = [((BUInfoEntity *)model) name];
        [rows addObject:headItem];
    }
    return rows;
}

@end
