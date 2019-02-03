//
//  BUNewsDetailInfoInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUAINews;
@protocol BUNewsDetailInfoInteractorOutput <NSObject>

@required
- (void)didObtainNews:(SUAINews *)news;
- (void)didLoadFailed;

- (void)didChangeInternetReachability:(BOOL)isReachable;

@end
