//
//  BUSettingsViewControllerInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITableViewDelegate;
@protocol UITableViewDataSource;

@protocol BUSettingsViewControllerInput <NSObject>

- (void)updateSettings;
- (void)showFailureMessage;
- (void)setDataSource:(id<UITableViewDataSource>)dataSource;

@end
