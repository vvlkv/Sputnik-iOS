//
//  BUNewsDetailInfoDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUNews;
@protocol BUNewsDetailInfoDataSource <NSObject>

@required
- (BUNews *)newsModel;

@end
