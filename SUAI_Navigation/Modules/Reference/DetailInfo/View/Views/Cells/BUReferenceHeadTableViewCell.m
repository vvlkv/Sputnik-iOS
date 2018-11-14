//
//  BUReferenceHeadTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 17/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceHeadTableViewCell.h"
#import "BUReferenceViewModelBaseItem.h"
#import "BUFaculty.h"
#import "UIFont+SUAI.h"

@interface BUReferenceHeadTableViewCell () {
    
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation BUReferenceHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 19.f : 21.f;
    [self.nameLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
}

- (void)setModel:(id<BUReferenceViewModelItemProtocol>)model {
    [super setModel:model];
    self.nameLabel.text = [model value];
//    self.iconImageView.image = [UIImage imageNamed:@"i1.png"];
//    if ([model isKindOfClass:[BUFaculty class]]) {
//        BUFaculty *faculty = (BUFaculty *)model;
//        if (faculty.icon != nil) {
//            self.iconImageView.image = [UIImage imageNamed:[faculty icon]];
//        }
//    }
}

@end
