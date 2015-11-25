//
//  ProjectContentCell.m
//  DSLC
//
//  Created by ios on 15/11/25.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ProjectContentCell.h"
#import "UIColor+AddColor.h"
#import "define.h"

@implementation ProjectContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelContent = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelContent];
        self.labelContent.font = [UIFont systemFontOfSize:13];
        self.labelContent.textColor = [UIColor zitihui];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelContent.frame = CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 10);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGRect rect = [self.labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.labelContent.numberOfLines = 0;
    self.labelContent.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
