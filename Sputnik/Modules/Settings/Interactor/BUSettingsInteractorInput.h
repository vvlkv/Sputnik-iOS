//
//  BUSettingsInteractorInput.h
//  SUAI_Navigation
//
//  Created by Виктор on 31.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUSettingsInteractorInput <NSObject>

- (void)obtainCodes;
- (void)overwriteSettingsWithEntiyName:(NSString *)name andType:(NSUInteger)type;
- (void)overwriteSettingsWithStartIndex:(NSUInteger)index;

@end
