//
//  BUScheduleContentDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUScheduleContentViewController;
@class BUPairViewModel;
@protocol BUScheduleContentDataSource <NSObject>

@required

- (NSUInteger)viewTypeAtIndex:(NSUInteger)index andType:(NSUInteger)type;
- (NSString *)titleForViewAtIndex:(NSUInteger)index andType:(NSUInteger)type;
- (NSUInteger)numberOfSectionsInTableView:(BUScheduleContentViewController *)tableView atIndex:(NSUInteger)index andType:(NSUInteger)type;
- (BUPairViewModel *)pairAtIndex:(NSUInteger)section dayIndex:(NSUInteger)index andType:(NSUInteger)type;
- (NSUInteger)colorForHeaderCellType:(NSUInteger)type;
- (NSString *)dateForTableView:(BUScheduleContentViewController *)tableView;
- (NSString *)weekForTableView:(BUScheduleContentViewController *)tableView;

@end

@protocol BUScheduleContentDelegate <NSObject>

@optional
- (void)didPressedCellAtIndex:(NSUInteger)index fromDay:(NSUInteger)day;

@end
