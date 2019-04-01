//
//  BUReferenceTableView.m
//  SUAI_Navigation
//
//  Created by Виктор on 15/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceTableView.h"

@implementation BUReferenceTableView

- (instancetype)init
{
    self = [super initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    if (self) {
        self.estimatedRowHeight = 100;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

@end
