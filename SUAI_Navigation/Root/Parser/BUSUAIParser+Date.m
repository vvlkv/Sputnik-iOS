//
//  BUSUAIParser+Date.m
//  SUAI_Navigation
//
//  Created by Виктор on 18.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSUAIParser+Date.h"
#import "TFHpple.h"

@implementation BUSUAIParser (Date)

//+ (NSString*)dateFromData:(NSData *)data {
//    if (data == nil)
//        return @"";
//    NSArray *items;
//    @try {
//        TFHpple *scheduleParser = [TFHpple hppleWithHTMLData:data];
//        NSString *schedulePathXQueryString = @"//div[@class='rasp']/p";
//        items = [scheduleParser searchWithXPathQuery:schedulePathXQueryString];
//    } @catch (NSException *exception) {
//        return @"";
//    } @finally {
//        return ((TFHppleElement *)items[0]).content;
//    }
//}

@end
