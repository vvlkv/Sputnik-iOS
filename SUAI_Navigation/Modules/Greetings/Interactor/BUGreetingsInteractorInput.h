//
//  BUGreetingsInteractorInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUGreetingsInteractorInput <NSObject>

@required
- (void)overwriteEntity:(NSString *)entity andType:(NSUInteger)type;

@end
