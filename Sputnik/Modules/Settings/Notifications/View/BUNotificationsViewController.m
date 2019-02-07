//
//  BUNotificationsViewController.m
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsViewController.h"
#import "BUNotificationsViewControllerOutput.h"

@interface BUNotificationsViewController() {
    UITableView *notificationsTableView;
}

@end

@implementation BUNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Центр уведомлений";
    notificationsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:notificationsTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewDidLoad];
}

- (void)dataSource:(id <UITableViewDataSource>)dataSource {
    notificationsTableView.dataSource = dataSource;
    [UIView transitionWithView:notificationsTableView duration:.35f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        [self->notificationsTableView reloadData];
    } completion:nil];
}

- (void)showNeedGrantNotificationsMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Допуск уведомлений"
                                                                   message:@"Необходимо разрешить приложению получать уведомления в настройках"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *goTosettingsAction = [UIAlertAction actionWithTitle:@"Перейти в настройки"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alert addAction:goTosettingsAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
