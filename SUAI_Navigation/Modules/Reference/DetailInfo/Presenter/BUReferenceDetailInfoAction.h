//
//  BUReferenceDetailInfoAction.h
//  SUAI_Navigation
//
//  Created by Виктор on 26/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceViewModelItemProtocol.h"

@interface BUReferenceDetailInfoAction : NSObject

@property (strong, nonatomic) NSString *value;
@property (assign, nonatomic) ReferenceActionType type;

@end
