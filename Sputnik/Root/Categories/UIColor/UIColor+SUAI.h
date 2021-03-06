//
//  UIColor+SUAI.h
//  SUAI_Navigation
//
//  Created by Виктор on 13.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SUAI)

+ (UIColor *)suaiNavigationGradientFromColor;
+ (UIColor *)suaiNavigationGradientMidColor;
+ (UIColor *)suaiNavigationGradientToColor;
+ (UIColor *)suaiPurpleColor;
+ (UIColor *)suaiBlueColor;
+ (UIColor *)suaiDarkBlueColor;
+ (UIColor *)suaiRedColor;
+ (UIColor *)suaiLightPurpleColor;
+ (UIColor *)suaiGrayColor;
+ (UIColor *)suaiReferenceBackgroundGrayColor;
+ (CAGradientLayer *)suaiGradientColorFrom:(UIColor *)fromColor to:(UIColor *)toColor;

@end
