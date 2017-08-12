//
//  BUSessionView.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSessionView.h"
#import "BUScheduleContentViewController.h"

@interface BUSessionView () {
    BUScheduleContentViewController *sessionTableView;
}

@end

@implementation BUSessionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        sessionTableView = [[BUScheduleContentViewController alloc] initWithIndex:0 andType:ScheduleTypeSession];
        [self addSubview:sessionTableView.view];
    }
    return self;
}

- (void)refresh {
    [sessionTableView refresh];
}

- (void)updateFrame:(CGRect)frame {
    sessionTableView.view.frame = frame;
}


#pragma mark - Setters

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
    sessionTableView.delegate = self.delegate;
}

- (void)setDataSource:(id)dataSource {
    _dataSource = dataSource;
    sessionTableView.dataSource = self.dataSource;
}

@end
