//
//  BUMainViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 24.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUMainViewController.h"
#import "BUNavigationWebView.h"
#import "BUToolbarView.h"
#import "BUAuditoryViewController.h"

@interface BUMainViewController()<BUNavigationDelegate, BUToolbarViewDelegate, BUAuditoryDelegate> {
    BUNavigationWebView *webView;
    NSUInteger buttonTag;
    NSString *startAuditory;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet BUToolbarView *toolBar;

@end

@implementation BUMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.indicator.hidesWhenStopped = YES;
    [self.indicator startAnimating];
    
    webView = [[NSBundle mainBundle] loadNibNamed:@"BUNavigationWebView"
                                            owner:self
                                          options:nil][0];
    webView.delegate = self;
    webView.frame = self.view.frame;
    
    self.toolBar.toolBarDelegate = self;
    [self.toolBar setFromTitle:@"Откуда"];
    [self.toolBar setToTitle:@"Куда"];
    
    [self.view addSubview:webView];
    [self.view sendSubviewToBack:webView];
    [self.view bringSubviewToFront:self.toolBar];
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


#pragma mark - BUAuditoryDelegate

- (void)viewController:(BUAuditoryViewController *)viewController foundAuditory:(NSString *)auditory {
    if (buttonTag == 0) {
        [webView showAuditory:auditory];
    } else {
        [webView showPathFrom:startAuditory to:auditory];
    }
}


#pragma mark - Actions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BUAuditoryViewController *auditoryVC = (BUAuditoryViewController *)[[segue destinationViewController] topViewController];
    auditoryVC.delegate = self;
    auditoryVC.titleText = (NSString *)sender;
}

@end
