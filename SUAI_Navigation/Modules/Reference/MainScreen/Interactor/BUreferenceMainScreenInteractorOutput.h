//
//  BUreferenceMainScreenInteractorOutput.h
//  SUAI_Navigation
//
//  Created by Виктор on 12/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUreferenceMainScreenInteractorOutput <NSObject>

@required
- (void)didLoadReference:(NSArray *)reference;

@end
