//
//  BUNewsInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUAINews;
@protocol BUNewsInteractorOutput <NSObject>

@required
- (void)didObtainNews:(NSArray<SUAINews *> *)news;
- (void)didObtainFail;

- (void)didChangeInternetReachability:(BOOL)isReachable;

@end
