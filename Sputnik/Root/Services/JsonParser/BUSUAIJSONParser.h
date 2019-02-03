//
//  BUSUAIParser.h
//  JSONParser
//
//  Created by Виктор on 17.10.2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUSUAIParserDelegate <NSObject>

@required
- (void)didLoadInformation:(NSDictionary *)information;

@end

@interface BUSUAIJSONParser : NSObject

@property (weak, nonatomic) id <BUSUAIParserDelegate> delegate;

- (instancetype)initWithData:(NSData *)data;
- (void)parseInformation;

@end
