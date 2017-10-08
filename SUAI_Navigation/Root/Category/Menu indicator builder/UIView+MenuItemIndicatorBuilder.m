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
            break;
        case WeekTypeBlue:
            
            break;
        case WeekTypeBoth:
            break;
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
