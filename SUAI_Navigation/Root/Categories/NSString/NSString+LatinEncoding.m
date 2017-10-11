//
//  NSString+LatinEncoding.m
//  BUSUAIParser
//
//  Created by Виктор on 09.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "NSString+LatinEncoding.h"

@implementation NSString (LatinEncoding)

- (NSString *)latinEncoding {
    const char *charValue = [self cStringUsingEncoding:NSISOLatin1StringEncoding];
    if (charValue != NULL) {
        NSString *returnStr = [[NSString alloc]initWithCString:charValue encoding:NSUTF8StringEncoding];
        return returnStr;
    }
    return self;
}

@end
