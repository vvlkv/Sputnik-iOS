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
#import "WireFrames.h"

@interface BURootTabBarViewController () {
    BOOL isFirstStart;
}

@end

@implementation BURootTabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureViewControllers];
        [self configureTabView];
        isFirstStart = NO;
    }
    return self;
}

- (void)configureViewControllers {
    UIViewController *newsVC = [BUNewsWireFrame assembly];
    UIViewController *scheduleVC = [BUScheduleWireFrame assembly];
    UIViewController *navigationVC = [BUNavigationWireFrame assembly];
    UIViewController *infoVC = [BUReferenceWireFrame assembly];
    UIViewController *settingsVC = [BUSettingsWireFrame assembly];
    
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
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor suaiBlueColor] }
                                             forState:UIControlStateSelected];
    self.tabBar.translucent = NO;
    self.tabBar.items[0].title = @"Новости";
    self.tabBar.items[0].image = [UIImage imageNamed:@"NewsNormal"];
    self.tabBar.items[0].selectedImage = [[UIImage imageNamed:@"NewsFill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[1].title = @"Расписание";
    self.tabBar.items[1].image = [UIImage imageNamed:@"ScheduleNormal"];
    self.tabBar.items[1].selectedImage = [[UIImage imageNamed:@"ScheduleFill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[2].title = @"Навигация";
    self.tabBar.items[2].image = [UIImage imageNamed:@"NavigationNormal"];
    self.tabBar.items[2].selectedImage = [[UIImage imageNamed:@"NavigationFill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[3].title = @"Справочник";
    self.tabBar.items[3].image = [UIImage imageNamed:@"InformationNormal"];
    self.tabBar.items[3].selectedImage = [[UIImage imageNamed:@"InformationFill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.items[4].title = @"Настройки";
    self.tabBar.items[4].image = [UIImage imageNamed:@"SettingsNormal"];
    self.tabBar.items[4].selectedImage = [[UIImage imageNamed:@"SettingsFill"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *isFirstLaunch = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"];
    if (isFirstLaunch == nil) {
        isFirstStart = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstLaunch"];
        UIViewController *greetingsVC = [BUGreetingsWireFrame assemblyGreetings];
        [self presentViewController:greetingsVC animated:YES completion:nil];
    } else if (!isFirstStart) {
        NSString *isAppIntroWasShown = [[NSUserDefaults standardUserDefaults] objectForKey:@"isAppIntroWasShown"];
        if (isAppIntroWasShown == nil) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isAppIntroWasShown"];
            NSString *alertText = @"По техническим причинам сервис навигации временно недоступен. Приносим извинения за предоставленные неудобства.";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Предупреждение"
                                                                           message:alertText
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alert addAction:okAction];
//            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

@end
