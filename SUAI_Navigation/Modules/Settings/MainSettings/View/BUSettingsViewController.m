//
//  BUSettingsViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsViewController.h"
#import "BUGroupSettingsView.h"
#import "BUChooseStartScreenView.h"
#import "BUAboutAppTableView.h"

@interface BUSettingsViewController () <BUGroupSettingsViewDelegate, BUGroupSettingsViewDataSource, BUChooseStartScreenViewDelegate, BUChooseStartScreenViewDataSource, BUAboutAppTableViewDelegate> {
    BUGroupSettingsView *groupSettingsView;
    BUChooseStartScreenView *chooseStartScreenView;
    BUAboutAppTableView *aboutAppView;
}

@end

@implementation BUSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Настройки";
    self.view.backgroundColor = [UIColor colorWithRed:249.f/255.f green:249.f/255.f blue:249.f/255.f alpha:1.f];
    groupSettingsView = [[BUGroupSettingsView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
    groupSettingsView.dataSource = self;
    groupSettingsView.delegate = self;
    [self.view addSubview:groupSettingsView];
    
    chooseStartScreenView = [[BUChooseStartScreenView alloc] initWithFrame:CGRectMake(0, 44*3, self.view.frame.size.width, 44*4)];
    chooseStartScreenView.delegate = self;
    chooseStartScreenView.dataSource = self;
    [self.view addSubview:chooseStartScreenView];
    CGRect aboutAppFrame = CGRectMake(0, self.view.frame.size.height - 88, self.view.frame.size.width, 44);
    
    aboutAppView = [[BUAboutAppTableView alloc] initWithFrame:aboutAppFrame];
    aboutAppView.delegate = self;
    [self.view addSubview:aboutAppView];
    [self.output viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    aboutAppView.frame = CGRectMake(0, self.view.frame.size.height - 88, self.view.frame.size.width, 44);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - BUSettingsViewControllerInput

- (void)updateSettings {
    [groupSettingsView refresh];
    [chooseStartScreenView refresh];
}

- (void)showFailureMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Данные не загружены :("
                                                                   message:@"Убедитесь, что установлено соединение с интернет." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ОК"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - BUGropSettingsViewDelegate

- (void)didPressGroupSettingsInTableView:(BUGroupSettingsView *)tableView {
    [self.output didPressEntitySettings];
}


#pragma mark - BUChooseStartScreenViewDataSource

- (NSUInteger)startIndexForTableView:(BUChooseStartScreenView *)tableView {
    return [self.dataSource startIndex];
}


#pragma mark - BUGroupSettingsViewDataSource

- (NSString *)entityNameForTableView:(BUGroupSettingsView *)tableView {
    return [self.dataSource entityName];
}

- (NSString *)entityTypeForTableView:(BUGroupSettingsView *)tableView {
    return [self.dataSource entityType];
}

- (void)tableView:(BUChooseStartScreenView *)tableView didChangeStartScreenIndex:(NSUInteger)index {
    [self.output didSetStartIndex:index];
}


#pragma mark - BUAboutAppTableViewDelegate

- (void)didPressAboutAppInTableView:(BUAboutAppTableView *)tableView {
    [self.output didPressAboutApp];
}

@end
