//
//  RiskAlertBookCell.m
//  DSLC
//
//  Created by ios on 15/11/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RiskAlertBookCell.h"
#import "UIColor+AddColor.h"
#import "define.h"

@implementation RiskAlertBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelBook = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelBook];
        self.labelBook.textColor = [UIColor zitihui];
        self.labelBook.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelBook.frame = CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 50);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGRect rect = [self.labelBook.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 200000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.labelBook.numberOfLines = 0;
    self.labelBook.frame = CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
