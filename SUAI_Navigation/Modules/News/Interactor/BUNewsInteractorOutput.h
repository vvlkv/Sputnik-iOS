//
//  BUNewsInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 30.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUNewsInteractorOutput <NSObject>

@required
- (void)didObtainNews:(NSArray *)news;
- (void)didObtainFail;

@end
