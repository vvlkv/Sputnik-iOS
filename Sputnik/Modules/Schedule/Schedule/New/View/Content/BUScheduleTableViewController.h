//
//  BUScheduleTableViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 04/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enums.h"

NS_ASSUME_NONNULL_BEGIN

@class BUScheduleTableViewController;
@class BUPairViewModel;

@protocol BUScheduleTableViewControllerDataSource <NSObject>
@required
- (NSUInteger)tableView:(BUScheduleTableViewController *)tableView numberOfPairsAtIndex:(NSUInteger)index;
- (NSString *)tableView:(BUScheduleTableViewController *)tableView titleForAustronautAtIndex:(NSUInteger)index;
- (BUPairViewModel *)tableView:(BUScheduleTableViewController *)tableView
              viewModelForPair:(NSUInteger)pair
                         atDay:(NSUInteger)day;
- (UIColor *)headerColorForTableView:(BUScheduleTableViewController *)tableView;


@end

@protocol BUScheduleTableViewControllerDelegate <NSObject>
@required
- (void)tableView:(BUScheduleTableViewController *)tableView
    didSelectPair:(NSUInteger)pairIndex
            atDay:(NSUInteger)dayIndex;
@end

@interface BUScheduleTableViewController : UITableViewController

@property (nonatomic, readonly) ScheduleType type;
@property (weak, nonatomic) id <BUScheduleTableViewControllerDataSource> dataSource;
@property (weak, nonatomic) id <BUScheduleTableViewControllerDelegate> delegate;
@property (nonatomic, assign) NSUInteger index;

- (instancetype)initWithIndex:(NSUInteger)index;
- (instancetype)initWithScheduleType:(ScheduleType)type index:(NSUInteger)index;

- (void)reloadTableView;

@end

NS_ASSUME_NONNULL_END
