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

@interface BURootNavigationController ()

@end

@implementation BURootNavigationController

- (void)configureBarColor {
    [self.navigationBar setBackIndicatorImage:[UIImage new]];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    self.navigationBar.backgroundColor = [UIColor clearColor];
    
    
    CAGradientLayer *layer = [UIColor suaiGradientColorFrom:[UIColor suaiBlueColor] to:[UIColor suaiLightPurpleColor]];
    layer.frame = CGRectMake(0, 0, self.navigationBar.bounds.size.width, self.navigationBar.bounds.size.height);
    UIGraphicsBeginImageContext(layer.bounds.size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.navigationBar.barTintColor = [UIColor colorWithPatternImage:image];
    
}

- (void)initializeNavBarStyle {
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navBar.shadowImage = [UIImage new];
    navBar.translucent = YES;
    
    UIView *behindView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height + navBar.frame.size.height)];
    CAGradientLayer *layer = [UIColor suaiGradientColorFrom:[UIColor suaiBlueColor] to:[UIColor suaiLightPurpleColor]];
    layer.frame = behindView.bounds;
    [behindView.layer insertSublayer:layer atIndex:0];
    [self.navigationController.view insertSubview:behindView belowSubview:navBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBarColor];
}

@end
