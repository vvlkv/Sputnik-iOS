//
//  BUSearchResultsTableViewController.h
//  SUAI_Navigation
//
//  Created by Виктор on 28/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUReferenceMainScreenContentProtocol.h"

@interface BUSearchResultsTableViewController : UITableViewController

@property (weak, nonatomic) id <BUReferenceMainScreenContentDelegate> delegate;
@property (weak, nonatomic) id <BUReferenceMainScreenContentDataSource> dataSource;

- (void)reload;

@end
