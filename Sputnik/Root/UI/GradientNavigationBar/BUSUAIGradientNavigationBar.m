//
//  BUSUAINavigationBar.m
//  SUAI_Navigation
//
//  Created by Виктор on 19.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSUAIGradientNavigationBar.h"
#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"
#import "UIImage+Gradient.h"

@implementation BUSUAIGradientNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createGradient];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self createGradient];
}

- (void)createGradient {
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                   NSFontAttributeName:[UIFont suaiRobotoFont:RobotoFontMedium size:17.f]}];
    self.barTintColor = [UIColor clearColor];
    CAGradientLayer *layer = [UIColor suaiGradientColorFrom:[UIColor suaiBlueColor] to:[UIColor suaiLightPurpleColor]];
    layer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self setBackgroundImage:[UIImage imageFromLayer:layer] forBarMetrics:UIBarMetricsDefault];
}

@end
