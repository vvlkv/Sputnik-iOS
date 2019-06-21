//
//  BUNotificationsViewController.m
//  Sputnik
//
//  Created by Виктор on 06/02/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUNotificationsViewController.h"
#import "BUNotificationsViewControllerOutput.h"
#import "UIViewController+Anchor.h"

@interface BUNotificationsViewController()<UITableViewDelegate> {
    UITableView *notificationsTableView;
}

@end

static NSString *sliderCellName = @"BUSliderTableViewCell";

@implementation BUNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Центр уведомлений";
    notificationsTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStyleGrouped];
    notificationsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    notificationsTableView.delegate = self;
    [self.view addSubview:notificationsTableView];
    [[notificationsTableView.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[notificationsTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
    [[notificationsTableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[notificationsTableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    UINib *nib = [UINib nibWithNibName:sliderCellName bundle:nil];
    [notificationsTableView registerNib:nib forCellReuseIdentifier:@"sliderID"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(p_didTapOnSaveButton)];
    notificationsTableView.estimatedRowHeight = 75.f;
    [self.output viewDidLoad];
}

- (void)reloadSectionsInSet:(NSIndexSet *)set {
    [notificationsTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

- (void)insertSections {
    [notificationsTableView beginUpdates];
    [notificationsTableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    [notificationsTableView insertSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    [notificationsTableView endUpdates];
}

- (void)deleteSections {
    [notificationsTableView beginUpdates];
    [notificationsTableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    [notificationsTableView deleteSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    [notificationsTableView endUpdates];
}

- (void)dataSource:(id <UITableViewDataSource>)dataSource {
    notificationsTableView.dataSource = dataSource;
    [notificationsTableView reloadData];
}

- (void)showNeedGrantNotificationsMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Допуск уведомлений"
                                                                   message:@"Необходимо разрешить приложению получать уведомления в настройках"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *goTosettingsAction = [UIAlertAction actionWithTitle:@"Перейти в настройки"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }];
    [alert addAction:goTosettingsAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)p_didTapOnSaveButton {
    [self.output didTapOnSave];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

@end
