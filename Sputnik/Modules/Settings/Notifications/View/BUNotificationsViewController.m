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
    notificationsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    notificationsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    notificationsTableView.delegate = self;
    [self.view addSubview:notificationsTableView];
    [[notificationsTableView.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:YES];
    [[notificationsTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:YES];
    [[notificationsTableView.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:YES];
    [[notificationsTableView.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:YES];
    UINib *nib = [UINib nibWithNibName:sliderCellName bundle:nil];
    [notificationsTableView registerNib:nib forCellReuseIdentifier:@"sliderID"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(p_didTapOnSaveButton)];
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

//- (void)reloadData {
//    [self p_reloadWithAnimation];
//}

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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alert addAction:goTosettingsAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)p_didTapOnSaveButton {
    [self.output didTapOnSave];
}

//- (void)p_reloadWithAnimation {
//    [notificationsTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
////    [UIView transitionWithView:notificationnsinsTableView duration:.2f
////                       options:UIViewAnimationOptionTransitionCrossDissolve
////                    animations:^{
////                        [self->notificationsTableView reloadData];
////                    } completion:nil];
//}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

@end
