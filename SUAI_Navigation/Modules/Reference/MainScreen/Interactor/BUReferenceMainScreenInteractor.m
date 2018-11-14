//
//  BUReferenceMainScreenInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceMainScreenInteractor.h"
#import "BUSUAIJSONParser.h"

@interface BUReferenceMainScreenInteractor() <BUSUAIParserDelegate> {
    BUSUAIJSONParser *parser;
}

@end

@implementation BUReferenceMainScreenInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle]
                                                                   pathForResource:@"information" ofType:@"json"]];
        parser = [[BUSUAIJSONParser alloc] initWithData:jsonData];
        parser.delegate = self;
    }
    return self;
}

- (void)activate {
    [parser parseInformation];
}

#pragma mark - BUSUAIParserDelegate

- (void)didLoadInformation:(NSDictionary *)information {
    [self.output didLoadReference:@[information[@"faculties"], information[@"departments"]]];
}

@end
