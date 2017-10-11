//
//  BUFaculty.m
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUFaculty.h"

@interface BUFaculty() {
    NSMutableArray *pObjects;
}

@end

@implementation BUFaculty

- (instancetype)initWithNumber:(NSString *)number
                       andName:(NSString *)name {
    self = [super init];
    if (self) {
        pObjects = [NSMutableArray array];
        self.name = name;
        self.number = number;
    }
    return self;
}

- (NSString *)title {
    NSRange range = [self.name rangeOfString:@" " options:NSCaseInsensitiveSearch];
    NSMutableString *viewString = [NSMutableString stringWithString:self.name];
    NSString *number = [NSString stringWithFormat:@" (№%@)", _number];
    [viewString insertString:number atIndex:range.location];
    return [NSString stringWithString:viewString];
}

- (void)addCathedral:(id)cathedral {
    [pObjects addObject:cathedral];
}

- (NSArray *)allObjects {
    NSMutableArray *objects = [NSMutableArray arrayWithObject:self.dean];
    [objects addObjectsFromArray:pObjects];
    return [objects copy];
}

- (NSArray *)cathedrals {
    return [pObjects copy];
}

@end
