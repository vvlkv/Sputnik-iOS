//
//  BUNavigationWebView.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNavigationWebView.h"

@interface BUNavigationWebView() <UIWebViewDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BUNavigationWebView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (htmlString) {
        [self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] resourceURL]];
    }
}

- (void)refreshMap {
    [self.webView stringByEvaluatingJavaScriptFromString:@"ToNewFloor('main_map')"];
}

- (void)showAuditory:(NSString *)auditory {
    NSString *js = [NSString stringWithFormat:@"SetNewAudFromAndroid(false, '%@')", auditory];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
    [self.webView stringByEvaluatingJavaScriptFromString:@"RoomFinder(false)"];
}

- (void)showPathFrom:(NSString *)start to:(NSString *)finish {
    [self.webView stringByEvaluatingJavaScriptFromString:@"ClearLastResult()"];
    NSString *jsFirst = [NSString stringWithFormat:@"SetNewAudFromAndroid(true, '%@')", start];
    NSString *jsSecond = [NSString stringWithFormat:@"SetNewAudFromAndroid(false, '%@')", finish];
    [self.webView stringByEvaluatingJavaScriptFromString:jsFirst];
    [self.webView stringByEvaluatingJavaScriptFromString:jsSecond];
    [self.webView stringByEvaluatingJavaScriptFromString:@"FindPath()"];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none'"];
    [self.delegate webViewDidFinishLoad:self];
}

@end
