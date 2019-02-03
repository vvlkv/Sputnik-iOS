//
//  UIFont+SUAI.h
//  SUAI_Navigation
//
//  Created by Виктор on 13.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum RobotoFont {
    RobotoFontLight,
    RobotoFontMedium,
    RobotoFontBold,
    RobotoFontRegular
}RobotoFont;

@interface UIFont (SUAI)

+ (UIFont *)suaiRobotoFont:(RobotoFont)font size:(CGFloat)size;

@end
