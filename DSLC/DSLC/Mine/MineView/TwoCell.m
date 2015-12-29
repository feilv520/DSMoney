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
        self.labelRight.backgroundColor = [UIColor colorWithRed:154.0 / 225.0 green:154.0 / 225.0 blue:154.0 / 225.0 alpha:1.0];
        self.labelRight.layer.cornerRadius = 8;
        self.labelRight.layer.masksToBounds = YES;
        self.labelRight.layer.borderWidth = 0.5;
        self.labelRight.layer.borderColor = [[UIColor clearColor] CGColor];
        self.labelRight.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.labelRight];
        
//        self.labelTime = [[UILabel alloc] init];
//        [self addSubview:self.labelTime];
//        self.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:10];
//        self.labelTime.textColor = [UIColor zitihui];
//        self.labelTime.textAlignment = NSTextAlignmentCenter;
        
        self.imageContect = [[UIImageView alloc] init];
//        [self.contentView addSubview:self.imageContect];
        
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
    CGRect rect = [self.labelRight.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 70, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.labelRight.numberOfLines = 0;
    
    CGFloat width = self.labelRight.text.length * 13 + 20;
    
    if (width < WIDTH_CONTROLLER_DEFAULT - 70) {

        self.labelRight.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60 - width, 10, width, rect.size.height + 20);

    } else {

        self.labelRight.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 70, rect.size.height + 20);

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
