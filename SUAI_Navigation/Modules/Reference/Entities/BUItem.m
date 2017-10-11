//
//  BUItem.m
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUItem.h"

@interface BUItem() {
    NSMutableArray *icons;
}

@end

@implementation BUItem

- (instancetype)initWithType:(ItemType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)setTime:(NSString *)time {
    _time = time;
    if ([_time isEqualToString:@"N/A"]) {
        [self.imageIcons removeObject:@"Clock icon"];
    }
}

- (void)setName:(NSString *)name {
    [super setName:name];
    [self.imageIcons removeObject:@"Usr icon"];
}

- (NSMutableArray *)infoFields {
    
    NSMutableArray *activeObjects = [super infoFields];
    NSMutableArray *retArray = [NSMutableArray array];
    if (![self.time isEqualToString:@"N/A"]) {
        [activeObjects insertObject:self.time atIndex:1];
    }
    
    for (NSString *value in activeObjects) {
        if (![value isEqualToString:self.name]) {
            [retArray addObject:value];
        }
    }
    return retArray;
}

@end
