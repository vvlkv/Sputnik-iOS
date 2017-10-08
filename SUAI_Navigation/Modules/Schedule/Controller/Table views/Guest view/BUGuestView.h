//
//  BUGuestView.h
//  SUAI_Navigation
//
//  Created by Виктор on 08.09.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUGuestView;
@protocol BUGuestViewDelegate <NSObject>

@required
- (void)didPressJumpToSettingsButtonInGuestView:(BUGuestView *)guestView;

@end

@interface BUGuestView : UIView

@property (weak, nonatomic) id <BUGuestViewDelegate> delegate;

@end
