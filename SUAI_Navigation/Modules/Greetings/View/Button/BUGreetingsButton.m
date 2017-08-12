//
//  BUGreetingsButton.m
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGreetingsButton.h"
#import "UIColor+SUAI.h"

@implementation BUGreetingsButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor suaiPurpleColor];
    self.layer.cornerRadius = 21.f;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 1.f;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
