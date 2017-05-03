//
//  BUConcreteInfoModel.m
//  SUAI_Navigation
//
//  Created by Виктор on 30.04.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUConcreteInfoModel.h"
#import "BUItem.h"

@interface BUConcreteInfoModel() {
    BUDean *model;
}

@end
@implementation BUConcreteInfoModel

- (instancetype)initWithData:(id)data
{
    self = [super init];
    if (self) {
        model = (BUDean *)data;
    }
    return self;
}

- (NSUInteger)itemsCount {
    return [model infoFields] - 1;
}

- (NSString *)titleAtIndex:(NSUInteger)index {
    return [model activeFields][index + 1];
}

- (NSString *)tableHeader {
    return [model activeFields][0];
}

@end
