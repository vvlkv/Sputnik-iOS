//
//  BUSettingsViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewController.h"

@interface BUSettingsViewController ()<UITableViewDelegate> {
    UITableView *settingsTableView;
}

@end

@implementation BUSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Настройки";
    settingsTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                     style:UITableViewStyleGrouped];
    settingsTableView.delegate = self;
    [self.view addSubview:settingsTableView];
    [self.output viewDidLoad];
}

#pragma mark - BUSettingsViewControllerInput

- (void)updateSettings {
    [settingsTableView reloadData];
}

- (void)showFailureMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Данные не загружены :("
                                                                   message:@"Убедитесь, что установлено соединение с сетью или обратитесь к разработчикам для устранения неполадок." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ОК"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    settingsTableView.dataSource = dataSource;
    [settingsTableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectRow:indexPath.row atSection:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
