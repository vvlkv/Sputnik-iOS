//
//  BUDean.m
//  SUAIInfoParser
//
//  Created by Виктор on 29.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUDean.h"

@interface BUDean() {
    BOOL isLoaded;
}

@end

@implementation BUDean

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.activeFields = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger)infoFields {
    NSArray *propertiesValue = @[_name, _auditorium, _telephone];
    NSUInteger counter = 0;
    for (NSString *value in propertiesValue) {
        if (![value isEqualToString:@"N/A"] && value != nil) {
            if (!isLoaded)
                [self.activeFields addObject:value];
            counter++;
        }
    }
    isLoaded = YES;
    return counter;
}

@end
