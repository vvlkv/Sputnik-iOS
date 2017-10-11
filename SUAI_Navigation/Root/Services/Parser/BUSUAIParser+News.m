//
//  BUSUAIParser+News.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSUAIParser+News.h"
#import "TFHpple.h"
#import "BUNews.h"
#import "NSString+RemoveSlashes.h"

@implementation BUSUAIParser (News)

+ (NSArray *)allNewsFromData:(NSData *)data {
    NSMutableArray *contents = [NSMutableArray array];
    TFHpple *scheduleParser = [TFHpple hppleWithHTMLData:data];
    NSString *schedulePathXQueryString = @"//div[@class='item-news']";
    NSArray *totalGroups = [scheduleParser searchWithXPathQuery:schedulePathXQueryString];
    for (TFHppleElement *element in totalGroups) {
        BUNews *news = [[BUNews alloc] init];
        TFHppleElement *childElement = [element firstChildWithTagName:@"a"];
        TFHppleElement *sourceElement = [childElement firstChildWithTagName:@"h3"];
        
        news.publicationId = [childElement objectForKey:@"href"];
        news.imageSource = [[childElement firstChildWithTagName:@"img"] objectForKey:@"src"];
        news.text = [childElement firstChildWithTagName:@"p"].text;
        news.date = [sourceElement firstChildWithTagName:@"span"].text;
        news.header = [((TFHppleElement *)[[sourceElement childrenWithTagName:@"text"] lastObject]).content removeSlashes];
        
        [contents addObject:news];
    }
    return contents;
}

+ (id)loadNewsFromData:(NSData *)data {
    TFHpple *scheduleParser = [TFHpple hppleWithHTMLData:data];
    
    TFHppleElement *header = ((TFHppleElement *)[scheduleParser searchWithXPathQuery:@"//div[@class='header']"][0]);
    TFHppleElement *headerElement = [header firstChildWithTagName:@"h1"];
    BUNews *news = [[BUNews alloc] init];
    news.date = [[headerElement firstChildWithTagName:@"span"] text];
    news.header = [((TFHppleElement *)[[headerElement childrenWithTagName:@"text"] lastObject]).content removeSlashes];
    
    NSString *schedulePathXQueryString = @"//div[@class='col-xs-9']";
    TFHppleElement *newsElement = ((TFHppleElement *)[scheduleParser searchWithXPathQuery:schedulePathXQueryString][0]);
    NSMutableArray *textElements = [NSMutableArray array];
    
    for (TFHppleElement *element in newsElement.children) {
        
        if ([[[element attributes] objectForKey:@"class"] isEqualToString:@"lead"])
            news.subHeader = [element text];
        
        if ([element firstChildWithTagName:@"a"] != nil && news.imageSource == nil) {
            news.imageSource = [[element firstChildWithTagName:@"a"] objectForKey:@"href"];
        }
        
        if ([[element tagName] isEqualToString:@"p"] && ![[[element text] removeSlashes] isEqualToString:@""] && [element text] != nil) {
            [textElements addObject:element];
        }
    }
    
    [textElements removeObjectAtIndex:0];
    
    NSMutableString *text = [NSMutableString string];
    
    for (TFHppleElement *textElement in textElements) {
        [text appendString:[textElement text]];
        if ([textElements indexOfObject:textElements] != [textElements count] - 1) {
            [text appendString:@"\n\n"];
        }
    }
    
    news.text = text;
    
    return news;
}


@end
