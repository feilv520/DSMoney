//
//  RechargeViewController.m
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RechargeViewController.h"
#import "BindingBankCardViewController.h"

@interface RechargeViewController ()

{
    UITextField *_textField;
    UIButton *butNext;
}

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"充值"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(10, 10, 60, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"金额充值"];
    [view addSubview:labelMoney];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(90, 11, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:@"充值金额最小为1元" setTintColor:[UIColor grayColor]];
    [view addSubview:_textField];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField addTarget:self action:@selector(textFieldBeginEdit:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *labelYuan = [CreatView creatWithLabelFrame:CGRectMake(_textField.frame.size.width - 25, 0, 15, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor yuanColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"元"];
    [_textField addSubview:labelYuan];
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [view addSubview:labelLine];
    labelLine.backgroundColor = [UIColor grayColor];
    labelLine.alpha = 0.3;
    
    butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 150, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:butNext];
    butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butNext addTarget:self action:@selector(buttonNextOne:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 200, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"由中国银行保障您的账户资金安全"];
    [self.view addSubview:buttonSafe];
    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
}

- (void)textFieldBeginEdit:(UITextField *)textField
{
    CGFloat money = textField.text.intValue;
    
    if (money >= 1) {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//下一步按钮
- (void)buttonNextOne:(UIButton *)button
{
    CGFloat money = _textField.text.intValue;
    
    if (money >= 1) {
        
        BindingBankCardViewController *bankCard = [[BindingBankCardViewController alloc] init];
        [self.navigationController pushViewController:bankCard animated:YES];
        
    } else {
        
        NSLog(@"规定输入金额不能小于1元");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
