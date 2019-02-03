//
//  BUMainScreenViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUMainScreenViewController.h"
#import "BUNavigationWebView.h"
#import "BUToolbarView.h"
#import "BURightPanelMapView.h"
#import "BULeftPanelMapView.h"

@interface BUMainScreenViewController () <BUNavigationDelegate, BUToolbarViewDelegate, BUPanelMapViewDelegate> {

}

@property (weak, nonatomic) IBOutlet BUToolbarView *toolBar;
@property (weak, nonatomic) IBOutlet BUNavigationWebView *webView;

@end

@implementation BUMainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.toolBar.toolBarDelegate = self;
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraButtonPressed:)];
    cameraItem.tintColor = [UIColor blackColor];
    [self showActivityIndicator];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (void)appendRightPanel {
    CGRect panelFrame = CGRectMake(self.view.frame.size.width - 64 - 16, self.view.frame.size.height/2 - 140, 52, 280);
    BURightPanelMapView *rightPanel = [[BURightPanelMapView alloc] initWithFrame:panelFrame];
    rightPanel.delegate = self;
    [self.view addSubview:rightPanel];
}

- (void)appendLeftPanel {
    CGRect panelFrame = CGRectMake(16, self.view.frame.size.height/2 - 45, 41, 90);
    BULeftPanelMapView *leftPanel = [[BULeftPanelMapView alloc] initWithFrame:panelFrame];
    leftPanel.delegate = self;
    [self.view addSubview:leftPanel];
}


#pragma mark - BUMainScreenViewControllerInput

- (void)showAuditory:(NSString *)auditory errCode:(void (^)(NSInteger))errorCode {
    [self.webView showAuditory:auditory errCode:^(NSInteger code) {
        errorCode(code);
    }];
}

- (void)setContent:(NSString *)content forButtonAtIndex:(NSUInteger)index {
    if (index == 0) {
        [self.toolBar setFromTitle:content];
    } else {
        [self.toolBar setToTitle:content];
    }
}

- (void)showPathFrom:(NSString *)fromAuditory to:(NSString *)toAuditory {
    [self.webView showPathFrom:fromAuditory to:toAuditory];
}

- (void)showStartScreen {
    [self.webView refreshMap];
}

#pragma mark - BUNavigationDelegate

- (void)webViewDidFinishLoad:(BUNavigationWebView *)webView {
    [self.output didWebViewLoaded];
    [self hideActivityIndicator];
}


#pragma mark - BUToolbarViewDelegate

- (void)toolbarView:(BUToolbarView *)toolbarView buttonPressed:(NSUInteger)tag {
    [self.output didButtonPressed:tag];
}

- (void)toolbarView:(BUToolbarView *)toolbarView cancelButtonPressed:(NSUInteger)tag {
    [self.output didCancelButtonPressed:tag];
}

- (void)invertAuditoriesInToolbarView:(BUToolbarView *)toolbarView {
    [self.output didArrowPressed];
}

- (void)showNormalAlert {
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:@"Маршрут построен"
                               message:@"Следуйте за красной линией"
                               preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Начать движение"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             [self performSelector:@selector(showNormalRoute) withObject:nil afterDelay:0.001];
                             [view dismissViewControllerAnimated:YES completion:nil];
                         }];
    [view addAction:ok];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                 andAction:(NSString *)action {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:action
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showNormalRoute {
    [self showActivityIndicator];
    [self performSelector:@selector(normalRouteSelected) withObject:nil afterDelay:0.4];
}

- (void)normalRouteSelected {
    [self.output didNormalRouteSelected];
    [self hideActivityIndicator];
}

- (void)stopAnimating {
    [self hideActivityIndicator];
}

- (void)startAnimating {
    [self showActivityIndicator];
}


#pragma mark - BUPanelMapViewDelegate

- (void)panelView:(BUPanelMapView *)panelView didPressOnButtonWithTag:(NSUInteger)tag {
    if ([panelView isMemberOfClass:[BURightPanelMapView class]]) {
        [self.webView changeFloor:tag];
    } else {
        [self.webView changeZoom:tag];
    }
}

#pragma mark - Actions

- (void)cameraButtonPressed:(id)tag {
    [self.output didCameraButtonPressed];
}

- (void)receiveAuditory:(NSString *)auditory {
    [self.output didReceivedAuditory:auditory];
}

@end
