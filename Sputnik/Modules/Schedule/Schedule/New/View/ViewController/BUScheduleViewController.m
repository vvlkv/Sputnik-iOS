//
//  BUScheduleNewViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 03/01/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUScheduleViewController.h"

#import "BUScheduleNavigationController.h"

#import "BUScheduleTableViewController.h"
#import "TitleSegmentedControlView.h"
#import "UIViewController+Anchor.h"
#import "SUAIPageViewController.h"

#import "BUScheduleViewControllerOutput.h"

@interface BUScheduleViewController()<TitleSegmentedControlViewDelegate, BUScheduleNavigationControllerControlDelegate> {
    BUScheduleTableViewController *sessionViewController;
    NSMutableArray <__kindof BUScheduleTableViewController *> *viewControllers;
    CGFloat screenWidth;
    NSLayoutConstraint *left;
    NSUInteger selectedControlIndex;
}

@property (strong, nonatomic) SUAIPageViewController *pageVC;
@property (readonly, nonatomic) BUScheduleNavigationController *scheduleNavigationController;

@end

@implementation BUScheduleViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    [self p_configureCalendarItem];
    [self.output viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.scheduleNavigationController.controlDelegate = self;
    [self.output didChangeWeekIndex:self.scheduleNavigationController.weekIndex];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.scheduleNavigationController.controlDelegate = self;
    self.scheduleNavigationController.controlVisible = selectedControlIndex == 0;
}

#pragma mark - Private

- (void)p_configurePageViewController:(NSUInteger)start {
    if (_pageVC != nil)
        return;
    viewControllers = [NSMutableArray array];
    NSArray *titles = @[@"ПН", @"ВТ", @"СР", @"ЧТ", @"ПТ", @"СБ", @"..."];
    for (int i = 0; i < [titles count]; i++) {
        BUScheduleTableViewController *vc = [[BUScheduleTableViewController alloc] initWithIndex:i];
        vc.title = titles[i];
        [viewControllers addObject:vc];
    }
    _pageVC = [[SUAIPageViewController alloc] initWithViewControllers:viewControllers
                                                        activeAtIndex:start];
    _pageVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    NSLayoutConstraint *top = [_pageVC.view.topAnchor constraintEqualToAnchor:self.topAnchor constant:56.f];
    NSLayoutConstraint *bottom = [_pageVC.view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-45.f];
    left = [_pageVC.view.leftAnchor constraintEqualToAnchor:self.leftAnchor];
    NSLayoutConstraint *width = [_pageVC.view.widthAnchor constraintEqualToConstant:screenWidth];
    [self.view addConstraints:@[top, bottom, left, width]];
}

- (void)p_configureSessionView {
    if (sessionViewController != nil)
        return;
    sessionViewController = [[BUScheduleTableViewController alloc] initWithScheduleType:ScheduleTypeSession index:0];
    sessionViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:sessionViewController.view];
    [self addChildViewController:sessionViewController];
    NSLayoutConstraint *top = [sessionViewController.view.topAnchor constraintEqualToAnchor:self.topAnchor constant:56.f];
    NSLayoutConstraint *bottom = [sessionViewController.view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
    NSLayoutConstraint *width = [sessionViewController.view.widthAnchor constraintEqualToConstant:screenWidth];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:sessionViewController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_pageVC.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[top, bottom, width, left]];
    
}

- (void)p_configureTitleView:(NSString *)name {
    NSString *sName = [[name componentsSeparatedByString:@" -"] firstObject];
    TitleSegmentedControlView *titleView = [[TitleSegmentedControlView alloc] initWithTitle:sName
                                                                                      items:@[@"Семестр", @"Сессия"]
                                                                                      start:selectedControlIndex];
    titleView.delegate = self;
    titleView.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 60);
    self.navigationItem.titleView = titleView;
}

- (void)p_configureCalendarItem {
    UIImage *calendarImage = [UIImage imageNamed:@"Calendar.png"];
    UIBarButtonItem *calendarItem = [[UIBarButtonItem alloc] initWithImage:calendarImage style:UIBarButtonItemStylePlain target:self action:@selector(p_calendarAction:)];
    self.navigationItem.rightBarButtonItem = calendarItem;
}

- (void)p_calendarAction:(id)sender {
    [self.output didTapOnCalendar];
}

- (void)p_searchAction {
    [self.output didTapOnSearch];
}


#pragma mark - BUScheduleNewViewControllerOutput

- (void)updateDate:(NSString *)date andWeek:(NSString *)week {
    [self.scheduleNavigationController setDate:date andWeek:week];
}

- (void)updateWeekIndex:(NSUInteger)weekIndex {
    self.scheduleNavigationController.weekIndex = weekIndex;
}

- (void)updateDayMarkers:(NSArray *)markers {
    [_pageVC updateMarkers:markers];
}

- (void)updateSemester {
    for (BUScheduleTableViewController *vc in viewControllers) {
        [vc reloadTableView];
    }
}

- (void)updateEntityName:(NSString *)name {
    [self p_configureTitleView:name];
}

- (void)createScheduleViews:(NSUInteger)startIndex {
    [self hideInternetFailView];
    [self p_configurePageViewController:startIndex];
    [self p_configureSessionView];
}

- (void)showAlertControllerWithItems:(NSArray<NSString *> *)items
                            selected:(void (^) (NSInteger index))selectionBlock {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *item in items) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:item style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (selectionBlock != nil)
                selectionBlock([items indexOfObject:item]);
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
    }
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Отмена"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action) {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlertController:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showSearchIconVisibility:(BOOL)isVisible {
    UIBarButtonItem *searchButton;
    if (isVisible) {
        searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                     target:self
                                                                     action:@selector(p_searchAction)];
    } else {
         searchButton = nil;
    }
    self.navigationItem.leftBarButtonItem = searchButton;
}

- (void)showFailInternetMessage {
    [self showInternetFailView];
}

- (void)showChooseEntityMessage {
    [self hideActivityIndicator];
    [self showFailView:@"Расписание недоступно. Выберите группу или преподавателя в настройках" action:^{}];
}

- (void)showProgress {
    [self showActivityIndicator];
}

- (void)hideProgress {
    [self hideActivityIndicator];
}

- (void)dataSource:(id<BUScheduleTableViewControllerDataSource>)dataSource {
    sessionViewController.dataSource = dataSource;
    [sessionViewController reloadTableView];
    for (BUScheduleTableViewController *vc in viewControllers) {
        vc.dataSource = dataSource;
        [vc reloadTableView];
    }
}

- (void)delegate:(id<BUScheduleTableViewControllerDelegate>)delegate {
    sessionViewController.delegate = delegate;
    for (BUScheduleTableViewController *vc in viewControllers) {
        vc.delegate = delegate;
    }
}


#pragma mark - TitleSegmentedControlViewDelegate

- (void)segmentedControl:(TitleSegmentedControlView *)control
   didSelectSegmentIndex:(NSUInteger)index {
    selectedControlIndex = index;
    self.scheduleNavigationController.controlVisible = selectedControlIndex == 0;
    left.constant = selectedControlIndex == 0 ? 0 : screenWidth * -1;
    if (selectedControlIndex == 0)
        self.pageVC.view.hidden = NO;
    
    __weak typeof(self) welf = self;
    [UIView animateWithDuration:.3 animations:^{
        [welf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        welf.pageVC.view.hidden = self->selectedControlIndex == 1;
    }];
}

- (BUScheduleNavigationController *)scheduleNavigationController {
    return (BUScheduleNavigationController *)self.navigationController;
}


#pragma mark - BUScheduleNavigationControllerControlDelegate

- (void)navigationController:(BUScheduleNavigationController *)navVC didChangeWeekTypeControl:(NSUInteger)index {
    [self.output didChangeWeekIndex:index];
}

@end
