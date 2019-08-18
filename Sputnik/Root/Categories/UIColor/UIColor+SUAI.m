//
//  UIColor+SUAI.m
//  SUAI_Navigation
//
//  Created by Виктор on 13.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "UIColor+SUAI.h"

@implementation UIColor (SUAI)

+ (UIColor *)suaiNavigationGradientFromColor {
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:@"GradientFromColor"];
    } else {
        return [self suaiBlueColor];
    }
}

+ (UIColor *)suaiNavigationGradientMidColor {
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:@"GradientMidColor"];
    } else {
        return [UIColor colorWithRed:171.f/255.f green:58.f/255.f blue:141.f/255.f alpha:1.f];
    }
}

+ (UIColor *)suaiNavigationGradientToColor {
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:@"GradientToColor"];
    } else {
        return [self suaiLightPurpleColor];
    }
}

+ (UIColor *)suaiPurpleColor {
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:@"PurpleColor"];
    } else {
        return [UIColor colorWithRed:80.f/255.f green:45.f/255.f blue:127.f/255.f alpha:1.f];
    }
}

+ (UIColor *)suaiBlueColor {
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:@"BlueColor"];
    } else {
        return [UIColor colorWithRed:0.f green:90.f/255.f blue:170.f/255.f alpha:1.f];
    }
}

+ (UIColor *)suaiDarkBlueColor {
    return [UIColor colorWithRed:0.f green:44.f/255.f blue:95.f/255.f alpha:1.f];
}

+ (UIColor *)suaiRedColor {
    return [UIColor colorWithRed:231.f/255.f green:15.f/255.f blue:71.f/255.f alpha:1.f];
}

+ (UIColor *)suaiLightPurpleColor {
    return [UIColor colorWithRed:231.f/255.f green:43.f/255.f blue:112.f/255.f alpha:1.f];
}

+ (UIColor *)suaiGrayColor {
    return [UIColor colorWithRed:216.f/255.f green:216.f/255.f blue:216.f/255.f alpha:1.f];
}

+ (UIColor *)suaiReferenceBackgroundGrayColor {
    return [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f];
}

+ (CAGradientLayer *)suaiGradientColorFrom:(UIColor *)fromColor to:(UIColor *)toColor {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 1);
    gradient.colors = @[(id)[fromColor CGColor], (id)[toColor CGColor]];
    return gradient;
}

@end
