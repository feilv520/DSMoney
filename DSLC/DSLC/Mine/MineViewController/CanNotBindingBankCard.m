//
//  CanNotBindingBankCard.m
//  DSLC
//
//  Created by ios on 15/12/22.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CanNotBindingBankCard.h"
#import "AddBankViewController.h"

@interface CanNotBindingBankCard ()

@end

@implementation CanNotBindingBankCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageReturn.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"绑定银行卡"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *buttonAlert = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"绑定银行卡失败"];
    [self.view addSubview:buttonAlert];
    buttonAlert.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttonAlert setImage:[UIImage imageNamed:@"失败"] forState:UIControlStateNormal];
    
    UIButton *buttonNew = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 150, WIDTH_CONTROLLER_DEFAULT - 80 , 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"重新绑定银行卡"];
    [self.view addSubview:buttonNew];
    buttonNew.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNew setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonNew setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonNew addTarget:self action:@selector(buttonAginBindingBank:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAginBindingBank:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
