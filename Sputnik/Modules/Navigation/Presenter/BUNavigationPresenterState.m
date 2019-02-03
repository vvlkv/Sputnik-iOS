//
//  BUNavigationPresenterState.m
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNavigationPresenterState.h"

@implementation BUNavigationPresenterState

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.auditories = [NSMutableArray arrayWithObjects:@"", @"", nil];
    }
    return self;
}

@end
