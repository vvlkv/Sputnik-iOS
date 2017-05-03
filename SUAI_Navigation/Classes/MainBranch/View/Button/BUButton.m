//
//  BUButton.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUButton.h"

@implementation BUButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self standardInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self standardInit];
    }
    return self;
}

- (void)standardInit {
    self.backgroundColor = [UIColor colorWithRed:0.f green:118.f/255.f blue:255.f/255.f alpha:1.0f];
    self.frame = CGRectMake(0, 0, 117, 30);
    self.layer.cornerRadius = 5.0f;
    self.titleLabel.textColor = [UIColor whiteColor];
}

@end
