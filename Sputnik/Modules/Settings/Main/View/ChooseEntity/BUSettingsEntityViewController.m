//
//  BUSettingsEntityViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsEntityViewController.h"
#import "BUCustomSegmentedControl.h"
#import "BUNewStyleSearchController.h"
#import "UIColor+SUAI.h"

@interface BUSettingsEntityViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating> {
    UITableView *tableView;
    NSUInteger focusedIndex;
    NSArray *filteredData;
    NSArray *codes;
    NSIndexPath *lastIndex;
    NSString *selectedName;
    BUNewStyleSearchController *search;
    BOOL isFounded;
}

@end

@implementation BUSettingsEntityViewController

- (instancetype)initWithContents:(NSArray *)contents
{
    self = [super init];
    if (self) {
        codes = contents;
        focusedIndex = 0;
        filteredData = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeAll;
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    [self initTableView];
    [self initSearchBar];
}

- (void)initTableView {
    tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (void)initSearchBar {
    search = [[BUNewStyleSearchController alloc] initWithSearchResultsController:nil];
    search.searchBar.placeholder = @"Например, 1741 или Бритов. Г. С.";
    search.searchBar.scopeButtonTitles = @[@"Группы", @"Преподаватели"];
    search.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    search.obscuresBackgroundDuringPresentation = NO;
    if (@available(iOS 11.0, *)) {
        tableView.frame = (CGRect){self.view.bounds.origin, self.view.bounds.size.width, self.view.bounds.size.height};
        self.navigationItem.searchController = search;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        tableView.frame = (CGRect){self.view.bounds.origin, self.view.bounds.size.width, self.view.bounds.size.height};
        tableView.tableHeaderView = search.searchBar;
    }
    self.definesPresentationContext = YES;
    search.searchResultsUpdater = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)conform {
//    [self.output didFoundNewEntity:selectedName ofType:focusedIndex];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchContentsForSearchText:(NSString *)searchString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains %@", (focusedIndex == 0) ? [searchString uppercaseString] : searchString];
    filteredData = [codes[focusedIndex] filteredArrayUsingPredicate:predicate];
    filteredData = [filteredData sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *value2 = obj2;
        if ([value2 hasPrefix:searchString]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    [tableView reloadData];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить"
//                                                               style:UIBarButtonItemStylePlain
//                                                              target:self
//                                                              action:@selector(conform)];
//    self.navigationItem.rightBarButtonItem = okItem;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    lastIndex = indexPath;
    if (![search.searchBar.text isEqualToString:@""]) {
        selectedName = filteredData[indexPath.row];
//        [self.output didFoundNewEntity:selectedName ofType:focusedIndex];
    } else {
        selectedName = codes[focusedIndex][indexPath.row];
//        [self.output didFoundNewEntity:selectedName ofType:focusedIndex];
    }
    [search.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![search.searchBar.text isEqualToString:@""]) {
        return [filteredData count];
    }
    return [codes[focusedIndex] count];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [search.searchBar resignFirstResponder];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (![search.searchBar.text isEqualToString:@""]) {
        cell.textLabel.text = filteredData[indexPath.row];
    } else {
        cell.textLabel.text = codes[focusedIndex][indexPath.row];
    }
    return cell;
}


#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searchContentsForSearchText:searchText];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    focusedIndex = selectedScope;
    search.searchBar.placeholder = (selectedScope == 0) ? @"Например, 1741" : @"Например, Бритов Г. С.";
    [self searchContentsForSearchText:search.searchBar.text];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [[searchController searchBar] text];
    [self searchContentsForSearchText:searchString];
}

@end
