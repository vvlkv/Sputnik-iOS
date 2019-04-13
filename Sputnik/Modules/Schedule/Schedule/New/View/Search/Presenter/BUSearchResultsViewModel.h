//
//  BUSearchResultsViewModel.h
//  Sputnik
//
//  Created by Виктор on 02/04/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SUAIEntity;
@interface BUSearchResultsViewModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic, readonly) NSArray<SUAIEntity *> *entities;

- (instancetype)initWithName:(NSString *)name andEntities:(NSArray<SUAIEntity *> *)entities;

@end

NS_ASSUME_NONNULL_END
