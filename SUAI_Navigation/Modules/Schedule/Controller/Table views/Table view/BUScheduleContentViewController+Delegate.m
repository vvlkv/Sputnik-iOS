//
//  BUScheduleContentViewController+Delegate.m
//  SUAI_Navigation
//
//  Created by Виктор on 22.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleContentViewController+Delegate.h"
#import "BUScheduleHeaderView.h"
#import "UIColor+SUAI.h"
#import "BUPairViewModel.h"

@implementation BUScheduleContentViewController (Delegate)


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 37.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    BUScheduleHeaderView *view = (BUScheduleHeaderView *)[[NSBundle mainBundle] loadNibNamed:@"BUScheduleHeaderView"
                                                                                       owner:self
                                                                                     options:nil][0];
    
    view.frame = CGRectMake(0, 0, tableView.frame.size.width, 37.f);
    BUPairViewModel *pair = [self.dataSource pairAtIndex:section dayIndex:self.index andType:(NSUInteger)self.type];
    view.time = [pair time];
    view.auditory = [pair auditory];
    
    UIColor *headerColor;
    
    switch ([self.dataSource colorForHeaderCellType:(NSUInteger)self.type]) {
        case 0:
            headerColor = [UIColor suaiBlueColor];
            break;
        case 1:
            headerColor = [UIColor suaiRedColor];
            break;
        default:
            headerColor = [UIColor suaiPurpleColor];
            break;
    }
    
    [view setBackgroundColor:headerColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didPressedCellAtIndex:indexPath.section fromDay:self.index];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
