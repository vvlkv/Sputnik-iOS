//
//  BUAbstractFacultyItem.m
//  SUAI_Navigation
//
//  Created by Виктор on 04.05.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUAbstractFacultyItem.h"

@interface BUAbstractFacultyItem() {
    NSString *header;
}

@end


@implementation BUAbstractFacultyItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.imageIcons removeObject:@"Clock icon"];
    }
    return self;
}

- (void)setHeader:(NSString *)content {
    header = content;
}

@end
