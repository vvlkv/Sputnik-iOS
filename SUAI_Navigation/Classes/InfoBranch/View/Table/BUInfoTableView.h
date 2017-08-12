//
//  BUInfoTableView.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUInfoTableView;
@protocol BUInfoTableViewDataSource <NSObject>

@required
- (NSUInteger)numberOfRowsInTableView:(BUInfoTableView *)tableView;
- (NSString *)tableView:(BUInfoTableView *)tableView titleAtIndex:(NSUInteger)index;
- (NSString *)tableView:(BUInfoTableView *)tableView titleForHeader:(NSUInteger)index;
- (NSUInteger)tableView:(BUInfoTableView *)tableView cellTypeAtIndex:(NSUInteger)index;
- (NSString *)cellDescriptionForTableView:(BUInfoTableView *)tableView;
- (NSString *)tableView:(BUInfoTableView *)tableView imageNameAtIndex:(NSUInteger)index;
- (BOOL)tableView:(BUInfoTableView *)tableView interactionEnabledForCellAtIndex:(NSUInteger)index;

@end

@protocol BUInfoTableViewDelegate <NSObject>

@required
- (void)tableView:(BUInfoTableView *)tableView didSelectedRowAtIndex:(NSUInteger)index;

@end

@interface BUInfoTableView : UIView

@property (weak, nonatomic) id<BUInfoTableViewDataSource> dataSource;
@property (weak, nonatomic) id<BUInfoTableViewDelegate> delegate;

@end
