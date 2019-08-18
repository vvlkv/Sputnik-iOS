//
//  BUSearchViewController.m
//  Sputnik
//
//  Created by Виктор on 02/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import "BUSearchViewController.h"
#import "BUScheduleSearchViewControllerOutput.h"
#import "UIFont+SUAI.h"

@interface BUSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    BOOL animating;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;

@end

@implementation BUSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    [self p_configureSearchBar];
    [self p_configureTableView];
}

- (void)p_configureSearchBar {
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"Поиск расписания";
    _searchBar.delegate = self;
    _searchBar.backgroundColor = UIColor.clearColor;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_searchBar];
    [[_searchBar.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[_searchBar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0.f] setActive:YES];
    [[_searchBar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0.f] setActive:YES];
}

- (void)p_configureTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [[_tableView.topAnchor constraintEqualToAnchor:_searchBar.bottomAnchor] setActive:YES];
    [[_tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor] setActive:YES];
    [[_tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor] setActive:YES];
    [[_tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
}


#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    if (@available(iOS 13.0, *)) {
        view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        view.backgroundColor = [UIColor whiteColor];
    }
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = [self.output titleForHeaderInSection:section];
    [label setFont:[UIFont systemFontOfSize:24.f weight:UIFontWeightBold]];
    [view addSubview:label];
    [[label.topAnchor constraintEqualToAnchor:view.topAnchor] setActive:YES];
    [[label.bottomAnchor constraintEqualToAnchor:view.bottomAnchor] setActive:YES];
    [[label.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:16.f] setActive:YES];
    [[label.rightAnchor constraintEqualToAnchor:view.rightAnchor] setActive:YES];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.f;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_searchBar.isFirstResponder && !animating)
        [_searchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectRowAtSection:indexPath.section row:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.output numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    var totalSections = [self.output numberOfSections];
    if (totalSections == 0) {
        UIView *view = [[UIView alloc] initWithFrame:tableView.bounds];
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:15.f]];
        label.frame = CGRectMake(0, 0, tableView.frame.size.width, 60);
        label.text = @"Отсутствуют результаты поиска :(";
        [view addSubview:label];
        tableView.backgroundView = view;
    } else {
        tableView.backgroundView = nil;
    }
    return totalSections;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [self.output textForRowInSection:indexPath.section atRow:indexPath.row];
    return cell;
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self animateViewToIdentity:NO];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self animateViewToIdentity:YES];
    return YES;
}

- (void)animateViewToIdentity:(BOOL)shouldIdent {
    animating = YES;
    CGFloat yOffset = self.view.frame.size.height / 6;
    let transform = shouldIdent ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, -yOffset);
    
    [UIView animateWithDuration:[CATransaction animationDuration] * 1.5 animations:^{
        self.view.transform = transform;
    } completion:^(BOOL finished) {
        self->animating = NO;
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.output didChangeSearchContent:searchText];
}

#pragma mark - BUScheduleSearchViewControllerInput

- (void)reloadData {
    [_tableView setContentOffset:CGPointZero];
    [_tableView reloadData];
}

@end
