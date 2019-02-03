//
//  BUReferenceLinkTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 21/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceLinkTableViewCell.h"
#import "BUReferenceViewModelLinkItem.h"
#import "UIFont+SUAI.h"

@interface BUReferenceLinkTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
@implementation BUReferenceLinkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 15.f : 17.f;
    [self.nameLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
    [self.nameLabel setTextColor:[UIColor grayColor]];
    [self.valueLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
}

- (void)setModel:(id<BUReferenceViewModelItemProtocol>)model {
    [super setModel:model];
    BUReferenceViewModelLinkItem *link = (BUReferenceViewModelLinkItem *)model;
    
    self.nameLabel.text = [link nameDescription];
    self.valueLabel.text = [link value];
}

@end
