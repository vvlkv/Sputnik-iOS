//
//  BURootTabBarViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 11.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BURootTabBarViewController.h"
#import "BURootNavigationController.h"
#import "BUAppDataContainer.h"
#import "UIColor+SUAI.h"
#import "BUNewsWireFrame.h"
#import "BUScheduleWireFrame.h"
#import "BUNavigationWireFrame.h"
#import "BUInformationWireFrame.h"
#import "BUSettingsWireFrame.h"
#import "BUGreetingsWireFrame.h"

@interface BURootTabBarViewController ()

@end

@implementation BURootTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureViewControllers];
        [self configureTabView];
    }
    return self;
}

- (void)configureViewControllers {
    UIViewController *newsVC = [BUNewsWireFrame assemblyNews];
    UIViewController *scheduleVC = [BUScheduleWireFrame assemblySchedule];
    UIViewController *navigationVC = [BUNavigationWireFrame assemblyNavigation];
    UIViewController *infoVC = [BUInformationWireFrame assemblyInformation];
    UIViewController *settingsVC = [BUSettingsWireFrame assemblySettings];
    
    NSArray *viewControllers = @[newsVC, scheduleVC, navigationVC, infoVC, settingsVC];
    NSMutableArray *navigationControllers = [[NSMutableArray alloc] init];
    
    for (UIViewController *viewController in viewControllers) {
        
        BURootNavigationController *rootController = [[BURootNavigationController alloc] initWithRootViewController:viewController];
        [navigationControllers addObject:rootController];
    }
    
    self.viewControllers = navigationControllers;
    
    NSUInteger startIndex = [[BUAppDataContainer instance] startScreenIndex];
    [self setSelectedIndex:startIndex];
}

- (void)configureTabView {
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
//                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor suaiBlueColor] }
                                             forState:UIControlStateSelected];
    self.tabBar.translucent = NO;
    self.tabBar.items[0].title = @"Новости";
    self.tabBar.items[0].image = [UIImage imageNamed:@"NewsNormal2"];
    self.tabBar.items[0].selectedImage = [[UIImage imageNamed:@"NewsFill2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[1].title = @"Расписание";
    self.tabBar.items[1].image = [UIImage imageNamed:@"ScheduleNormal2"];
    self.tabBar.items[1].selectedImage = [[UIImage imageNamed:@"ScheduleFill2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[2].title = @"Навигация";
    self.tabBar.items[2].image = [UIImage imageNamed:@"NavigationNormal2"];
    self.tabBar.items[2].selectedImage = [[UIImage imageNamed:@"NavigationFill2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[3].title = @"Справочник";
    self.tabBar.items[3].image = [UIImage imageNamed:@"InformationNormal2"];
    self.tabBar.items[3].selectedImage = [[UIImage imageNamed:@"InformationFill2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[4].title = @"Настройки";
    self.tabBar.items[4].image = [UIImage imageNamed:@"SettingsNormal2"];
    self.tabBar.items[4].selectedImage = [[UIImage imageNamed:@"SettingsFill2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *isFirstLaunch = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"];
    if (isFirstLaunch == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstLaunch"];
        UIViewController *greetingsVC = [BUGreetingsWireFrame assemblyGreetings];
        [self presentViewController:greetingsVC animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
