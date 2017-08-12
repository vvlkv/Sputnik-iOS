//
//  BUAboutAppTableView.h
//  SUAI_Navigation
//
//  Created by Виктор on 12.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUAboutAppTableView;

@protocol BUAboutAppTableViewDelegate <NSObject>

@required
- (void)didPressAboutAppInTableView:(BUAboutAppTableView *)tableView;

@end

@interface BUAboutAppTableView : UIView

@property (weak, nonatomic) id <BUAboutAppTableViewDelegate> delegate;

@end
