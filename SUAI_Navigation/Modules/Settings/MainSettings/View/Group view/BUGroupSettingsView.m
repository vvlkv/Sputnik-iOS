//
//  BUGroupSettingsView.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUGroupSettingsView.h"

@interface BUGroupSettingsView () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *chooseGroupTableView;
}

@end

@implementation BUGroupSettingsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect tableFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        chooseGroupTableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        chooseGroupTableView.dataSource = self;
        chooseGroupTableView.delegate = self;
        chooseGroupTableView.scrollEnabled = NO;
        chooseGroupTableView.layer.borderWidth = .5f;
        chooseGroupTableView.layer.cornerRadius = 5.f;
        chooseGroupTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self addSubview:chooseGroupTableView];
    }
    return self;
}

- (void)refresh {
    [chooseGroupTableView reloadData];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didPressGroupSettingsInTableView:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.dataSource entityTypeForTableView:self];
    cell.detailTextLabel.text = [self.dataSource entityNameForTableView:self];
    return cell;
}

@end
