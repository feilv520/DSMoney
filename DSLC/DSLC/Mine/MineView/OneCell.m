//
//  OneCell.m
//  Content
//
//  Created by ios on 15/11/19.
//  Copyright © 2015年 ios. All rights reserved.
//

#import "OneCell.h"
#import "define.h"

@implementation OneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelLeft = [[UILabel alloc] init];
        self.labelLeft.textColor = [UIColor grayColor];
        self.labelLeft.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.labelLeft];
        
        self.imageContect = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageContect];
        
        self.imageLeft = [[UIImageView alloc] init];
        self.imageLeft.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.imageLeft];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageLeft.frame = CGRectMake(10, 10, 40, 40);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGRect rect = [self.labelLeft.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 100, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.labelLeft.numberOfLines = 0;
    
    CGFloat width = self.labelLeft.text.length * 13;
    
    if (width < WIDTH_CONTROLLER_DEFAULT - 100) {
        
        self.labelLeft.frame = CGRectMake(70, 20, width, rect.size.height);
        self.imageContect.frame = CGRectMake(60, 10, width + 20, rect.size.height +  20);
        
    } else {
        
        self.labelLeft.frame = CGRectMake(80, 20, WIDTH_CONTROLLER_DEFAULT - 100, rect.size.height);
        self.imageContect.frame = CGRectMake(60, 10, WIDTH_CONTROLLER_DEFAULT - 70, rect.size.height +  20);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
