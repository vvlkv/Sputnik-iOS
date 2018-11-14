//
//  BURightPanelButton.m
//  SPutnikButtons
//
//  Created by Виктор on 23/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BURightPanelButton.h"
#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"

@interface BURightPanelButton () {
}

@end

@implementation BURightPanelButton

- (instancetype)initWithFrame:(CGRect)frame
                     andDigit:(NSUInteger)digit {
    self = [super initWithFrame:frame];
    if (self) {
     //   [self appendImage];
        [self appendDigit:digit];
        [self appendFloorLabel];
        self.isSelected = false;
    }
    return self;
}

- (void)appendImage {
    [self setImage:[UIImage imageNamed:@"Oval"] forState:UIControlStateNormal];
    [self.imageView setContentMode:UIViewContentModeRedraw];
    self.imageView.hidden = YES;
    [self setImage:nil forState:UIControlStateFocused];
}

- (void)appendFloorLabel {
    UILabel *floorLabel = [[UILabel alloc] init];
    floorLabel.text = @"этаж";
    floorLabel.textAlignment = NSTextAlignmentCenter;
    [floorLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:9.f]];
    floorLabel.textColor = [UIColor suaiBlueColor];
    floorLabel.frame = CGRectMake(0, self.frame.size.height - 13 - 8, self.frame.size.width, 13);
    floorLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:floorLabel];
}

- (void)appendDigit:(NSUInteger)digit {
    UILabel *digitLabel = [[UILabel alloc] init];
    digitLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)digit];
    digitLabel.textAlignment = NSTextAlignmentCenter;
    digitLabel.frame = CGRectMake(0, 4, self.frame.size.width, 37);
    [digitLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:31.f]];
    digitLabel.textColor = [UIColor suaiBlueColor];
    digitLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:digitLabel];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
//    self.imageView.hidden = !isSelected;
    if (isSelected) {
        [self setColor:[UIColor suaiDarkBlueColor]];
        [self setImage:[UIImage imageNamed:@"Oval"] forState:UIControlStateNormal];
        [self.imageView setContentMode:UIViewContentModeRedraw];
    } else {
        [self setColor:[UIColor suaiBlueColor]];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

- (void)setColor:(UIColor *)color {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            ((UILabel *)view).textColor = color;
        }
    }
}

@end
