//
//  BUChooseStartScreenView.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUChooseStartScreenView.h"

@interface BUChooseStartScreenView () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *startScreenTableView;
    NSUInteger startScreenIndex;
    NSArray *tableContent;
}

@end

@implementation BUChooseStartScreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        tableContent = @[@"Новости", @"Расписание", @"Навигация", @"Справочник"];
        CGRect tableFrame = CGRectMake(0, 28, frame.size.width, frame.size.height);
        startScreenTableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        startScreenTableView.delegate = self;
        startScreenTableView.dataSource = self;
        startScreenTableView.scrollEnabled = NO;
        startScreenTableView.layer.borderWidth = .5f;
        startScreenTableView.layer.cornerRadius = 5.f;
        startScreenTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self addSubview:startScreenTableView];
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, frame.size.width - 16, 20)];
        messageLabel.text = @"СТАРТОВЫЙ ЭКРАН";
//        [messageLabel setTextColor:[UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:114.f/255.f alpha:1.f]];
        [messageLabel setTextColor:[UIColor grayColor]];
        [messageLabel setFont:[UIFont systemFontOfSize:13.f]];
        [self addSubview:messageLabel];
    }
    return self;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    startScreenIndex = indexPath.row;
    [self.delegate tableView:self didChangeStartScreenIndex:startScreenIndex];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [startScreenTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    if (indexPath.row == startScreenIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = tableContent[indexPath.row];
    return cell;
}


- (void)refresh {
    startScreenIndex = [self.dataSource startIndexForTableView:self];
    [startScreenTableView reloadData];
}

#pragma mark - Setters

- (void)setDataSource:(id<BUChooseStartScreenViewDataSource>)dataSource {
    _dataSource = dataSource;
    
}

@end
