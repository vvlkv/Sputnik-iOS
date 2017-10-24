//
//  BURightPanelButton.m
//  SPutnikButtons
//
//  Created by Виктор on 23/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import "BURightPanelButton.h"

@implementation BURightPanelButton

- (instancetype)initWithFrame:(CGRect)frame
                     andDigit:(NSUInteger)digit {
    self = [super initWithFrame:frame];
    if (self) {
        [self appendImage];
        [self appendDigit:digit];
        [self appendFloorLabel];
    }
    return self;
}

- (void)appendImage {
    [self setImage:[UIImage imageNamed:@"Oval"] forState:UIControlStateNormal];
    [self.imageView setContentMode:UIViewContentModeCenter];
}

- (void)appendFloorLabel {
    UILabel *floorLabel = [[UILabel alloc] init];
    floorLabel.text = @"этаж";
    floorLabel.textAlignment = NSTextAlignmentCenter;
    [floorLabel setFont:[UIFont systemFontOfSize:11.f]];
    floorLabel.frame = CGRectMake(20, 40, 24, 13);
    floorLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:floorLabel];
}

- (void)appendDigit:(NSUInteger)digit {
    UILabel *digitLabel = [[UILabel alloc] init];
    digitLabel.text = [NSString stringWithFormat:@"%ld", digit];
    digitLabel.textAlignment = NSTextAlignmentCenter;
    digitLabel.frame = CGRectMake(21, 4, 22, 46);
    [digitLabel setFont:[UIFont systemFontOfSize:39.f]];
    digitLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:digitLabel];
}

@end
