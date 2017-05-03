//
//  BIAuditoryInfoViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAuditoryInfoViewController.h"
#import "BUInfoTableView.h"
#import "BUConcreteInfoModel.h"
#import "BUButton.h"

@interface BUAuditoryInfoViewController ()<BUInfoTableViewDataSource> {
    BUConcreteInfoModel *model;
    BUInfoTableView *tableView;
}

@property (weak, nonatomic) IBOutlet BUButton *showButton;

@end

@implementation BUAuditoryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    model = [[BUConcreteInfoModel alloc] initWithData:self.data];
    tableView = [[NSBundle mainBundle] loadNibNamed:@"BUInfoTableView"
                                              owner:self
                                            options:nil][0];
    tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, CGRectGetHeight(self.view.frame) - 64 - 200);
    tableView.dataSource = self;
    self.navigationController.view.clipsToBounds = YES;
    [self.view addSubview:tableView];
}


#pragma mark - BUInfoTableViewDataSource

- (NSUInteger)numberOfRowsInTableView:(BUInfoTableView *)tableView forSection:(NSUInteger)section {
    return [model itemsCount];
}

- (NSString *)tableView:(BUInfoTableView *)tableView titleAtIndex:(NSUInteger)index inSection:(NSUInteger)section {
    return [model titleAtIndex:index];
}

- (NSString *)tableView:(BUInfoTableView *)tableView titleForHeader:(NSUInteger)index {
    return [model tableHeader];
}

@end
