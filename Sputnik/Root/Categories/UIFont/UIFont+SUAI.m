//
//  UIFont+SUAI.m
//  SUAI_Navigation
//
//  Created by Виктор on 13.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "UIFont+SUAI.h"

@implementation UIFont (SUAI)

+ (UIFont *)suaiRobotoFont:(RobotoFont)font size:(CGFloat)size {
    
    if (font == RobotoFontMedium)
        return [UIFont fontWithName:@"Roboto-Medium" size:size];
    
    if (font == RobotoFontLight)
        return [UIFont fontWithName:@"Roboto-Light" size:size];
    
    if (font == RobotoFontBold)
        return [UIFont fontWithName:@"Roboto-Bold" size:size];
    
    if (font == RobotoFontRegular)
        return [UIFont fontWithName:@"RobotoCondensed-Regular" size:size];
    
    return nil;
}

@end
