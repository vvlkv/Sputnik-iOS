//
//  BURightPanelMapView.m
//  SPutnikButtons
//
//  Created by Виктор on 23/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BURightPanelMapView.h"
#import "BURightPanelButton.h"
#import "UIColor+SUAI.h"

static NSUInteger sizeBetweenFloors = 20;
@interface BURightPanelMapView () {
    NSMutableArray <BURightPanelButton *> *buttons;
    NSUInteger lastPressedButton;
}

@end

@implementation BURightPanelMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        buttons = [NSMutableArray array];
  //      [self addButtons:frame];
        [self addSeparatorLines:frame];
//        CGFloat yPos;
//        NSUInteger digit;
//        for (NSUInteger i = 0; i < 4; i++) {
//            digit = i + 1;
//            yPos = frame.size.width * (4 - i - 1) + sizeBetweenFloors * (4 - i - 1);
//            BURightPanelButton *button = [[BURightPanelButton alloc] initWithFrame:CGRectMake(0, yPos, frame.size.width, frame.size.width)
//                                                                          andDigit:digit];
//            button.tag = digit;
//            [button addTarget:self action:@selector(didPressOnButton:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:button];
//            [buttons addObject:button];
//        }
//        lastPressedButton = 0;
//        buttons[lastPressedButton].isSelected = YES;
    }
    return self;
}

- (void)addButtons:(CGRect)frame {
    [buttons addObject:[[BURightPanelButton alloc] init]];
    CGFloat yPos;
    NSUInteger digit;
    for (NSUInteger i = 0; i < 4; i++) {
        digit = i + 1;
        yPos = frame.size.width * (4 - i - 1) + sizeBetweenFloors * (4 - i - 1);
        BURightPanelButton *button = [[BURightPanelButton alloc] initWithFrame:CGRectMake(0, yPos, frame.size.width, frame.size.width)
                                                                      andDigit:digit];
        button.tag = digit;
        [button addTarget:self action:@selector(didPressOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [buttons addObject:button];
    }
    lastPressedButton = 0;
    buttons[lastPressedButton].isSelected = YES;
}

- (void)addSeparatorLines:(CGRect)frame {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.layer.cornerRadius = 3.25;
    [self addSubview:lineView];
}

- (void)didPressOnButton:(UIButton *)button {
    buttons[lastPressedButton].isSelected = NO;
    buttons[button.tag].isSelected = YES;
    lastPressedButton = button.tag;
    [self.delegate panelView:self didPressOnButtonWithTag:button.tag];
}

@end
