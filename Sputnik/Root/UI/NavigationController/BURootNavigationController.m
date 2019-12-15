//
//  BURootNavigationController.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootNavigationController.h"
#import "UIColor+SUAI.h"
#import "UIImage+Gradient.h"
#import "UIFont+SUAI.h"

@implementation BURootNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBarColor];
}

- (void)configureBarColor {
    [self.navigationBar setBackIndicatorImage:[UIImage new]];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    self.navigationBar.backgroundColor = [UIColor clearColor];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.backgroundColor = UIColor.blackColor.CGColor;
    layer.colors = @[(id)[UIColor suaiNavigationGradientFromColor].CGColor,
                     (id)[UIColor suaiNavigationGradientMidColor].CGColor,
                     (id)[UIColor suaiNavigationGradientToColor].CGColor];
    layer.startPoint = CGPointMake(0, 1);
    layer.endPoint = CGPointMake(1, 1);
    layer.locations = @[@0, @0.75, @1];
    layer.frame = CGRectMake(0, 0, self.navigationBar.bounds.size.width, self.navigationBar.bounds.size.height);
    UIGraphicsBeginImageContext(layer.bounds.size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.navigationBar.barTintColor = [UIColor colorWithPatternImage:image];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self configureBarColor];
}

@end
