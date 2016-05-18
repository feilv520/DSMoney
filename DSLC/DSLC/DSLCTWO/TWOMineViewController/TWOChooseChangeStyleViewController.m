//
//  TWOChooseChangeStyleViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOChooseChangeStyleViewController.h"
#import "TWOPhoneNumChangeViewController.h"
#import "TWOCodeChangePhoneNumViewController.h"

@interface TWOChooseChangeStyleViewController ()

@end

@implementation TWOChooseChangeStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"选择更换方式"];
    
    [self phoneNumChangeShow];
    [self loginSecretChangeShow];
}

//通过手机号码更换
- (void)phoneNumChangeShow
{
    UIButton *buttonOne = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 56) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] titleText:nil];
    [self.view addSubview:buttonOne];
    buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    buttonOne.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonOne.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0);
    [buttonOne addTarget:self action:@selector(changePhoneNum:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *phoneString = [[NSMutableAttributedString alloc] initWithString:@"通过“验证原手机号码”更换"];
    NSRange phoneRange = NSMakeRange(2, 9);
    [phoneString addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:phoneRange];
    NSRange leftRange = NSMakeRange(0, 2);
    [phoneString addAttribute:NSForegroundColorAttributeName value:[UIColor ZiTiColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[phoneString string] length] - 2, 2);
    [phoneString addAttribute:NSForegroundColorAttributeName value:[UIColor ZiTiColor] range:rightRange];
    [buttonOne setAttributedTitle:phoneString forState:UIControlStateNormal];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, buttonOne.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [buttonOne addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIButton *buttonUp = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(buttonOne.frame.size.width - 5 - 16, 20, 16, 16) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [buttonOne addSubview:buttonUp];
    [buttonUp setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [buttonUp setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateHighlighted];
    [buttonUp addTarget:self action:@selector(changePhoneNum:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginSecretChangeShow
{
    UIButton *buttonTwo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 56, WIDTH_CONTROLLER_DEFAULT, 56) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] titleText:nil];
    [self.view addSubview:buttonTwo];
    buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    buttonTwo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonTwo.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0);
    [buttonTwo addTarget:self action:@selector(changeLoginSecret:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *loginString = [[NSMutableAttributedString alloc] initWithString:@"通过“验证码登录密码”更换"];
    NSRange loginRange = NSMakeRange(2, 9);
    [loginString addAttribute:NSForegroundColorAttributeName value:[UIColor orangecolor] range:loginRange];
    NSRange leftRange = NSMakeRange(0, 2);
    [loginString addAttribute:NSForegroundColorAttributeName value:[UIColor ZiTiColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[loginString string] length] - 2, 2);
    [loginString addAttribute:NSForegroundColorAttributeName value:[UIColor ZiTiColor] range:rightRange];
    [buttonTwo setAttributedTitle:loginString forState:UIControlStateNormal];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, buttonTwo.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [buttonTwo addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIButton *buttonDown = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(buttonTwo.frame.size.width - 5 - 16, 20, 16, 16) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [buttonTwo addSubview:buttonDown];
    [buttonDown setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [buttonDown setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateHighlighted];
    [buttonDown addTarget:self action:@selector(changeLoginSecret:) forControlEvents:UIControlEventTouchUpInside];
}

//通过手机号码更换
- (void)changePhoneNum:(UIButton *)button
{
    TWOPhoneNumChangeViewController *changeNumVC = [[TWOPhoneNumChangeViewController alloc] init];
    [self.navigationController pushViewController:changeNumVC animated:YES];
}

//通过验证码更换
- (void)changeLoginSecret:(UIButton *)button
{
    TWOCodeChangePhoneNumViewController *changePhoneNum = [[TWOCodeChangePhoneNumViewController alloc] init];
    [self.navigationController pushViewController:changePhoneNum animated:YES];
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
