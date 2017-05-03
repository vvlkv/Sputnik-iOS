//
//  BUToolbarView.h
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUToolbarView;
@protocol BUToolbarViewDelegate <NSObject>

@required
- (void)toolbarView:(BUToolbarView *)toolbarView buttonPressed:(NSUInteger)tag;

@end

@interface BUToolbarView : UIToolbar

@property (weak, nonatomic) id <BUToolbarViewDelegate> toolBarDelegate;

- (void)setFromTitle:(NSString *)title;
- (void)setToTitle:(NSString *)title;

@end
