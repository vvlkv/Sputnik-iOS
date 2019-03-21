//
//  ChooseEntityMessageView.h
//  Sputnik
//
//  Created by Виктор on 21/03/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ChooseEntityMessageView;
@protocol ChooseEntityMessageViewDelegate <NSObject>
@required
- (void)didTapOnGoToSettingsButtonInMessageView:(ChooseEntityMessageView *)messageView;

@end

@interface ChooseEntityMessageView : UIView

@property (strong, nonatomic) NSString *messageText;
@property (assign, nonatomic) BOOL isButtonHidden;

@property (weak, nonatomic) id <ChooseEntityMessageViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
