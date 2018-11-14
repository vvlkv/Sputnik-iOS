//
//  BUScheduleContentViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUScheduleContentDataSource.h"

typedef enum ScheduleType {
    ScheduleTypeSemester,
    ScheduleTypeSession
} ScheduleType;

@class BUScheduleDataModel;
@interface BUScheduleContentViewController : UIViewController

@property (assign, nonatomic) NSUInteger index;
@property (assign, readonly) ScheduleType type;
@property (strong, nonatomic) id <BUScheduleContentDataSource> dataSource;
@property (strong, nonatomic) id <BUScheduleContentDelegate> delegate;

- (instancetype)initWithIndex:(NSUInteger)index andType:(ScheduleType)type;
//- (void)updateSubviewsFrame:(CGRect)frame;
- (void)refresh;
- (void)showSchedule;
- (void)showAustronaut;

@end
