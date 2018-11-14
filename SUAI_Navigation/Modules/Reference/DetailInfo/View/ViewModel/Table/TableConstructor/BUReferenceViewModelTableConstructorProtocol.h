//
//  BUReferenceViewModelTableConstructorProtocol.h
//  SUAI_Navigation
//
//  Created by Виктор on 22/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUReferenceViewModelTableConstructorProtocol <NSObject>

@required
- (NSArray *)createModelFrom:(id)model;

@end
