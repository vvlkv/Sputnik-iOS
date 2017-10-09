//
//  UIView+MenuItemIndicatorBuilder.m
//  SUAI_Navigation
//
//  Created by Виктор on 02.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "UIView+MenuItemIndicatorBuilder.h"
#import "UIColor+SUAI.h"

@implementation UIView (MenuItemIndicatorBuilder)

+ (UIView *)createIndicatorForWeekOfType:(WeekType)weekType {
    UIView *indicatorViewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    indicatorViewBackground.layer.cornerRadius = 2.f;
    
    UIImage *indicatorImage;
    
    switch (weekType) {
        case WeekTypeRed:
//            indicatorViewBackground.backgroundColor = [UIColor suaiRedColor];
            break;
        case WeekTypeBlue:
//            indicatorViewBackground.backgroundColor = [UIColor suaiBlueColor];
            break;
        case WeekTypeBoth: {
//            indicatorViewBackground.backgroundColor = [UIColor clearColor];
//            UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
//            upperView.backgroundColor = [UIColor suaiRedColor];
//            CALayer *layer = [CALayer layer];
//            UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:upperView.bounds
//                                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
//                                                                   cornerRadii:CGSizeMake(2.0, 2.0)];
//            layer.shadowPath = shadowPath.CGPath;
//            upperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//            upperView.layer.mask = layer;
//
//            UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 10, 5)];
//            bottomView.backgroundColor = [UIColor suaiBlueColor];
//            [indicatorViewBackground addSubview:upperView];
//            [indicatorViewBackground addSubview:bottomView];
            break;
        }
        default:
            break;
    }
    UIImageView *indicatorImageView = [[UIImageView alloc] initWithFrame:indicatorViewBackground.frame];
    indicatorImageView.image = indicatorImage;
    indicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
    indicatorImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [indicatorViewBackground addSubview:indicatorImageView];
    return indicatorViewBackground;
}

@end
