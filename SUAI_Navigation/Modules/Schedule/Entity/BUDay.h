//
//  BUday.h
//  SUAI_Parser_New
//
//  Created by Виктор on 08.07.17.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUPair;
@interface BUDay : NSObject

@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic, readonly) NSArray<BUPair *> *pairs;

- (instancetype)initWithDay:(NSString *)day;
- (void)addPair:(BUPair *)pair;

@end
