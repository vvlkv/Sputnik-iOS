//
//  BUNewsDetailInfoDataSource.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUAINews;
@protocol BUNewsDetailInfoDataSource <NSObject>

@required
- (SUAINews *)newsModel;

@end
