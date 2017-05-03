//
//  BUDean.h
//  SUAIInfoParser
//
//  Created by Виктор on 29.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUDean : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *definition;
@property (strong, nonatomic) NSString *auditorium;
@property (strong, nonatomic) NSString *telephone;
@property (readonly, nonatomic) NSUInteger infoFields;
@property (strong, nonatomic) NSMutableArray *activeFields;

@end
