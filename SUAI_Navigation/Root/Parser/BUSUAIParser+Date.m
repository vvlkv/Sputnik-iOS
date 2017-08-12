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

+ (NSString*)dateFromData:(NSData *)data {
    TFHpple *scheduleParser = [TFHpple hppleWithHTMLData:data];
    NSString *schedulePathXQueryString = @"//div[@class='rasp']/p";
    NSArray *items = [scheduleParser searchWithXPathQuery:schedulePathXQueryString];
    return ((TFHppleElement *)items[0]).content;
}

@end
