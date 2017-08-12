//
//  BUScheduleSearchViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 19.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleSearchViewController.h"
#import "UIFont+SUAI.h"
#import "BUSUAINavigationBar.h"
#import "UIFont+SUAI.h"
#import "BUCustomSegmentedControl.h"

@interface BUScheduleSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UINavigationBarDelegate, BUCustomSegmentDelegate> {
    UITableView *contentsTableView;
    NSArray *filteredData;
    NSArray *entities;
    UISearchBar *mySearchBar;
    NSUInteger focusedIndex;
    NSUInteger selectedCellIndex;
    BOOL isFounded;
}

@end

@implementation BUScheduleSearchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        focusedIndex = 0;
        filteredData = [[NSArray alloc] init];
        entities = [[NSMutableArray alloc] initWithCapacity:2];
        isFounded = NO;
    }
    return self;
}

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
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.title = @"Поиск расписания";
    CGRect tableFrame = CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88);
    contentsTableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    contentsTableView.dataSource = self;
    contentsTableView.delegate = self;
    [self.view addSubview:contentsTableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
    headerView.backgroundColor = [UIColor colorWithRed:248.f/255.f green:248.f/255.f blue:248.f/255.f alpha:.8f];
    
    
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.searchBarStyle = UISearchBarStyleMinimal;
    [mySearchBar setValue:@"Отмена" forKey:@"_cancelButtonText"];
    mySearchBar.delegate = self;
    mySearchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    mySearchBar.placeholder = @"Введите номер группы";
    [headerView addSubview:mySearchBar];
    BUCustomSegmentedControl *segment = [[BUCustomSegmentedControl alloc] initWithItems:@[@"Группы", @"Преподаватели"] andType:BUSegmentTypeNormal];
    segment.delegate = self;
    segment.frame = CGRectMake(8, 52, self.view.frame.size.width - 16, 29);
    [headerView addSubview:segment];
    [self.view addSubview:headerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![mySearchBar.text isEqualToString:@""]) {
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
    if (![mySearchBar.text isEqualToString:@""]) {
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (isFounded) {
        if (![mySearchBar.text isEqualToString:@""]) {
            [self.output didObtainNewSchedule:filteredData[selectedCellIndex] ofType:focusedIndex];
        }
        else {
            [self.output didObtainNewSchedule:entities[focusedIndex][selectedCellIndex] ofType:focusedIndex];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [mySearchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searchContentsForSearchText:searchText];
}

- (void)searchContentsForSearchText:(NSString *)searchString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains %@", searchString];
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

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    focusedIndex = selectedScope;
    mySearchBar.placeholder = (selectedScope == 0) ? @"Введите номер группы" : @"Введите фамилию преподавателя";
    [self searchContentsForSearchText:mySearchBar.text];
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

@end
