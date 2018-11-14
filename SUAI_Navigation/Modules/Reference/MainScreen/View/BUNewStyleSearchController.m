//
//  BUReferenceSearchController.m
//  SUAI_Navigation
//
//  Created by Виктор on 28/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewStyleSearchController.h"
#import "UIColor+SUAI.h"

@interface BUNewStyleSearchController ()

@end

@implementation BUNewStyleSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController
{
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {
        [self.searchBar setValue:@"Отмена" forKey:@"_cancelButtonText"];
        self.searchBar.placeholder = @"Поиск";
        if (@available(iOS 11.0, *)) {
            [self customizeCursor];
            self.searchBar.tintColor = [UIColor whiteColor];
            UITextField *searchTextField = [self.searchBar valueForKey:@"searchField"];
            if (searchTextField != nil) {
                UIView *backgroundView = [searchTextField subviews][0];
                backgroundView.backgroundColor = [UIColor whiteColor];
                backgroundView.layer.cornerRadius = 10.f;
                backgroundView.clipsToBounds = YES;
            }
        } else {
            self.searchBar.tintColor = [UIColor suaiBlueColor];
        }
    }
    return self;
}

- (void)customizeCancelButton {
    UIView *view = [[self searchBar] subviews][0];
    NSArray *subviews = [view subviews];
    
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [((UIButton *)subview) setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

- (void)customizeCursor {
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.backgroundColor = [UIColor clearColor];
    for ( UIView *v in [self.searchBar.subviews.firstObject subviews] )
    {
        if ( YES == [v isKindOfClass:[UITextField class]] )
        {
            [((UITextField*)v) setTintColor:[UIColor suaiPurpleColor]];
            break;
        }
    }
}

@end
