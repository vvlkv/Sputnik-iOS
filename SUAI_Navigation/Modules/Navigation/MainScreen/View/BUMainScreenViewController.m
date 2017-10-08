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

@interface BUMainScreenViewController () <BUNavigationDelegate, BUToolbarViewDelegate> {
    BUNavigationWebView *webView;
    BUToolbarView *toolBar;
    UIActivityIndicatorView *indicator;
}

@end

@implementation BUMainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    webView = [[NSBundle mainBundle] loadNibNamed:@"BUNavigationWebView"
                                            owner:self
                                          options:nil][0];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    CGRect webFrame = CGRectMake(0, -64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) + 64);
    webView.frame = webFrame;
    CGFloat toolbarPosition = self.view.frame.size.height - 44.f - 49.f;
    toolBar = [[BUToolbarView alloc] initWithFrame:CGRectMake(0, toolbarPosition, self.view.frame.size.width, 44.f)];
    toolBar.toolBarDelegate = self;
    
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraButtonPressed:)];
    cameraItem.tintColor = [UIColor blackColor];
    
   // self.navigationItem.rightBarButtonItem = cameraItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    indicator.frame = CGRectMake(self.view.frame.size.width/2 - 10, self.view.frame.size.height/2 - 10, 20, 20);
    [indicator startAnimating];
    [self.view addSubview:webView];
    [self.view addSubview:toolBar];
    [self.view addSubview:indicator];
    
}


#pragma mark - BUMainScreenViewControllerInput

- (void)showAuditory:(NSString *)auditory withAcknowledge:(BOOL)ack {
    if (ack) {
        [self.output didWebViewLoadedWithCode:[webView showAuditory:auditory]];
    } else {
        [webView showAuditory:auditory];
    }
}

- (NSInteger)showAuditory:(NSString *)auditory {
    return [webView showAuditory:auditory];
}

- (void)setContent:(NSString *)content forButtonAtIndex:(NSUInteger)index {
    if (index == 0) {
        [toolBar setFromTitle:content];
    } else {
        [toolBar setToTitle:content];
    }
}

- (void)showPathFrom:(NSString *)fromAuditory to:(NSString *)toAuditory {
    [webView showPathFrom:fromAuditory to:toAuditory];
}

- (void)showStartScreen {
    [webView refreshMap];
}

#pragma mark - BUNavigationDelegate

- (void)webViewDidFinishLoad:(BUNavigationWebView *)webView {
    [self.output didWebViewLoaded];
    [indicator stopAnimating];
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
                               message:@"Следуйте за зеленой линией"
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
    [indicator startAnimating];
    [self performSelector:@selector(normalRouteSelected) withObject:nil afterDelay:0.4];
}

- (void)normalRouteSelected {
    [self.output didNormalRouteSelected];
    [indicator stopAnimating];
}

- (void)stopAnimating {
    [indicator stopAnimating];
}

- (void)startAnimating {
    [indicator startAnimating];
}


#pragma mark - Actions

- (void)cameraButtonPressed:(id)tag {
    [self.output didCameraButtonPressed];
}

- (void)receiveAuditory:(NSString *)auditory {
    [self.output didReceivedAuditory:auditory];
}

@end
