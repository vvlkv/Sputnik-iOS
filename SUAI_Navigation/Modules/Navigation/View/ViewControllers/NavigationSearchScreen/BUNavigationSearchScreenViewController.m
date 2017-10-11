//
//  BUNavigationSearchScreenViewController.m
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNavigationSearchScreenViewController.h"
#import "BUSUAIGradientNavigationBar.h"
#import "UIFont+SUAI.h"

@interface BUNavigationSearchScreenViewController () <UISearchBarDelegate> {
    UISearchBar *mySearchBar;
}

@end

@implementation BUNavigationSearchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismiss)];
    
    self.navigationItem.title = @"Поиск аудитории";
    self.navigationItem.leftBarButtonItem = cancelItem;
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.searchBarStyle = UISearchBarStyleMinimal;
    [mySearchBar setValue:@"Отмена" forKey:@"_cancelButtonText"];
    mySearchBar.delegate = self;
    mySearchBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    mySearchBar.placeholder = @"Например, вход или 5233";
    [self.view addSubview:mySearchBar];
    [mySearchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.output didFoundAuditory:searchBar.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
