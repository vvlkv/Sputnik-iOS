//
//  BUSettingsEntityViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUSettingsEntityViewController.h"
#import "BUCustomSegmentedControl.h"
#import "UIColor+SUAI.h"

@interface BUSettingsEntityViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, BUCustomSegmentDelegate> {
    UITableView *tableView;
    UISearchBar *mySearchBar;
    NSUInteger focusedIndex;
    NSArray *filteredData;
    NSArray *codes;
    NSIndexPath *lastIndex;
    NSString *selectedName;
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
        isFounded = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    
    
    CGRect tableRect = CGRectMake(0, self.view.bounds.origin.y + 88, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 88);
    tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGRect tableRect = CGRectMake(0, self.view.bounds.origin.y + 88, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 88);
    tableView.frame = tableRect;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)conform {
    [self.output didFoundNewEntity:selectedName ofType:focusedIndex];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchContentsForSearchText:(NSString *)searchString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains %@", searchString];
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
    
    UIBarButtonItem *okItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(conform)];
    self.navigationItem.rightBarButtonItem = okItem;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    lastIndex = indexPath;
    if (![mySearchBar.text isEqualToString:@""]) {
        selectedName = filteredData[indexPath.row];
    } else {
        selectedName = codes[focusedIndex][indexPath.row];
    }
    [tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (![mySearchBar.text isEqualToString:@""]) {
        return [filteredData count];
    }
    return [codes[focusedIndex] count];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [mySearchBar resignFirstResponder];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (![mySearchBar.text isEqualToString:@""]) {
        cell.textLabel.text = filteredData[indexPath.row];
    } else {
        cell.textLabel.text = codes[focusedIndex][indexPath.row];
    }
    
    if ([cell.textLabel.text isEqualToString:selectedName]) {
        cell.contentView.backgroundColor = [[UIColor suaiBlueColor] colorWithAlphaComponent:.3f];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.contentView.backgroundColor = [UIColor clearColor];
//        cell.accessoryType = UITableViewCellAccessoryNone;
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


#pragma mark - BUCustomSegmentDelegate

- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    focusedIndex = selectedScope;
    mySearchBar.placeholder = (selectedScope == 0) ? @"Введите номер группы" : @"Введите фамилию преподавателя";
    [self searchContentsForSearchText:mySearchBar.text];
}

@end
