//
//  BUCathedral.m
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCathedral.h"

@interface BUCathedral() {
    NSString *header;
    
}

@end

@implementation BUCathedral

- (NSString *)title {
    return [NSString stringWithFormat:@"Кафедра %@", _number];
}

- (void)setHeader:(NSString *)content {
    NSRange range = [content rangeOfString:@" " options:NSCaseInsensitiveSearch];
    NSMutableString *viewString = [NSMutableString stringWithString:content];
    NSString *number = [NSString stringWithFormat:@" (№%@)", _number];
    [viewString insertString:number atIndex:range.location];
    header = viewString;
}

- (NSString *)parentName {
    return header;
}

- (NSMutableArray *)infoFields {
    NSMutableArray *activeObjects = [super infoFields];
    NSMutableArray *retArray = [NSMutableArray array];
    for (NSString *value in activeObjects) {
        if (![value isEqualToString:self.name]) {
            [retArray addObject:value];
        }
    }
    [retArray insertObject:self.headerName atIndex:0];
    return retArray;
}

- (NSString *)nameDescription {
    return @"Заведующий кафедры";
}

@end
