//
//  BUAbstractItem.h
//  BUSUAIEntities
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAbstractEntity.h"

@interface BUAbstractItem : BUAbstractEntity

@property (strong, nonatomic) NSString *auditorium;
@property (strong, nonatomic) NSString *telephone;
@property (readonly, nonatomic) NSMutableArray *infoFields;
@property (strong, nonatomic) NSMutableArray *imageIcons;

@end
