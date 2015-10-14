//
//  BankCard.m
//  DSLC
//
//  Created by 马成铭 on 15/10/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BankCard.h"
#import "define.h"

@implementation BankCard

- (void)setLine1:(UIView *)line1{
    CGPoint line1Point = line1.frame.origin;
    line1.frame = CGRectMake(line1Point.x, line1Point.y, WIDTH_CONTROLLER_DEFAULT * (355 / 375.0), 1);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
