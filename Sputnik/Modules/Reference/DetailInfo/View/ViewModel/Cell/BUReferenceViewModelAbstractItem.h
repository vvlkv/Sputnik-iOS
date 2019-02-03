//
//  BUReferenceViewModelAbstractItem.h
//  SUAI_Navigation
//
//  Created by Виктор on 24/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceViewModelItemProtocol.h"

@protocol BUReferenceViewModelItemProtocol;
@interface BUReferenceViewModelBaseItem : NSObject <BUReferenceViewModelItemProtocol>

@property (strong, nonatomic) NSString *value;

- (instancetype)initWithAction:(ReferenceActionType)type;

@end
