//
//  BUSUAIParser.h
//  BUSUAIParser
//
//  Created by Виктор on 09.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUSUAIParser : NSObject

+ (NSDictionary *)codesFromData:(NSData *)data;
+ (NSArray *)scheduleFromData:(NSData *)data;
//+ (NSString *)weekFromData:(NSData *)data;

@end
