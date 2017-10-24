//
//  BULeftPanelButton.h
//  SPutnikButtons
//
//  Created by Виктор on 24/10/2017.
//  Copyright © 2017 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ButtonTypePlus,
    ButtonTypeMinus
} LeftPanelButtonType;

@interface BULeftPanelButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame andButtonType:(LeftPanelButtonType)type;

@end
