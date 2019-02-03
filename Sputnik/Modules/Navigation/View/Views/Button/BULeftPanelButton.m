//
//  BULeftPanelButton.m
//  SPutnikButtons
//
//  Created by Виктор on 24/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BULeftPanelButton.h"

@implementation BULeftPanelButton

- (instancetype)initWithFrame:(CGRect)frame andButtonType:(LeftPanelButtonType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        [self appendButtonImageWithType:type];
    }
    return self;
}

- (void)appendButtonImageWithType:(LeftPanelButtonType)type {
    NSString *imgName = (type == ButtonTypePlus) ? @"ButtonPlus" : @"ButtonMinus";
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
}

@end
