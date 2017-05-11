//
//  BUMainViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 24.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUMainViewController.h"
#import "NSString+Dash.h"
#import "BUNavigationWebView.h"
#import "BUToolbarView.h"
#import "BUAuditoryViewController.h"
#import "BUAuditoryInfoViewController.h"
#import "BUAppInfoViewController.h"
#import "BUMainStateModel.h"

@interface BUMainViewController()<BUNavigationDelegate, BUToolbarViewDelegate, BUAuditoryDelegate, BUMainStateModelDelegate> {
    BUNavigationWebView *webView;
    BUMainStateModel *stateModel;
    NSUInteger buttonTag;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet BUToolbarView *toolBar;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation BUMainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    stateModel = [[BUMainStateModel alloc] init];
    stateModel.delegate = self;
    self.indicator.hidesWhenStopped = YES;
    [self.indicator startAnimating];
    
    webView = [[NSBundle mainBundle] loadNibNamed:@"BUNavigationWebView"
                                            owner:self
                                          options:nil][0];
    webView.delegate = self;
    CGRect webFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    webView.frame = webFrame;
    self.toolBar.toolBarDelegate = self;
    
    [self.navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navBar.shadowImage = [UIImage new];
    self.navBar.translucent = YES;
    
    [self.view addSubview:webView];
    [self.view sendSubviewToBack:webView];
    [self.view bringSubviewToFront:self.toolBar];
    [self.view bringSubviewToFront:self.indicator];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.indicator startAnimating];
    [self performSelector:@selector(execute) withObject:nil afterDelay:0.001];
}


#pragma mark - BUNavigationDelegate

- (void)webViewDidFinishLoad:(BUNavigationWebView *)webView {
    [self.indicator stopAnimating];
}


#pragma mark - BUToolbarViewDelegate

- (void)toolbarView:(BUToolbarView *)toolbarView buttonPressed:(NSUInteger)tag {
    NSString *titleLabel = (tag == 0) ? @"Откуда" : @"Куда";
    buttonTag = tag;
    [self performSegueWithIdentifier:@"showAuditories" sender:titleLabel];
}

- (void)toolbarView:(BUToolbarView *)toolbarView cancelButtonPressed:(NSUInteger)tag {
    [stateModel resetAuditoryForDirection:tag];
    [stateModel prepareToExecute];
}

- (void)invertAuditoriesInToolbarView:(BUToolbarView *)toolbarView {
    NSArray *auditories = [stateModel auditories];
    if (![auditories containsObject:@""]) {
        [self setAuditoryTitle:auditories[0] forState:1];
        [self setAuditoryTitle:auditories[1] forState:0];
    }
    [self.indicator startAnimating];
    [self performSelector:@selector(invert) withObject:nil afterDelay:0.001];
}

- (void)execute {
    [stateModel prepareToExecute];
    [self.indicator stopAnimating];
}

- (void)invert {
    [stateModel revertAuditories];
    [stateModel prepareToExecute];
    [self.indicator stopAnimating];
}

- (void)showNormalRoute {
    [stateModel showNormalPath];
    [self.indicator stopAnimating];
}

#pragma mark - BUAuditoryDelegate

- (void)viewController:(BUAuditoryViewController *)viewController foundAuditory:(NSString *)auditory {
    [self setAuditoryTitle:auditory forState:buttonTag];
    [stateModel setAuditory:auditory forDirection:buttonTag];
}


#pragma mark - BUMainStateModelDelegate

- (void)resetStateToDefault:(BUMainStateModel *)stateModel {
    [webView refreshMap];
}

- (void)stateModel:(BUMainStateModel *)stateModel showAuditory:(NSString *)auditory {
    [webView showAuditory:auditory];
}

- (void)stateModel:(BUMainStateModel *)stateModel showPathFrom:(NSString *)from to:(NSString *)to {
    [webView showPathFrom:from to:to];
}

- (void)showAlertController {
    [self showAlertView];
}

#pragma mark - Actions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BUAuditoryViewController *auditoryVC = (BUAuditoryViewController *)[[segue destinationViewController] topViewController];
    auditoryVC.delegate = self;
    auditoryVC.titleText = (NSString *)sender;
}

- (IBAction)showInfoButton:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BUAppInfoViewController" bundle:nil];
    BUAppInfoViewController *infoVc = [sb instantiateViewControllerWithIdentifier:@"BUAppInfoNavID"];
    [self presentViewController:infoVc animated:YES completion:nil];
}

- (void)showAlertView {
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:@"Маршрут построен"
                               message:@"Следуйте за зеленой линией"
                               preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Начать движение"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action)
                         {
                             [self.indicator startAnimating];
                             [self performSelector:@selector(showNormalRoute) withObject:nil afterDelay:0.001];
                             [view dismissViewControllerAnimated:YES completion:nil];
                         }];
    [view addAction:ok];
    [self presentViewController:view animated:YES completion:nil];
}


#pragma mark - Setters

- (void)setAuditoryTitle:(NSString *)title forState:(NSUInteger)state {
    NSString *dashedString = [NSString appendDash:title];
    if (state == 0) {
        [self.toolBar setFromTitle:dashedString];
    } else {
        [self.toolBar setToTitle:dashedString];
    }
}

@end
