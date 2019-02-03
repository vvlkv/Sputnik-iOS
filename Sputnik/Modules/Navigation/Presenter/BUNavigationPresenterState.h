//
//  BUNavigationPresenterState.h
//  SUAI_Navigation
//
//  Created by Виктор on 29.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUNavigationPresenterState : NSObject

@property (strong, nonatomic) NSMutableArray *auditories;
@property (strong, nonatomic) NSString *tryingAuditory;
@property (assign, nonatomic) NSUInteger findingAuditoryIndex;
@property (assign, nonatomic) BOOL isMapLoaded;
@property (strong, nonatomic) NSString *temporaryAuditory;

@end
