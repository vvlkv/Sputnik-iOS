//
//  BUReferenceTableViewDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 17/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUReferenceViewModelTableType.h"

@class UITableView;
@protocol BUReferenceViewModelItemProtocol;
@protocol BUReferenceTableViewDataSource <NSObject>
@required
- (NSUInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSUInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSUInteger)section;
- (NSUInteger)rowsCountForTableViewModelType:(ViewModelTable)viewModelType;

- (id <BUReferenceViewModelItemProtocol>)modelForTableViewModelType:(ViewModelTable)viewModelType
                                                         withRowAtIndex:(NSUInteger)index;
- (id <BUReferenceViewModelItemProtocol>)tableView:(UITableView *)tableView
                                   modelForSection:(NSUInteger)section
                                           atIndex:(NSUInteger)index;


@end
