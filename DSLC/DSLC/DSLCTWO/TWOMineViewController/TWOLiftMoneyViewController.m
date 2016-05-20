//
//  TWOLiftMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/19.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOLiftMoneyViewController.h"

@interface TWOLiftMoneyViewController ()

@end

@implementation TWOLiftMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"提现"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 51) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 51, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UILabel *labelLift = [CreatView creatWithLabelFrame:CGRectMake(9, 10, 60, 31) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"提现金额"];
    [viewBottom addSubview:labelLift];
    
    UITextField *textFieldLift = [CreatView creatWithfFrame:CGRectMake(90, 10, WIDTH_CONTROLLER_DEFAULT - 90 - 10, 31) setPlaceholder:[NSString stringWithFormat:@"可提现%@元", @"100"] setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldLift];
    textFieldLift.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldLift.textColor = [UIColor findZiTiColor];
    textFieldLift.keyboardType = UIKeyboardTypeDecimalPad; //带小数点的数字键盘
    
    UIButton *buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 66, WIDTH_CONTROLLER_DEFAULT - 18, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonNext.layer.cornerRadius = 5;
    buttonNext.layer.masksToBounds = YES;
    
    [self alertContentShow];
}

- (void)alertContentShow
{
    UIView *viewAlert = [CreatView creatViewWithFrame:CGRectMake(9, 66 + 40 + 100, WIDTH_CONTROLLER_DEFAULT - 18, 160) backgroundColor:[UIColor shurukuangColor]];
    [self.view addSubview:viewAlert];
    viewAlert.layer.cornerRadius = 5;
    viewAlert.layer.masksToBounds = YES;
    
    CGFloat viewWidth = viewAlert.frame.size.width;

    UILabel *labelKindlyReminder  = [CreatView creatWithLabelFrame:CGRectMake(12, 0, viewWidth - 24, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"温馨提示"];
    [viewAlert addSubview:labelKindlyReminder];
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
