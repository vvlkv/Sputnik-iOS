//
//  BUCustomButtonView.h
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUCustomButtonView;
@protocol BUCustomButtonViewDelegate <NSObject>

@required
- (void)didPressedAuditoryButton:(BUCustomButtonView *)button;

@optional
- (void)didPressedCancelButton:(BUCustomButtonView *)button;

@end

@interface BUCustomButtonView : UIView

@property (weak, nonatomic) id <BUCustomButtonViewDelegate> delegate;

- (void)setTitle:(NSString *)title;
- (void)setCancelButtonVisibility:(BOOL)isVisible;

@end
