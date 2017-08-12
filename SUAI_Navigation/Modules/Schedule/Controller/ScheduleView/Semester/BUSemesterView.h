//
//  BUSemesterView.h
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUScheduleProtocol.h"

@interface BUSemesterView : UIView <BUScheduleProtocol>

@property (weak, nonatomic) id dataSource;
@property (weak, nonatomic) id  delegate;
@property (weak, nonatomic) id segmentDelegate;

- (void)moveToPage:(NSUInteger)pageIndex;
- (void)updateWeekSegmentWithIndex:(NSUInteger)index;

@end

