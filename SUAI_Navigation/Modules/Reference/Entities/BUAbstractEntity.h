//
//  BUEntity.h
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUAbstractEntity : NSObject

@property (strong, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *title;

@end
