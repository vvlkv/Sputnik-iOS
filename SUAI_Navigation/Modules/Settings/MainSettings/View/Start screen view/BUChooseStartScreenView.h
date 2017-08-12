//
//  BUChooseStartScreenView.h
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUChooseStartScreenView;
@protocol BUChooseStartScreenViewDelegate <NSObject>

- (void)tableView:(BUChooseStartScreenView *)tableView didChangeStartScreenIndex:(NSUInteger)index;

@end

@protocol BUChooseStartScreenViewDataSource <NSObject>

@required
- (NSUInteger)startIndexForTableView:(BUChooseStartScreenView *)tableView;

@end

@interface BUChooseStartScreenView : UIView

@property (weak, nonatomic) id <BUChooseStartScreenViewDelegate> delegate;
@property (weak, nonatomic) id <BUChooseStartScreenViewDataSource> dataSource;

- (void)refresh;

@end
