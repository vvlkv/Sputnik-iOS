//
//  BUNavigationWebView.m
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNavigationWebView.h"
#import <WebKit/WebKit.h>

const NSString *floorsDescription[] = {@"main_map",@"first_floor", @"second_floor", @"third_floor", @"fourth_floor"};
const NSString *zoomDescription[] = {@"HandleButtonZoom(-1.25)", @"HandleButtonZoom(1.25)"};

@interface BUNavigationWebView() <UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation BUNavigationWebView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initWebView];
}

- (void)initWebView {
    WKPreferences *prefs = [[WKPreferences alloc] init];
    prefs.javaScriptEnabled = YES;
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = prefs;
    
    [configuration.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    
    self.webView = [[WKWebView alloc] initWithFrame:[self bounds] configuration:configuration];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    [self.webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.scrollEnabled = NO;
    [self addSubview:self.webView];
    [self sendSubviewToBack:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"assets"];
    if (url != nil) {
        NSString *folderString = [[url URLByDeletingLastPathComponent] absoluteString];
        NSURL *folderURL = [NSURL fileURLWithPath:folderString isDirectory:YES];
        [self.webView loadFileURL:url allowingReadAccessToURL:folderURL];
    }
}

- (void)refreshMap {
    [self.webView evaluateJavaScript:@"ToNewFloor('main_map')" completionHandler:nil];
}

- (void)showAuditory:(NSString *)auditory errCode:(void (^)(NSInteger code))errorCode {
    NSString *js = [NSString stringWithFormat:@"SetRoomName(false, '%@')", auditory];
    [self.webView evaluateJavaScript:js completionHandler:nil];
    [self.webView evaluateJavaScript:@"RoomFinder(false)" completionHandler:^(id _Nullable ident, NSError * _Nullable error) {
        errorCode([ident integerValue]);
    }];
}

- (void)changeFloor:(NSUInteger)floorNumber {
    NSString *js = [NSString stringWithFormat:@"ToNewFloor('%@')", floorsDescription[floorNumber]];
    [self.webView evaluateJavaScript:js completionHandler:nil];
}

- (void)changeZoom:(NSUInteger)zoom {
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"%@", zoomDescription[zoom]] completionHandler:nil];
}

- (void)showPathFrom:(NSString *)start to:(NSString *)finish {
    NSString *jsFirst = [NSString stringWithFormat:@"SetRoomName(true, '%@')", start];
    NSString *jsSecond = [NSString stringWithFormat:@"SetRoomName(false, '%@')", finish];
    [self.webView evaluateJavaScript:jsFirst completionHandler:nil];
    [self.webView evaluateJavaScript:jsSecond completionHandler:nil];
    [self.webView evaluateJavaScript:@"FindPath()" completionHandler:nil];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
    [self.delegate webViewDidFinishLoad:self];
}


@end
