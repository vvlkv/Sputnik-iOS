//
//  BUAboutAppTableView.m
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAboutAppTableView.h"

@interface BUAboutAppTableView () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *aboutAppTableView;
}

@end

@implementation BUAboutAppTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect tableFrame = CGRectMake(0, 0, self.frame.size.width, 44);
        aboutAppTableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        aboutAppTableView.delegate = self;
        aboutAppTableView.dataSource = self;
        aboutAppTableView.scrollEnabled = NO;
        aboutAppTableView.layer.borderWidth = .5f;
        aboutAppTableView.layer.cornerRadius = 5.f;
        aboutAppTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self addSubview:aboutAppTableView];
    }
    return self;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didPressAboutAppInTableView:self];
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
    cell.textLabel.text = @"О приложении";
    return cell;
}

@end
