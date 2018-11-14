//
//  BUReferenceDetailInfoViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 17/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUReferenceDetailInfoViewControllerInput <NSObject>

- (void)reloadData;
- (void)showAlertViewControllerWithTitle:(NSString *)title message:(NSString *)message;

@end
