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
- (NSUInteger)numberOfRowsInTableView:(BUInfoTableView *)tableView forSection:(NSUInteger)section;
- (NSString *)tableView:(BUInfoTableView *)tableView titleAtIndex:(NSUInteger)index inSection:(NSUInteger)section;
- (NSString *)tableView:(BUInfoTableView *)tableView titleForHeader:(NSUInteger)index;

@end

@interface BUInfoTableView : UIView

@property (weak, nonatomic) id<BUInfoTableViewDataSource> dataSource;

@end
