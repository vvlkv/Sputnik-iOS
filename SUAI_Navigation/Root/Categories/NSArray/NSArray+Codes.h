//
//  NSArray+Codes.h
//  SUAI_Navigation
//
//  Created by Виктор on 23.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Codes)

+ (NSArray *)codesFromDictionary:(NSDictionary *)codes;
+ (NSArray *)codesFromDictionaryWithoutInfo:(NSDictionary *)codes;

@end
