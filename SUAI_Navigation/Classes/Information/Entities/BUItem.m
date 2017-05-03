//
//  BUItem.m
//  SUAIInfoParser
//
//  Created by Виктор on 29.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUItem.h"

@interface BUItem() {
    BOOL isLoaded;
}

@end

@implementation BUItem

- (instancetype)initWithType:(ItemType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSString *)shortName {
    return [NSString stringWithFormat:@"Кафедра %@", _number];
}

- (NSUInteger)infoFields {
    NSUInteger parentResult = [super infoFields];
    
    NSString *value = _time;
    if (![value isEqualToString:@"N/A"] && value != nil) {
        parentResult++;
        if (!isLoaded)
            [self.activeFields addObject:value];
    }
    isLoaded = YES;
    return parentResult;
}

@end
