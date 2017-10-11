//
//  BUTableHeaderView.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUTableHeaderView : UITableViewCell

@property (strong, nonatomic) NSString *title;

- (void)changeTextAlignment:(NSTextAlignment) alignment;

@end
