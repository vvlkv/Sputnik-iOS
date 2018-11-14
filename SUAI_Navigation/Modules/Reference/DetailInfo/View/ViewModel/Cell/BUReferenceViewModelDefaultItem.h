//
//  BUReferenceViewModelDefaultItem.h
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceViewModelBaseItem.h"

@interface BUReferenceViewModelDefaultItem : BUReferenceViewModelBaseItem

@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) BOOL canSelect;

@end
