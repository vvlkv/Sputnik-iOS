//
//  BUGroupSettingsView.h
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUGroupSettingsView;
@protocol BUGroupSettingsViewDelegate <NSObject>

@required
- (void)didPressGroupSettingsInTableView:(BUGroupSettingsView *)tableView;

@end

@protocol BUGroupSettingsViewDataSource <NSObject>

@required
- (NSString *)entityNameForTableView:(BUGroupSettingsView *)tableView;
- (NSString *)entityTypeForTableView:(BUGroupSettingsView *)tableView;

@end

@interface BUGroupSettingsView : UIView

@property (weak, nonatomic) id <BUGroupSettingsViewDataSource> dataSource;
@property (weak, nonatomic) id <BUGroupSettingsViewDelegate> delegate;

- (void)refresh;

@end
