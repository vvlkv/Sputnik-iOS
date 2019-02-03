//
//  BUReferenceCathedralHeaderTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 17/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceHeaderTableViewCell.h"
#import "BUReferenceViewModelHeaderItem.h"
#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"

@interface BUReferenceHeaderTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation BUReferenceHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 19.f : 21.f;
    [self.nameLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
}

- (void)setModel:(id<BUReferenceViewModelItemProtocol>)model {
    [super setModel:model];
    BUReferenceViewModelHeaderItem *header = (BUReferenceViewModelHeaderItem *)model;
    self.nameLabel.text = [header value];
    [self.nameLabel setTextColor:[header color]];
}
@end
