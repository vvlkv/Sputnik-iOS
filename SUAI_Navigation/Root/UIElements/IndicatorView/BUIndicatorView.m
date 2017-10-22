//
//  BUIndicatorView.m
//  SUAI_Navigation
//
//  Created by Виктор on 15.10.2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUIndicatorView.h"

@interface BUIndicatorView () {
    UIRectCorner corners;
}

@end

@implementation BUIndicatorView

- (instancetype)initWithFrame:(CGRect)frame andRoundCorners:(UIRectCorner)rectCorners
{
    self = [super initWithFrame:frame];
    if (self) {
        corners = rectCorners;
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat cornerRaduis = self.bounds.size.width/4;
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:self.bounds
                              byRoundingCorners:corners
                              cornerRadii:CGSizeMake(cornerRaduis, cornerRaduis)
                              ];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
