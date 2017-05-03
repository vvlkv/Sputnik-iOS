//
//  BUTableView.m
//  SUAI_Navigation
//
//  Created by Виктор on 27.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUTableView.h"
#import "BUTableHeaderView.h"
#import "BUTableSearchController.h"

typedef enum SearcBarState {
    SearcBarStateUp,
    SearcBarStateDown
} SearcBarState;

@interface BUTableView() <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    SearcBarState barState;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet BUTableSearchController *searchController;

@end

@implementation BUTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    barState = SearcBarStateDown;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchController.delegate = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BUTableHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"BUTableHeaderView" owner:self options:nil][0];
    headerView.title = [self.dataSource tableView:self headerAtIndex:section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[self.dataSource tableView:self headerAtIndex:section] isEqualToString:@""])
        return 0.1f;
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate tableView:self didSelectedCellAtIndex:indexPath.row inSection:indexPath.section];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInTableView:self forSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *testCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!testCell) {
        testCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if ([self.dataSource tableView:self isSelectableCellAtIndex:indexPath.row inSection:indexPath.section]) {
        testCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        testCell.textLabel.textColor = [UIColor blackColor];
    } else {
        testCell.accessoryType = UITableViewCellAccessoryNone;
        testCell.textLabel.textColor = [UIColor colorWithRed:5.f/255.f green:123.f/255.f blue:251.f/255.f alpha:1.f];
    }
    testCell.textLabel.text = [self.dataSource tableView:self
                                            titleAtIndex:indexPath.row
                                               inSection:indexPath.section];
    return testCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSectionsInTableView:self
                                                atIndex:_searchController.selectedScopeButtonIndex];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchController resignFirstResponder];
    if (barState == SearcBarStateUp) {
        [self changeSearchBarPosition];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self.delegate tableView:self didChangedScopeIndex:selectedScope];
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchController sizeToFit];
    [self.searchController setShowsCancelButton:YES animated:NO];
    UIButton *cancelButton = ((UIButton *)[self.searchController valueForKey:@"cancelButton"]);
    [cancelButton setTitle:@"Отмена" forState:UIControlStateNormal];
    if (barState == SearcBarStateDown) {
        [self changeSearchBarPosition];
    }
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchController sizeToFit];
    [self.searchController setShowsCancelButton:NO animated:NO];
    if (barState == SearcBarStateUp) {
        [self changeSearchBarPosition];
    }
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchController resignFirstResponder];
    if (barState != SearcBarStateDown) {
        [self changeSearchBarPosition];
    }
}

- (void)changeSearchBarPosition {
    [self.delegate didChangedStateInTableView:self];
    NSUInteger xPos = (barState == SearcBarStateUp) ? 44 : 0;
    NSUInteger height = (barState == SearcBarStateUp) ? CGRectGetHeight(self.frame) - 44 : CGRectGetHeight(self.frame) + 44;
    [UIView animateWithDuration:.25
                     animations:^{
                         self.frame = CGRectMake(0, xPos, CGRectGetWidth(self.frame), height);
                     }];
    barState ^= 1;
}

@end
