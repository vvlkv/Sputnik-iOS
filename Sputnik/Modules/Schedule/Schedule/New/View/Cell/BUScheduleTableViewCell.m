//
//  BUScheduleTableViewCell.m
//  SUAI_Navigation
//
//  Created by Виктор on 16.07.17.
//  Copyright © 2017 Viktor. All rights reserved.
//

#import "BUScheduleTableViewCell.h"
#import "UIColor+SUAI.h"
#import "UIFont+SUAI.h"

@interface BUScheduleTableViewCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextView *pairText;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherDegreeLabel;
@property (weak, nonatomic) IBOutlet UIView *frameView;

@end

@implementation BUScheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.frameView.layer.borderWidth = 3.f;
    self.frameView.layer.borderColor = [[UIColor suaiGrayColor] CGColor];
    self.frameView.layer.cornerRadius = 8.f;
    [self.typeLabel setFont:[UIFont suaiRobotoFont:RobotoFontBold size:46.f]];
    [self.typeLabel setTextColor:[UIColor suaiPurpleColor]];
    [self.teacherLabel setFont:[UIFont suaiRobotoFont:RobotoFontLight size:16.f]];
    [self.teacherDegreeLabel setFont:[UIFont suaiRobotoFont:RobotoFontLight size:12.f]];
    self.teacherDegreeLabel.textColor = UIColor.darkGrayColor;
    [self.pairText addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setPairType:(NSString *)pairType {
    _pairType = pairType;
    self.typeLabel.text = _pairType;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.pairText.text = _name;
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width == 320.f ? 14.f : 15.f;
    [self.pairText setFont:[UIFont suaiRobotoFont:RobotoFontMedium size:fontSize]];
    self.pairText.textAlignment = NSTextAlignmentCenter;
    self.pairText.backgroundColor = [UIColor whiteColor];
}

- (void)setTeacherName:(NSString *)teacher {
    _teacherName = teacher;
    self.teacherLabel.text = _teacherName;
}

- (void)setTeacherDegree:(NSString *)teacherDegree {
    _teacherDegree = teacherDegree;
    if (_teacherDegree == nil) {
        self.teacherDegreeLabel.text = @"";
        self.teacherLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        self.teacherDegreeLabel.text = _teacherDegree;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    UIRectCorner corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(16.0, 16.0)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}


#pragma mark - Observer

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        UITextView *tv = object;
        CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
        CGFloat inset = MAX(0, deadSpace/2.0);
        tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
    }
}

- (void)dealloc {
    [self.pairText removeObserver:self forKeyPath:@"contentSize"];
}

@end

