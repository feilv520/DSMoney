//
//  CreatView.h
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatView : UIView

+ (UIScrollView *)creatWithScrollViewFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor contentSize:(CGSize)contentSize contentOffSet:(CGPoint)contentOffSet;

+ (UIButton *)creatWithButtonType:(UIButtonType *)buttonType frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor titleText:(NSString *)titleText;

+ (UILabel *)creatWithLabelFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;

@end
