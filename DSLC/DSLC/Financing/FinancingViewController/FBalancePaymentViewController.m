//
//  FBalancePaymentViewController.m
//  DSLC
//
//  Created by ios on 15/10/14.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FBalancePaymentViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"

@interface FBalancePaymentViewController () <UITextFieldDelegate>

@end

@implementation FBalancePaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor huibai];
    
    self.navigationItem.title = @"余额支付";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self showContent];
    [self showNavigationBarItem];
}

//导航栏返回按钮
- (void)showNavigationBarItem
{
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBackLeftButton:)];
    [imageReturn addGestureRecognizer:tap];
}

- (void)showContent
{
    self.labelMonth1.text = @"   3个月固定资产";
    self.labelMonth1.font = [UIFont systemFontOfSize:15];
    
    self.labelLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine1.alpha = 0.7;
    
    NSMutableAttributedString *qianshuStr = [[NSMutableAttributedString alloc] initWithString:@"2,000 元"];
    NSRange yuanStr = NSMakeRange(0, [[qianshuStr string] rangeOfString:@"元"].location);
    [qianshuStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:yuanStr];
    [qianshuStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:26] range:yuanStr];
    NSRange oneStr = NSMakeRange([[qianshuStr string] length] - 1, 1);
    [qianshuStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:oneStr];
    [self.lableThounand setAttributedText:qianshuStr];
    self.lableThounand.textAlignment = NSTextAlignmentCenter;
    
    self.textFieldSecret.placeholder = @"请输入交易密码";
    self.textFieldSecret.secureTextEntry = YES;
    self.textFieldSecret.font = [UIFont systemFontOfSize:14];
    self.textFieldSecret.tintColor = [UIColor zitihui];
    self.textFieldSecret.delegate = self;
    [self.textFieldSecret addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.butPayment setImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    self.butPayment.titleLabel.font = [UIFont systemFontOfSize:15];
    self.butPayment.layer.cornerRadius = 4;
    self.butPayment.layer.masksToBounds = YES;
    
    self.labelPayment.text = @"支付";
    self.labelPayment.textColor = [UIColor whiteColor];
    self.labelPayment.textAlignment = NSTextAlignmentCenter;
    self.labelPayment.font = [UIFont systemFontOfSize:15];
    
    self.labelSecret.text = @"支付密码";
    self.labelSecret.font = [UIFont systemFontOfSize:15];
    
    [self.butForget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.butForget setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.butForget.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.butForget addTarget:self action:@selector(buttonForgetSecret:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lableLine2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.lableLine2.alpha = 0.7;
    
    self.labelLine3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine3.alpha = 0.7;
    
    self.labelLine4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine4.alpha = 0.7;
}

//忘记密码?按钮
- (void)buttonForgetSecret:(UIButton *)button
{
    NSLog(@"忘记密码?");
}

#pragma textFieldDalagate
#pragma --------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location >= 6){
        NSLog(@"超出范围");
        return  NO;
    } else {
        return YES;
    }
}

//最终的支付按钮
- (void)paymentMoney:(UIButton *)button
{
    NSLog(@"支付");
}

//返回按钮
- (void)returnBackLeftButton:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 判断字符串长度
- (void)textLengthChange:(UITextField *)textField{
    if (self.textFieldSecret.text.length >= 6) {
        self.butPayment.userInteractionEnabled = YES;
        [self.butPayment setImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    } else {
        self.butPayment.userInteractionEnabled = NO;
        [self.butPayment setImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
