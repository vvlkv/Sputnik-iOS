//
//  BUTabBarPresenter.m
//  SUAI_Navigation
//
//  Created by Виктор on 02/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUTabBarPresenter.h"
#import "BUTabBarViewControllerInput.h"
#import "SUAI.h"

@interface BUTabBarPresenter() {
    BOOL viewLoaded;
}

@end

@implementation BUTabBarPresenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        viewLoaded = false;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_codesLoaded) name:kSUAIEntityLoadedNotification object:nil];
    }
    return self;
}

- (void)p_codesLoaded {
    NSString *isFirstLaunch = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"];
    if (isFirstLaunch == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstLaunch"];
        [self.view presentGreetings];
    }
}

- (void)viewDidLoad {
    //Nothing...?
    viewLoaded = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIEntityLoadedNotification object:nil];
}

@end
