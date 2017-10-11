//
//  NSString+Lowercalize.m
//  SUAI_Navigation
//
//  Created by Виктор on 05.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "NSString+Lowercalize.h"

@implementation NSString (Lowercalize)

- (NSString *)lowercalizedString {
    NSString *normalString = [self substringFromIndex:1];
    NSString *lowercaseFirst = [[self lowercaseString] substringToIndex:1];
    return [NSString stringWithFormat:@"%@%@", lowercaseFirst, normalString];
}

@end
