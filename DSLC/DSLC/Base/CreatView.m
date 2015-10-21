//
//  CreatView.m
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CreatView.h"

@implementation CreatView

+ (UIScrollView *)creatWithScrollViewFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor contentSize:(CGSize)contentSize contentOffSet:(CGPoint)contentOffSet
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    [scrollView setFrame:frame];
    [scrollView setBackgroundColor:backgroundColor];
    [scrollView setContentSize:contentSize];
    [scrollView setContentOffset:contentOffSet];
    
    return scrollView;
}

+ (UIButton *)creatWithButtonType:(UIButtonType *)buttonType frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor titleText:(NSString *)titleText
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:frame];
    [button setBackgroundColor:backgroundColor];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    
    return button;
}

+ (UILabel *)creatWithLabelFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment textFont:(UIFont *)textFont text:(NSString *)text
{
    UILabel *lable = [[UILabel alloc] init];
    
    [lable setFrame:frame];
    [lable setBackgroundColor:backgroundColor];
    [lable setTextColor:textColor];
    [lable setTextAlignment:textAlignment];
    [lable setFont:textFont];
    [lable setText:text];
    
    return lable;
}

+ (UIImageView *)creatImageViewWithFrame:(CGRect)frame backGroundColor:(UIColor *)backGroundColor setImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setFrame:frame];
    [imageView setBackgroundColor:backGroundColor];
    [imageView setImage:image];
    
    return imageView;
}

+ (UIView *)creatViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIView *view = [[UIView alloc] init];
    [view setFrame:frame];
    [view setBackgroundColor:backgroundColor];
    
    return view;
}

+ (UITextField *)creatWithfFrame:(CGRect)frame setPlaceholder:(NSString *)placeholder setTintColor:(UIColor *)tintColor
{
    UITextField *textField = [[UITextField alloc] init];
    [textField setFrame:frame];
    [textField setPlaceholder:placeholder];
    [textField setTintColor:tintColor];
    
    return textField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
