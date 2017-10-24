//
//  BURightPanelMapView.m
//  SPutnikButtons
//
//  Created by Виктор on 23/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BURightPanelMapView.h"
#import "BURightPanelButton.h"

@interface BURightPanelMapView () {
    
}

@end

@implementation BURightPanelMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat yPos;
        NSUInteger digit;
        for (NSUInteger i = 0; i < 4; i++) {
            digit = 4 - i;
            yPos = frame.size.width * i + 8 * i;
            BURightPanelButton *button = [[BURightPanelButton alloc] initWithFrame:CGRectMake(0, yPos, frame.size.width, frame.size.width)
                                                                          andDigit:digit];
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
