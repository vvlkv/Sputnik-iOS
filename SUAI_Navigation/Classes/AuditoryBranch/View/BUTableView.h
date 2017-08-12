//
//  BUTableView.h
//  SUAI_Navigation
//
//  Created by Виктор on 27.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUTableView;
@protocol BUTableViewDataSource <NSObject>

@required
- (NSUInteger)numberOfRowsInTableView:(BUTableView *)tableView forSection:(NSUInteger)section;
- (NSString *)tableView:(BUTableView *)tableView titleAtIndex:(NSUInteger)index inSection:(NSUInteger)section;
- (NSString *)tableView:(BUTableView *)tableView headerAtIndex:(NSUInteger)index;

@optional
- (NSUInteger)numberOfSectionsInTableView:(BUTableView *)tableView;
- (BOOL)tableView:(BUTableView *)tableView isSelectableCellAtIndex:(NSUInteger)index inSection:(NSUInteger)section;

@end

@protocol BUTableViewDelegate <NSObject>

@required
- (void)tableView:(BUTableView *)tableView didChangedSearchText:(NSString *)searchText;
- (void)tableView:(BUTableView *)tableView didSelectedCellAtIndex:(NSUInteger)index inSection:(NSUInteger)section;

@optional
- (void) didChangedStateInTableView:(BUTableView *)tableView;
@end

@interface BUTableView : UIView

@property (weak, nonatomic) id<BUTableViewDelegate> delegate;
@property (weak, nonatomic) id<BUTableViewDataSource> dataSource;

- (void)prepareForDismiss;
- (void)reloadData;
@end
