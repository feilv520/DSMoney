//
//  TWOMonkeyRecordCell.m
//  DSLC
//
//  Created by ios on 16/5/13.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMonkeyRecordCell.h"

@implementation TWOMonkeyRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end