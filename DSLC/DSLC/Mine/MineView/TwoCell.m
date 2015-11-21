//
//  TwoCell.m
//  Content
//
//  Created by ios on 15/11/19.
//  Copyright © 2015年 ios. All rights reserved.
//

#import "TwoCell.h"
#import "define.h"

@implementation TwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.labelRight = [[UILabel alloc] init];
        self.labelRight.textColor = [UIColor whiteColor];
        self.labelRight.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.labelRight];
        
        self.imageContect = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageContect];
        
        self.imageRight = [[UIImageView alloc] init];
        self.imageRight.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.imageRight];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageRight.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 50, 10, 40, 40);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGRect rect = [self.labelRight.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 100, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.labelRight.numberOfLines = 0;
    
    CGFloat width = self.labelRight.text.length * 13;
    
    if (width < WIDTH_CONTROLLER_DEFAULT - 100) {
        
        self.labelRight.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - width - 50, 20, width, rect.size.height);
        self.imageContect.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - width - 60, 10, width + 10, rect.size.height +  20);
        
    } else {
        
        self.labelRight.frame = CGRectMake(25, 20, WIDTH_CONTROLLER_DEFAULT - 95, rect.size.height);
        self.imageContect.frame = CGRectMake(15, 10, WIDTH_CONTROLLER_DEFAULT - 65, rect.size.height +  20);
    }
    
    NSLog(@"%f", self.labelRight.frame.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
