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

static NSString *sliderCellName = @"BUSliderTableViewCell";

@implementation BUNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Центр уведомлений";
    notificationsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:notificationsTableView];
    UINib *nib = [UINib nibWithNibName:sliderCellName bundle:nil];
    [notificationsTableView registerNib:nib forCellReuseIdentifier:@"sliderID"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(p_didTapOnSaveButton)];
    [self.output viewDidLoad];
}

- (void)reloadData {
    [self p_reloadWithAnimation];
}

- (void)dataSource:(id <UITableViewDataSource>)dataSource {
    notificationsTableView.dataSource = dataSource;
    [self p_reloadWithAnimation];
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

- (void)p_reloadWithAnimation {
    [UIView transitionWithView:notificationsTableView duration:.2f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self->notificationsTableView reloadData];
                    } completion:nil];
}

@end
