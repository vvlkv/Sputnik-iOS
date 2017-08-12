//
//  BUCapsPageView.m
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUCapsPageView.h"
#import "UIColor+SUAI.h"
#import "CAPSPageMenu.h"
#import "BUScheduleContentViewController.h"

@interface BUCapsPageView () <CAPSPageMenuDelegate> {
    NSMutableArray *controllerArray;
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

- (void)initCapsPage {
    UIColor *blueColor = [UIColor suaiBlueColor];
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(4.3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(YES),
                                 CAPSPageMenuOptionMenuItemSeparatorPercentageHeight: @(0.1),
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor: blueColor,
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: [UIColor blackColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: blueColor,
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor grayColor],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor whiteColor]};
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray
                                                        frame:CGRectMake(0.0, 41.f, self.frame.size.width, self.frame.size.height - 41.f)
                                                      options:parameters];
    _pageMenu.delegate = self;
    [self addSubview:_pageMenu.view];
}

- (void)initCapsPageViews {
    NSString *capsTitle[7] = {@"ПН", @"ВТ", @"СР", @"ЧТ", @"ПТ", @"СБ", @"КП"};
    controllerArray = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        BUScheduleContentViewController *controller = [[BUScheduleContentViewController alloc] initWithIndex:i
                                                                                                     andType:ScheduleTypeSemester];
        controller.dataSource = self.dataSource;
        controller.delegate = self.delegate;
        controller.view.backgroundColor = [UIColor whiteColor];
        controller.title = capsTitle[i];
        [controllerArray addObject:controller];
    }
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

- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index {
 //   [controller viewWillAppear:YES];
}

- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    [controller viewDidAppear:YES];
}

@end
