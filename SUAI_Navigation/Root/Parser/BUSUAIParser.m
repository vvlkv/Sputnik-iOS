//
//  BUSUAIParser.m
//  BUSUAIParser
//
//  Created by Виктор on 09.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BUSUAIParser.h"
#import "ParserConstants.h"
#import "AFNetworking.h"
#import "HTMLParser.h"
#import "NSString+LatinEncoding.h"
#import "BUPair.h"
#import "BUDay.h"
#import "TFHpple.h"

@interface BUSUAIParser() {
    NSData *sessionData;
    NSData *semesterData;
    NSMutableDictionary *sessionCodes;
    NSMutableDictionary *semesterCodes;
    NSMutableArray *sessionSchedule;
    NSMutableArray *semesterSchedule;
}

@end

@implementation BUSUAIParser

- (NSMutableDictionary *)loadCodesFromData:(NSData *)data {
    
    NSMutableDictionary *contents = [[NSMutableDictionary alloc] init];
    NSError *error;
    HTMLParser *parser = [[HTMLParser alloc] initWithData:data error:&error];
    
    if (error) {
        return nil;
    }
    
    HTMLNode *node = [parser body];

    NSString *fields[2] = {@"Groups", @"Teachers"};
    NSArray *classes = [[node findChildOfClass:@"form"] findChildTags:@"span"];
    for (NSInteger i = 0; i < 2; i++) {
        NSMutableDictionary *keys = [[NSMutableDictionary alloc] init];
        NSArray *options = [classes[i] findChildTags:@"option"];
        
        for (HTMLNode *node in options) {
            keys[[[node contents] latinEncoding]] = [node getAttributeNamed:@"value"];
        }
        contents[fields[i]] = keys;
    }
    return contents;
}

- (NSMutableArray *)parseScheduleWithRequest:(NSString *)request {
    NSMutableArray *content = [[NSMutableArray alloc] init];
    NSURL *groupUrl = [NSURL URLWithString:request];
    NSData *scheduleData = [NSData dataWithContentsOfURL:groupUrl];
    TFHpple *scheduleParser = [TFHpple hppleWithHTMLData:scheduleData];
    NSString *schedulePathXQueryString = @"//div[@class='result']";
    NSArray *totalGroups = [scheduleParser searchWithXPathQuery:schedulePathXQueryString];
    BUDay *currentDay;
    BUPair *currentPair;
    NSString *pairTime;
    
    for (TFHppleElement *element in totalGroups) {
        
        for (TFHppleElement *line in [element children]) {
            
            if ([[element children] indexOfObject:line] == 0) {
                continue;
            }
            
            if ([[line tagName] isEqualToString:@"h3"]) {
                currentDay = [[BUDay alloc] initWithDay:[[line firstChild] content]];
                [content addObject:currentDay];
            }
            
            if ([[line tagName] isEqualToString:@"h4"]) {
                pairTime = [[line firstChild] content];
            }
            
            if ([[line tagName] isEqualToString:@"div"]) {
                
                currentPair = [[BUPair alloc] init];
                [currentDay addPair:currentPair];
                currentPair.time = pairTime;
                
                if ([[line raw] containsString:@"class=\"up\""]) {
                    currentPair.color = DayColorRed;
                } else if ([[line raw] containsString:@"class=\"dn\""]) {
                    currentPair.color = DayColorBlue;
                } else {
                    currentPair.color = DayColorBoth;
                }
                
                NSString *content = [[line firstChild] content];
                NSArray *contents = [content componentsSeparatedByString:@" – "];
                if ([contents count] == 3) {
                    currentPair.lessonType = [[contents[0] componentsSeparatedByString:@" "] lastObject];
                    currentPair.name = contents[1];
                    currentPair.auditory = contents[2];
                } else if ([contents count] == 2) {
                    currentPair.name = contents[0];
                    currentPair.auditory = contents[1];
                }
                currentPair.teacherName = [[[line firstChildWithTagName:@"div"] firstChild] content];
            }
        }
    }
    return content;
}

+ (NSDictionary *)codesFromData:(NSData *)data {
    NSMutableDictionary *contents = [[NSMutableDictionary alloc] init];
    NSError *error;
    HTMLParser *parser = [[HTMLParser alloc] initWithData:data error:&error];
    
    if (error) {
        return nil;
    }
    
    HTMLNode *node = [parser body];
    
    
    NSString *fields[2] = {@"Groups", @"Teachers"};
    NSArray *classes = [[node findChildOfClass:@"form"] findChildTags:@"span"];
    for (NSInteger i = 0; i < 2; i++) {
        NSMutableDictionary *keys = [[NSMutableDictionary alloc] init];
        NSArray *options = [classes[i] findChildTags:@"option"];
        
        for (HTMLNode *node in options) {
            keys[[[node contents] latinEncoding]] = [node getAttributeNamed:@"value"];
        }
        contents[fields[i]] = keys;
    }
    return contents;
}

+ (NSArray *)scheduleFromData:(NSData *)data {
    NSMutableArray *content = [[NSMutableArray alloc] init];
    TFHpple *scheduleParser = [TFHpple hppleWithHTMLData:data];
    NSString *schedulePathXQueryString = @"//div[@class='result']";
    NSArray *totalGroups = [scheduleParser searchWithXPathQuery:schedulePathXQueryString];
    BUDay *currentDay;
    BUPair *currentPair;
    NSString *pairTime;
    
    for (TFHppleElement *element in totalGroups) {
        
        for (TFHppleElement *line in [element children]) {
            
            if ([[element children] indexOfObject:line] == 0) {
                continue;
            }
            
            if ([[line tagName] isEqualToString:@"h3"]) {
                currentDay = [[BUDay alloc] initWithDay:[[line firstChild] content]];
                [content addObject:currentDay];
            }
            
            if ([[line tagName] isEqualToString:@"h4"]) {
                pairTime = [[line firstChild] content];
            }
            
            if ([[line tagName] isEqualToString:@"div"]) {
                
                currentPair = [[BUPair alloc] init];
                [currentDay addPair:currentPair];
                currentPair.time = pairTime;
                
                if ([[line raw] containsString:@"class=\"up\""]) {
                    currentPair.color = DayColorRed;
                } else if ([[line raw] containsString:@"class=\"dn\""]) {
                    currentPair.color = DayColorBlue;
                } else {
                    currentPair.color = DayColorBoth;
                }
                
                NSString *content = [[line firstChild] content];
                NSArray *contents = [content componentsSeparatedByString:@" – "];
                if ([contents count] == 3) {
                    currentPair.lessonType = [[contents[0] componentsSeparatedByString:@" "] lastObject];
                    currentPair.name = contents[1];
                    currentPair.auditory = contents[2];
                } else if ([contents count] == 2) {
                    currentPair.name = contents[0];
                    currentPair.auditory = contents[1];
                }
                currentPair.teacherName = [[[line firstChildWithTagName:@"div"] firstChild] content];
                if ([[line raw] containsString:@"class=\"groups\""]) {
                    TFHppleElement *groupsLine = [line searchWithXPathQuery:@"//span[@class='groups']"][0];
                    currentPair.groups = [groupsLine content];
                }
            }
        }
    }
    return content;
}

@end
