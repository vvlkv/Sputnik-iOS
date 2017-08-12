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

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self configureBarColor];
    }
    return self;
}

- (void)configureBarColor {
    self.navigationBar.barTintColor = [UIColor clearColor];
    CAGradientLayer *layer = [UIColor suaiGradientColorFrom:[UIColor suaiBlueColor] to:[UIColor suaiLightPurpleColor]];
    layer.frame = CGRectMake(0, 0, self.navigationBar.bounds.size.width, self.navigationBar.bounds.size.height + 20);
    [self.navigationBar setBackgroundImage:[UIImage imageFromLayer:layer] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBarColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
