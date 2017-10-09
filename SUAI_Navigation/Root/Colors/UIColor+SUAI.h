//
//  UIColor+SUAI.h
//  SUAI_Navigation
//
//  Created by Виктор on 13.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SUAI)

+ (UIColor *)suaiPurpleColor;
+ (UIColor *)suaiBlueColor;
+ (UIColor *)suaiRedColor;
+ (UIColor *)suaiLightGreenColor;
+ (UIColor *)suaiLightPurpleColor;
+ (UIColor *)suaiGrayColor;
+ (CAGradientLayer *)suaiGradientColorFrom:(UIColor *)fromColor to:(UIColor *)toColor;

@end