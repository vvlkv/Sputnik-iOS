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
//#import "BUButton.h"

@interface BUAuditoryInfoViewController ()<BUInfoTableViewDataSource, BUInfoTableViewDelegate, UINavigationControllerDelegate> {
    BUConcreteInfoModel *model;
    BUInfoTableView *tableView;
}

@end 

@implementation BUAuditoryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    model = [[BUConcreteInfoModel alloc] initWithData:self.data];
    tableView = (BUInfoTableView *)[[NSBundle mainBundle] loadNibNamed:@"BUInfoTableView"
                                              owner:self
                                            options:nil][0];
    self.navigationController.delegate = self;
    CGRect size = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    tableView.frame = size;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.navigationController.view.clipsToBounds = YES;
    [self.view addSubview:tableView];
    [self.view sendSubviewToBack:tableView];
}


#pragma mark - BUInfoTableViewDataSource

- (NSUInteger)numberOfRowsInTableView:(BUInfoTableView *)tableView {
    return [model itemsCount];
}

- (NSString *)tableView:(BUInfoTableView *)tableView titleAtIndex:(NSUInteger)index {
    return [model titleAtIndex:index];
}

- (NSString *)tableView:(BUInfoTableView *)tableView titleForHeader:(NSUInteger)index {
    return [model tableHeader];
}

- (NSUInteger)tableView:(BUInfoTableView *)tableView cellTypeAtIndex:(NSUInteger)index {
    return [model cellTypeAtIndex:index];
}

- (NSString *)cellDescriptionForTableView:(BUInfoTableView *)tableView {
    return [model cellDescription];
}

- (NSString *)tableView:(BUInfoTableView *)tableView imageNameAtIndex:(NSUInteger)index {
    return [model imageNameAtIndex:index];
}

- (BOOL)tableView:(BUInfoTableView *)tableView interactionEnabledForCellAtIndex:(NSUInteger)index {
    return [model isSelectableAtIndex:index];
}


#pragma mark - BUInfoTableViewDelegate

- (void)tableView:(BUInfoTableView *)tableView didSelectedRowAtIndex:(NSUInteger)index {
    [self makeActionWithName:[model imageNameAtIndex:index] andIndex:index];
}

- (void)makeActionWithName:(NSString *)name andIndex:(NSUInteger)index {
    if ([name isEqualToString:@"Phone icon"]) {
        NSString *phoneNumber = [[[model titleAtIndex:index] componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:+%@", phoneNumber];
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
        [[UIApplication sharedApplication] openURL:phoneURL];
    } else {
        [self dismiss];
    }
}

#pragma mark - Actions

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate viewController:self didDismissedWithAuditory:[model auditory]];
}

@end
