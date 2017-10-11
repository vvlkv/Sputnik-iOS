//
//  BUSegmentedControl.h
//  SUAI_Navigation
//
//  Created by Виктор on 15.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum BUSegmentType {
    BUSegmentTypeNormal,
    BUSegmentTypeWhite
}BUSegmentType;

@class BUCustomSegmentedControl;
@protocol BUCustomSegmentDelegate <NSObject>

@required
- (void)customSegment:(BUCustomSegmentedControl *)customSegment selectedScopeButtonIndexDidChange:(NSInteger)selectedScope;

@end

@interface BUCustomSegmentedControl : UISegmentedControl

@property (weak, nonatomic) id <BUCustomSegmentDelegate> delegate;

- (instancetype)initWithItems:(NSArray *)items andType:(BUSegmentType)type;

@end
