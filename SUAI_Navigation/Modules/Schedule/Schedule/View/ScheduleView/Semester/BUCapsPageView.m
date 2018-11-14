//
//  BUCapsPageView.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCapsPageView.h"
#import "UIColor+SUAI.h"
#import "UIView+MenuItemIndicatorBuilder.h"
#import "CAPSPageMenu.h"
#import "BUScheduleContentViewController.h"

@interface BUCapsPageView () <CAPSPageMenuDelegate, CAPSPageMenuDataSource> {
    NSMutableArray *controllerArray;
    BOOL isFirstLaunch;
}

@property (nonatomic) CAPSPageMenu *pageMenu;

@end


@implementation BUCapsPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCapsPageViews];
        [self initCapsPage];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCapsPageViews];
    [self initCapsPage];
}

- (void)initCapsPage {
    UIColor *purpleColor = [UIColor suaiPurpleColor];
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1),
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor: purpleColor,
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: [UIColor blackColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: purpleColor,
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor grayColor],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor whiteColor]
                                 };
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray
                                                        frame:self.bounds
                                                      options:parameters];
    _pageMenu.delegate = self;
    _pageMenu.dataSource = self;
    [self addSubview:_pageMenu.view];
}

- (void)initCapsPageViews {
    NSString *capsTitle[7] = {@"ПН", @"ВТ", @"СР", @"ЧТ", @"ПТ", @"СБ", @"..."};
    controllerArray = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        BUScheduleContentViewController *controller = [[BUScheduleContentViewController alloc] initWithIndex:i
                                                                                                     andType:ScheduleTypeSemester];
        controller.title = capsTitle[i];
        [controllerArray addObject:controller];
    }
}

- (void)updateDayIndicators {
    [_pageMenu fillMenuItemViews];
}

- (void)refresh {
    for (BUScheduleContentViewController *viewController in controllerArray) {
        [viewController refresh];
    }
}

- (void)moveToPage:(NSUInteger)pageIndex {
    [_pageMenu moveToPage:pageIndex];
}

- (void)setDataSource:(id)dataSource {
    _dataSource = dataSource;
    for (BUScheduleContentViewController *viewController in controllerArray) {
        viewController.dataSource = self.dataSource;
    }
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
    for (BUScheduleContentViewController *viewController in controllerArray) {
        viewController.delegate = self.delegate;
    }
}

- (void)setCapsPageDataSource:(id<BUCapsPageViewDataSource>)capsPageDataSource {
    _capsPageDataSource = capsPageDataSource;
}
//
- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index {
}

#pragma mark - CAPSPageMenuDataSource

- (UIView *)viewForMenuItemViewAtIndex:(NSUInteger)index {
    return [UIView createIndicatorForWeekOfType:(WeekType)[self.capsPageDataSource capsPageView:self dayTypeAtIndex:index]];
}

@end
