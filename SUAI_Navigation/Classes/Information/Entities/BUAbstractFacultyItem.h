//
//  BUAbstractFacultyItem.h
//  SUAI_Navigation
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAbstractItem.h"

@interface BUAbstractFacultyItem : BUAbstractItem

@property (readonly, nonatomic) NSString *parentName;
@property (readonly, nonatomic) NSString *nameDescription;

- (void)setHeader:(NSString *)content;

@end
