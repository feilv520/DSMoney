//
//  BindingPhoneViewController.m
//  DSLC
//
//  Created by ios on 15/10/22.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BindingPhoneViewController.h"
#import "PhoneViewController.h"
#import "MessageViewController.h"

@interface BindingPhoneViewController ()

@end

@implementation BindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"选择更换方式"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *butPhoneNum = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 10, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"通过“原手机号码+短信”的方式更换"];
    [self.view addSubview:butPhoneNum];
    butPhoneNum.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butPhoneNum.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    butPhoneNum.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [butPhoneNum addTarget:self action:@selector(buttonByPhone:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageViewRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 26, HEIGHT_CONTROLLER_DEFAULT * (17.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (16.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (16.0 / 375.0)) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"arrow"]];
    [butPhoneNum addSubview:imageViewRight];
    imageViewRight.userInteractionEnabled = YES;
    
    UIButton *butMessage = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (70.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"通过“验证账户信息”的方式更换"];
    [self.view addSubview:butMessage];
    butMessage.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butMessage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    butMessage.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [butMessage addTarget:self action:@selector(buttonUserMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 26, HEIGHT_CONTROLLER_DEFAULT * (17.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (16.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (16.0 / 375.0)) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"arrow"]];
    [butMessage addSubview:imageRight];
    imageRight.userInteractionEnabled = YES;
}

//通过手机号按钮
- (void)buttonByPhone:(UIButton *)button
{
    PhoneViewController *phoneVC = [[PhoneViewController alloc] init];
    [self.navigationController pushViewController:phoneVC animated:YES];
}

//验证账户信息按钮
- (void)buttonUserMessage:(UIButton *)button
{
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
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
