//
//  BUReferenceCathedralTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 17/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceCathedraTableViewCell.h"
#import "BURefrerenceViewModelCathedralItem.h"
#import "UIFont+SUAI.h"
#import "UIColor+SUAI.h"

@interface BUReferenceCathedraTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation BUReferenceCathedraTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 15.f : 17.f;
    [self.numberLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
    [self.nameLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
    self.numberLabel.textColor = [UIColor grayColor];
}

- (void)setModel:(id<BUReferenceViewModelItemProtocol>)model {
    [super setModel:model];
    BURefrerenceViewModelCathedralItem *cathedra = (BURefrerenceViewModelCathedralItem *)model;
    self.nameLabel.text = [cathedra value];
    self.numberLabel.text = [cathedra number];
}

@end
