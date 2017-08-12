//
//  BUGreetingsInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 06.08.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUGreetingsInteractorOutput <NSObject>

@required
- (void)didObtainCodes:(NSDictionary *)codes;
- (void)didFailConnection;

@end
