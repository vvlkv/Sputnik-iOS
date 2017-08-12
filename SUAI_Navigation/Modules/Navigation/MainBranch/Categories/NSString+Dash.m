//
//  NSString+Dash.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "NSString+Dash.h"

@implementation NSString (Dash)

+ (NSString *)appendDash:(NSString *)string {
    
    if ([string isEqualToString:@""])
        return string;
    NSString *numberString;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    if ([numberString length] == [string length]) {
        return [NSString stringWithFormat:@"%@-%@", [string substringToIndex:2], [string substringFromIndex:2]];
    }
    
    return string;
}

+ (NSString *)deleteDash:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
