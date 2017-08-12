//
//  BUSettingsViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUSettingsViewControllerInput <NSObject>

- (void)updateSettings;
- (void)showFailureMessage;

@end
