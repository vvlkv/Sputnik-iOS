//
//  BUReferenceDetailInfoViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 13/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDetailInfoViewController.h"
#import "BUReferenceTableView.h"
#import "UIColor+SUAI.h"
#import "BUReferenceDetailInfoViewController+DataSource.h"
#import "BUReferenceDetailInfoViewController+Delegate.h"

@interface BUReferenceDetailInfoViewController () {
    BUReferenceTableView *tableView;
}

@end

@implementation BUReferenceDetailInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        tableView = [[BUReferenceTableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    }
    self.dataSource = [self.output dataSource];
    
    [self.output viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)reloadData {
    [self.view addSubview:tableView];
}

- (void)showAlertViewControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.output didPressOnAction];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertViewController addAction:okAction];
    [alertViewController addAction:cancelAction];
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}

@end
