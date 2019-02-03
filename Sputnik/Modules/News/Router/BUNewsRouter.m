//
//  BUNewsRouter.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsRouter.h"
#import <UIKit/UIKit.h>
#import "BUNewsDetailInfoPresenter.h"
#import "BUNewsDetailInfoInteractor.h"
#import "BUNewsDetailInfoViewController.h"

@implementation BUNewsRouter

- (void)pushDetailNewsInfo:(NSString *)newsId fromViewController:(UIViewController *)viewController {
    BUNewsDetailInfoInteractor *detailInfoInteractor = [[BUNewsDetailInfoInteractor alloc] init];
    BUNewsDetailInfoPresenter *detailInfoPresenter = [[BUNewsDetailInfoPresenter alloc] initWithNewsId:newsId];
    BUNewsDetailInfoViewController *detailInfoVC = [[BUNewsDetailInfoViewController alloc] init];
    detailInfoPresenter.view = detailInfoVC;
    detailInfoPresenter.input = detailInfoInteractor;
    detailInfoVC.output = detailInfoPresenter;
    detailInfoInteractor.output = detailInfoPresenter;
    detailInfoVC.dataSource = detailInfoPresenter;
    [viewController.navigationController pushViewController:detailInfoVC animated:YES];
}

@end
