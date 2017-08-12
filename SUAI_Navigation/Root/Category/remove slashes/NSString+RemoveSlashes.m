//
//  NSString+RemoveSlashes.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "NSString+RemoveSlashes.h"

@implementation NSString (RemoveSlashes)

- (NSString *)removeSlashes {
    NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"\t\n\r"];
    NSString *result = [[self componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
    return result;
}

@end
