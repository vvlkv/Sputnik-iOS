//
//  BUButton.h
//  SUAI_Navigation
//
//  Created by Виктор on 25.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum BUCancelState {
    BUCancelStateVisible,
    BUCancelStateHidden
}BUCancelState;

@class BUButton;
@protocol BUButtonDelegate <NSObject>

@required
- (void)buttonSetAudioryDidPressed:(BUButton *)button;

@optional
- (void)buttonCancelDidPressed:(BUButton *)button;

@end

@interface BUButton : UIView

@property (weak, nonatomic) id <BUButtonDelegate> delegate;

- (void)setCancelButtonState:(BUCancelState)state;
- (void)setTitle:(NSString *)title;

@end
