//
//  BUNewsInteractor.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUNewsInteractor.h"
#import "SUAI.h"

@implementation BUNewsInteractor

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

#pragma mark - BUNewsInteractorInput

- (void)obtainNews {
    __weak typeof(self) welf = self;
    [[[SUAI instance] news] loadAllNews:^(NSArray<SUAINews *> * _Nonnull news) {
        [welf.output didObtainNews:news];
    } fail:^(SUAIError * _Nonnull fail) {
        [welf.output didObtainFail];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSUAIReachabilityNotification object:nil];
}

@end
