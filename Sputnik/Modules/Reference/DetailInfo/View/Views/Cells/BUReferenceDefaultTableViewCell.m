//
//  BUReferenceDefaultTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 19/11/2017.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUReferenceDefaultTableViewCell.h"
#import "BUReferenceViewModelDefaultItem.h"
#import "UIFont+SUAI.h"

@interface BUReferenceDefaultTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end

@implementation BUReferenceDefaultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 15.f : 17.f;
    [self.valueLabel setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
}

- (void)setModel:(id<BUReferenceViewModelItemProtocol>)model {
    [super setModel:model];
    BUReferenceViewModelDefaultItem *item = (BUReferenceViewModelDefaultItem *)model;
    self.valueLabel.text = [item value];
    [self.valueLabel setTextColor:[item color]];
    if (![item canSelect])
        return;
    switch ([item actionType]) {
        case ReferenceActionTypeCall:
            [_image setImage:[UIImage imageNamed:@"Phone icon"]];
            break;
        case ReferenceActionTypeEntity:
//            [_image setImage:[UIImage imageNamed:@"Usr icon"]];
            break;
        case ReferenceActionTypeAuditory:
            [_image setImage:[UIImage imageNamed:@"Position icon"]];
            break;
        case ReferenceActionTypeNone:
            [_image setImage:[UIImage imageNamed:@"Usr icon"]];
        case ReferenceActionTypeMail:
            
        default:
            break;
    }
}

@end
