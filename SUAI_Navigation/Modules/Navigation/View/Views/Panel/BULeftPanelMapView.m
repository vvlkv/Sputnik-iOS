//
//  BULeftPanelMapView.m
//  SPutnikButtons
//
//  Created by Виктор on 24/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BULeftPanelMapView.h"
#import "BULeftPanelButton.h"

@implementation BULeftPanelMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat yPos;
        NSUInteger digit;
        for (NSUInteger i = 0; i < 2; i++) {
            digit = 2 - i;
            yPos = frame.size.width * i + 8 * i;
            BULeftPanelButton *button = [[BULeftPanelButton alloc] initWithFrame:CGRectMake(0, yPos, frame.size.width, frame.size.width)
                                                                          andButtonType:(LeftPanelButtonType)i];
            button.tag = digit;
            [button addTarget:self action:@selector(didPressOnButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)didPressOnButton:(UIButton *)button {
    [self.delegate panelView:self didPressOnButtonWithTag:button.tag];
}

@end
