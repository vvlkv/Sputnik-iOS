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
#import "ChooseEntityMessageView.h"

@interface BURootViewController()<ChooseEntityMessageViewDelegate> {
    BUActivityIndicatorView *_indicatorView;
    ChooseEntityMessageView *messageView;
}

@end

NSString *const kMessageViewName = @"ChooseEntityMessageView";

@implementation BURootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indicatorView = [[BUActivityIndicatorView alloc] initWithFrame:self.view.bounds];
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
    
    messageView = (ChooseEntityMessageView *)[[NSBundle mainBundle] loadNibNamed:kMessageViewName
                                                                           owner:self
                                                                         options:nil][0];
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
    [self hideFailView];
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
}

- (void)hideActivityIndicator {
    [_indicatorView stopAnimating];
    [_indicatorView removeFromSuperview];
}

- (void)showFailView:(NSString *)message withButton:(BOOL)button {
    [self hideActivityIndicator];
    messageView.delegate = self;
    messageView.messageText = message;
    messageView.isButtonHidden = !button;
    messageView.contentMode = UIViewContentModeCenter;
    messageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:messageView];
}

- (void)didTapOnGoToSettingsButtonInMessageView:(ChooseEntityMessageView *)messageView {
    NSUInteger totalControllers = [[self.tabBarController viewControllers] count];
    [self.tabBarController setSelectedIndex:totalControllers - 1];
}


- (void)hideFailView {
    [messageView removeFromSuperview];
}


@end
