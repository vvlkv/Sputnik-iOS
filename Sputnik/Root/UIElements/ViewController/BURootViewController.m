//
//  BURootViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 13.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootViewController.h"
#import "BUActivityIndicatorView.h"
#import "UIFont+SUAI.h"

@interface BURootViewController () {
    BUActivityIndicatorView *_indicatorView;
    UIView *_failView;
}

@end

@implementation BURootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indicatorView = [[BUActivityIndicatorView alloc] initWithFrame:self.view.bounds];
    _failView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont suaiRobotoFont:RobotoFontMedium size:17.f]}];
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showTabBarUpperLine:YES];
}

- (void)showTabBarUpperLine:(BOOL)isShown {
    UITabBar *tabBar = [[self tabBarController] tabBar];
    tabBar.clipsToBounds = !isShown;
}

- (void)showActivityIndicator {
    [self hideInternetFailView];
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
}

- (void)hideActivityIndicator {
    [_indicatorView stopAnimating];
    [_indicatorView removeFromSuperview];
}

- (void)showFailView:(NSString *)message action:(void(^)(void))action {
    
    _failView.backgroundColor = [UIColor whiteColor];
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [messageLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:13.f]];
    messageLabel.text = message;
    [_failView addSubview:messageLabel];
    [[NSLayoutConstraint constraintWithItem:messageLabel
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual toItem:_failView
                                  attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0] setActive:YES];
    
    [[NSLayoutConstraint constraintWithItem:messageLabel
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual toItem:_failView
                                  attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0] setActive:YES];
    
    [[messageLabel.leftAnchor constraintEqualToAnchor:_failView.leftAnchor] setActive:YES];
    [[messageLabel.rightAnchor constraintEqualToAnchor:_failView.rightAnchor] setActive:YES];
    
    if (action != nil) {
        var *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"Перейти в настройки" forState:UIControlStateNormal];
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn addTarget:self action:@selector(p_navigateToSettings) forControlEvents:UIControlEventTouchUpInside];
        [_failView addSubview:btn];
        [[btn.topAnchor constraintEqualToAnchor:messageLabel.bottomAnchor] setActive:YES];
        [[btn.centerXAnchor constraintEqualToAnchor:_failView.centerXAnchor] setActive:YES];
    }
    
    if (![self.view.subviews containsObject:_failView])
        [self.view addSubview:_failView];
}

- (void)p_navigateToSettings {
    NSUInteger totalControllers = [[self.tabBarController viewControllers] count];
    [self.tabBarController setSelectedIndex:totalControllers - 1];
}

- (void)showInternetFailView {
    [self showFailView:@"Отсутствует подключение к сети :(" action:nil];
}

- (void)hideInternetFailView {
    [_failView removeFromSuperview];
}


@end
