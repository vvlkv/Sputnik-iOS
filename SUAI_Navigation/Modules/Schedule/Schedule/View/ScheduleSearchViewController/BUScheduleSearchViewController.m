//
//  BUScheduleSearchViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 19.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleSearchViewController.h"
#import "BUNewStyleSearchController.h"
#import "BUSUAIGradientNavigationBar.h"
#import "BUCustomSegmentedControl.h"
#import "UIFont+SUAI.h"

@interface BUScheduleSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UINavigationBarDelegate, UISearchResultsUpdating> {
    UITableView *contentsTableView;
    NSArray *filteredData;
    NSArray *entities;
    NSUInteger focusedIndex;
    NSUInteger selectedCellIndex;
    BUNewStyleSearchController *search;
    BOOL isFounded;
}

@end

@implementation BUScheduleSearchViewController

- (instancetype)initWithContents:(NSArray *)contents
{
    self = [super init];
    if (self) {
        focusedIndex = 0;
        filteredData = [[NSArray alloc] init];
        entities = contents;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.title = @"Поиск расписания";
    [self initTableView];
    [self initSearchBar];
}

- (void)initSearchBar {
    search = [[BUNewStyleSearchController alloc] initWithSearchResultsController:nil];
    search.searchBar.placeholder = @"Например, 1740М или Бритов. Г. С.";
    search.searchBar.scopeButtonTitles = @[@"Группы", @"Преподаватели"];
    search.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    search.obscuresBackgroundDuringPresentation = NO;
    if (@available(iOS 11.0, *)) {
        contentsTableView.frame = (CGRect){self.view.bounds.origin, self.view.bounds.size.width, self.view.bounds.size.height};
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.searchController = search;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        contentsTableView.frame = (CGRect){self.view.bounds.origin, self.view.bounds.size.width, self.view.bounds.size.height};
        contentsTableView.tableHeaderView = search.searchBar;
    }
    self.definesPresentationContext = YES;
    search.searchResultsUpdater = self;
}

- (void)initTableView {
    contentsTableView = [[UITableView alloc] init];
    contentsTableView.dataSource = self;
    contentsTableView.delegate = self;
    [self.view addSubview:contentsTableView];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![search.searchBar.text isEqualToString:@""]) {
        return [filteredData count];
    }
    return [entities[focusedIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell.textLabel setFont:[UIFont suaiRobotoFont:RobotoFontRegular size:16]];
    if (![search.searchBar.text isEqualToString:@""]) {
        cell.textLabel.text = filteredData[indexPath.row];
    } else {
        cell.textLabel.text = entities[focusedIndex][indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCellIndex = indexPath.row;
    isFounded = YES;
    [search.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (isFounded) {
        if (![search.searchBar.text isEqualToString:@""]) {
            [self.output didObtainNewSchedule:filteredData[selectedCellIndex] ofType:focusedIndex];
        }
        else {
            [self.output didObtainNewSchedule:entities[focusedIndex][selectedCellIndex] ofType:focusedIndex];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [search.searchBar resignFirstResponder];
}


#pragma mark - UISearchBarDelegate

- (void)searchContentsForSearchText:(NSString *)searchString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains %@", (focusedIndex == 0) ? [searchString uppercaseString] : searchString];
    filteredData = [entities[focusedIndex] filteredArrayUsingPredicate:predicate];
    filteredData = [filteredData sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *value2 = obj2;
        if ([value2 hasPrefix:searchString]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    [contentsTableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [contentsTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    focusedIndex = selectedScope;
    search.searchBar.placeholder = (selectedScope == 0) ? @"Например, 1740М" : @"Например, Бритов Г. С.";
    [self searchContentsForSearchText:search.searchBar.text];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [[searchController searchBar] text];
    [self searchContentsForSearchText:searchString];
}

@end
