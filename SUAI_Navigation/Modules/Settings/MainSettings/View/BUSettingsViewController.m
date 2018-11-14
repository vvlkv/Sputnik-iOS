//
//  BUSettingsViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewController.h"
#import "BUSettingsViewController+DataSource.h"
#import "BUSettingsViewController+Delegate.h"

@interface BUSettingsViewController () {
    UITableView *settingsTableView;
}

@end

@implementation BUSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Настройки";
    settingsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    settingsTableView.delegate = self;
    settingsTableView.dataSource = self;
    [self.view addSubview:settingsTableView];
    [self.output viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setOutput:(id<BUSettingsViewControllerOutput>)output {
    _output = output;
    self.dataSource = [self.output dataSource];
}

#pragma mark - BUSettingsViewControllerInput

- (void)updateSettings {
    [settingsTableView reloadData];
}

- (void)showFailureMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Данные не загружены :("
                                                                   message:@"Убедитесь, что установлено соединение с интернетом." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ОК"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
