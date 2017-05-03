//
//  BUFaculty.h
//  SUAIInfoParser
//
//  Created by Виктор on 29.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUDean;
@interface BUFaculty : NSObject

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *definition;
@property (strong, nonatomic) NSMutableArray *departments;

- (instancetype)initWithNumber:(NSString *)number
                       andName:(NSString *)name;

@end
