//
//  BUCapsPageView.h
//  SUAI_Navigation
//
//  Created by Виктор on 10.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUCapsPageViewDataSource.h"

@interface BUCapsPageView : UIView

@property (weak, nonatomic) id dataSource;
@property (weak, nonatomic) id delegate;
@property (weak, nonatomic) id <BUCapsPageViewDataSource> capsPageDataSource;

- (void)refresh;
- (void)moveToPage:(NSUInteger)pageIndex;

@end