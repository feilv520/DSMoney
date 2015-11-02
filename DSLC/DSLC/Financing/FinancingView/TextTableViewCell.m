//
//  TextTableViewCell.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "TextTableViewCell.h"
#import "define.h"

@implementation TextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.introduction.text = text;
    self.introduction.numberOfLines = 0;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGRect labelSize = [self.introduction.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT , 999999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.introduction.frame = CGRectMake(self.introduction.frame.origin.x, self.introduction.frame.origin.y, labelSize.size.width, labelSize.size.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.size.height + 50;
    self.introduction.frame = frame;
    self.frame = frame;
}

@end
