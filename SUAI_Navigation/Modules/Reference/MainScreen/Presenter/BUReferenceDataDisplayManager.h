//
//  BUReferenceDataDisplayManager.h
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceMainScreenContentProtocol.h"

@protocol BUReferenceDataDisplayManagerDelegate

@required
- (void)pushDetailInfoWithEntity:(id)entity;

@end

@interface BUReferenceDataDisplayManager : NSObject <BUReferenceMainScreenContentDataSource, BUReferenceMainScreenContentDelegate>

@property (weak, nonatomic) id <BUReferenceDataDisplayManagerDelegate> delegate;

- (instancetype)initWithReference:(NSArray *)reference;
- (void)activeReference:(NSUInteger)activeReference;

@end
