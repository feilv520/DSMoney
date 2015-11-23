//
//  InviteNumReginCell.m
//  DSLC
//
//  Created by ios on 15/11/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "InviteNumReginCell.h"
#import "UIColor+AddColor.h"
#import "define.h"

@implementation InviteNumReginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelAsk = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelAsk];
        self.labelAsk.font = [UIFont systemFontOfSize:13];
        self.labelAsk.textColor = [UIColor zitihui];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelAsk.frame = CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 10);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:13], NSFontAttributeName, nil];
    CGRect rect = [self.labelAsk.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 300000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.labelAsk.numberOfLines = 0;
    self.labelAsk.frame = CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
