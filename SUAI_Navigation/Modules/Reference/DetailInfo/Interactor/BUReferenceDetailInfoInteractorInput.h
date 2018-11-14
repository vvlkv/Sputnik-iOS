//
//  BUReferenceDetailInfoInteractorInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUReferenceDetailInfoInteractorInput <NSObject>

- (void)prepareEntityToShowDataAtIndex:(NSUInteger)index;
- (void)prepareDataToAboutInfo;

@end
