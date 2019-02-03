//
//  BUNewsDetailInfoInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsDetailInfoInteractor.h"
#import "SUAI.h"

@implementation BUNewsDetailInfoInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_internetReachabilityChanged:)
                                                     name:kSUAIReachabilityNotification object:nil];
    }
    return self;
}

- (void)p_internetReachabilityChanged:(NSNotification *)notification {
    BOOL isReachable = [(NSNumber *)[notification object] boolValue];
    [self.output didChangeInternetReachability:isReachable];
}


#pragma mark - BUNewsDetailInfoInteractorInput

- (void)obtainNews:(NSString *)newsID {
    __weak typeof(self) welf = self;
    [[[SUAI instance] news] loadNews:newsID success:^(SUAINews * _Nonnull news) {
        [welf.output didObtainNews:news];
    } fail:^(SUAIError * _Nonnull err) {
        [welf.output didLoadFailed];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIReachabilityNotification object:nil];
}

@end
