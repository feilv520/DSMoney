//
//  TQuestionCell.m
//  DSLC
//
//  Created by ios on 16/3/29.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TQuestionCell.h"
#import "define.h"

@implementation TQuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.butChoose = [[UIImageView alloc] init];
        [self addSubview:self.butChoose];
        self.butChoose.image = [UIImage imageNamed:@"椭圆-3"];
        
        self.labelQuestion = [[UILabel alloc] init];
        [self addSubview:self.labelQuestion];
        self.labelQuestion.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        self.labelQuestion.textColor = [UIColor zitihui];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.butChoose.frame = CGRectMake(10, 7, 12, 12);
    self.labelQuestion.frame = CGRectMake(30, 5, WIDTH_CONTROLLER_DEFAULT - 40, 30);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:12], NSFontAttributeName, nil];
    CGRect rect = [self.labelQuestion.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 40, 900000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.labelQuestion.numberOfLines = 0;
    self.labelQuestion.frame = CGRectMake(30, 5, WIDTH_CONTROLLER_DEFAULT - 40, rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
