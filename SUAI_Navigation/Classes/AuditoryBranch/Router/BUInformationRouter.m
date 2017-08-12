//
//  BUInformationRouter.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUInformationRouter.h"
#import "BUMainScreenViewController.h"

@implementation BUInformationRouter


#pragma mark - BUAuditoryDelegate

- (void)viewController:(BUAuditoryViewController *)viewController
         foundAuditory:(NSString *)auditory {
    NSArray *viewControllers = [viewController.tabBarController viewControllers];
    UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
    BUMainScreenViewController *navigationController = [[myNavController childViewControllers] firstObject];
    [navigationController receiveAuditory:auditory];
    [viewController.tabBarController setSelectedIndex:2];
}

@end
