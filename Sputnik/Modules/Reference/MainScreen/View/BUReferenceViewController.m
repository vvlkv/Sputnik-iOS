//
//  BUReferenceViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 05/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceViewController.h"
#import "UIColor+SUAI.h"
#import "BUCustomSegmentedControl.h"
#import "BUReferenceViewController+Delegate.h"
#import "BUReferenceViewController+DataSource.h"
#import "BUReferenceTableViewCell.h"
#import "BUSearchResultsTableViewController.h"
#import "BUNewStyleSearchController.h"

@interface BUReferenceViewController () <BUCustomSegmentDelegate, UISearchResultsUpdating> {
    UITableView *tableView;
    BUCustomSegmentedControl *segmentedControl;
    UIView *segmentView;
    BUSearchResultsTableViewController *searchResultsController;
    BUNewStyleSearchController *search;
}

@end

@implementation BUReferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.title = @"Справочник";
    [self initSearchResultsController];
    [self initTableView];
    [self initSegmentedControl];
}

- (void)initSearchResultsController {
    searchResultsController = [[BUSearchResultsTableViewController alloc] init];
    searchResultsController.delegate = [self.output searchDelegate];
    searchResultsController.dataSource = [self.output searchDataSource];
    search = [[BUNewStyleSearchController alloc] initWithSearchResultsController:searchResultsController];
    search.searchResultsUpdater = self;
}

- (void)initTableView {
    tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.delegate = [self.output delegate];
    self.dataSource = [self.output dataSource];
    if (@available(iOS 11.0, *)) {
        tableView.frame = (CGRect){self.view.bounds.origin, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 29};
        self.navigationController.navigationBar.prefersLargeTitles = NO;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
        self.navigationItem.searchController = search;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        tableView.frame = (CGRect){self.view.bounds.origin, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 29 - 16};
        tableView.tableHeaderView = search.searchBar;
    }
    
    self.definesPresentationContext = YES;
    
    UINib *nib = [UINib nibWithNibName:@"BUReferenceTableViewCell"
                                bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"cellId"];
    
    [self.view addSubview:tableView];
}

- (void)initSegmentedControl {
    CGFloat segmentHeight = 29.f;
    segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - segmentHeight - 16.f, self.view.frame.size.width, segmentHeight + 16.f)];
    segmentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segmentView];
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, segmentView.frame.size.width, .5f);
    topBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [segmentView.layer addSublayer:topBorder];
    segmentedControl = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Институты", @"Отделы"] andType:BUSegmentTypeNormal];
    segmentedControl.delegate = self;
    segmentedControl.frame = CGRectMake(8, 8, self.view.frame.size.width - 16, segmentHeight);
    [segmentView addSubview:segmentedControl];
}

- (void)showTabBarUpperLine:(BOOL)isShown {
    UITabBar *tabBar = [[self tabBarController] tabBar];
    tabBar.clipsToBounds = !isShown;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showTabBarUpperLine:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 45.f);
    segmentView.frame = CGRectMake(0, self.view.frame.size.height - 29 - 16.f, self.view.frame.size.width, 29 + 16.f);
}


#pragma mark - BUCustomSegmentDelegate

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self.output didPressSegmentController:selectedScope];
}


#pragma mark - BUReferenceViewControllerInput

- (void)updateTableView {
    [tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)updateSearchTableView {
    [searchResultsController reload];
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.output didEnterSearchText:[[searchController searchBar] text]];
}

@end
