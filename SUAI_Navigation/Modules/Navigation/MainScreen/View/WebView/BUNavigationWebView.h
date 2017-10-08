//
//  BUNavigationWebView.h
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUNavigationWebView;
@protocol BUNavigationDelegate <NSObject>
@required
- (void)webViewDidFinishLoad:(BUNavigationWebView *)webView;

@end

@interface BUNavigationWebView : UIView

@property (weak, nonatomic) id <BUNavigationDelegate> delegate;

- (void)refreshMap;
- (NSInteger)showAuditory:(NSString *)auditory;
- (void)showPathFrom:(NSString *)start to:(NSString *)finish;

@end
