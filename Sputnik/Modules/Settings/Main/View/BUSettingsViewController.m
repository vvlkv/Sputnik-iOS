//
//  BUSettingsViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewController.h"
#import "UIViewController+Anchor.h"

@interface BUSettingsViewController ()<UITableViewDelegate> {
    UITableView *settingsTableView;
}

@end

@implementation BUSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Настройки";
    settingsTableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                     style:UITableViewStyleGrouped];
    settingsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    settingsTableView.delegate = self;
    [self.view addSubview:settingsTableView];
    [[settingsTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[settingsTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
    [[settingsTableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[settingsTableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
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
