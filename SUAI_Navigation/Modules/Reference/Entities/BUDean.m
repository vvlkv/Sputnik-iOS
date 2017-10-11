//
//  BUDean.m
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUDean.h"

@interface BUDean() {
    NSString *header;
}

@end
@implementation BUDean

- (instancetype)init
{
    self = [super init];
    if (self) {
        header = @"";
    }
    return self;
}

- (NSString *)title {
    return @"Деканат";
}

- (NSString *)parentName {
    return header;
}

- (void)setHeader:(NSString *)content {
    header = content;
}

- (NSString *)nameDescription {
    return @"Декан";
}

@end
