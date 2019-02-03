//
//  BUReferenceDetailInfoInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUReferenceDetailInfoInteractorOutput <NSObject>

- (void)didObtainDataViewModel:(NSArray *)dataViewModels;
- (void)didPrepareDataToShow:(id)model;

@end
