//
//  BUInfoTableView.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUInfoTableView.h"
#import "BUTableViewInfoCellNamed.h"
#import "BUTableViewInfoCellNormal.h"
#import "BUTableHeaderView.h"

@interface BUInfoTableView()<UITableViewDelegate, UITableViewDataSource> {
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BUInfoTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfRowsInTableView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    NSString *className;
    if ([self.dataSource tableView:self cellTypeAtIndex:indexPath.row] == 0) {
        className = @"BUTableViewInfoCellNamed";
    } else {
        className = @"BUTableViewInfoCellNormal";
    }
    
    BUTableViewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        
        cell = (BUTableViewInfoCell *)[[NSBundle mainBundle] loadNibNamed:className
                                             owner:self
                                           options:nil][0];
        cell.userInteractionEnabled = [self.dataSource tableView:self
                                interactionEnabledForCellAtIndex:indexPath.row];
        
        NSString *imageName = [self.dataSource tableView:self imageNameAtIndex:indexPath.row];
        
        cell.image = [UIImage imageNamed:imageName];
        cell.title = [self.dataSource tableView:self
                                   titleAtIndex:indexPath.row];
        if ([cell isKindOfClass:[BUTableViewInfoCellNamed class]]) {
            ((BUTableViewInfoCellNamed *)cell).titleDescription = [self.dataSource cellDescriptionForTableView:self];
        }
    }
    self.tableView.estimatedRowHeight = 100;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource tableView:self titleForHeader:section];
}


#pragma mark - UITableViewDelegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BUTableHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"BUTableHeaderView" owner:self options:nil][0];
    [headerView changeTextAlignment:NSTextAlignmentCenter];
    headerView.title = [self.dataSource tableView:self titleForHeader:section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate tableView:self didSelectedRowAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[BUTableViewInfoCellNamed class]]) {
        cell.frame = CGRectMake(0, 0, self.frame.size.width, 53);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.f;
}

@end
