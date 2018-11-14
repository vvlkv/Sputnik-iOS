//
//  BUAppDataContainer.h
//  SUAI_Navigation
//
//  Created by Виктор on 05.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUAppDataContainer : NSObject

@property (readonly, nonatomic) NSString *entity;
@property (readonly, nonatomic) NSUInteger type;
@property (readonly, nonatomic) NSUInteger startScreenIndex;

+ (instancetype)instance;

- (NSDictionary *)entityCodes;
- (void)loadCodes;
- (void)writeCodes:(NSDictionary *)codes;
- (void)overwriteEntityWithName:(NSString *)name andType:(NSUInteger)type;
- (void)overwriteStartScreenIndex:(NSUInteger)index;

@end
