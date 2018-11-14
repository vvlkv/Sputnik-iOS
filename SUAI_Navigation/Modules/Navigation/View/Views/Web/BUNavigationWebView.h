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
- (void)showAuditory:(NSString *)auditory errCode:(void (^)(NSInteger code))errorCode;
- (void)changeFloor:(NSUInteger)floorNumber;
- (void)changeZoom:(NSUInteger)zoom;
- (void)showPathFrom:(NSString *)start to:(NSString *)finish;

@end
