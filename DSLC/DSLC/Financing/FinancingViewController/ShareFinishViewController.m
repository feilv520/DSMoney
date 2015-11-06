//
//  ShareFinishViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ShareFinishViewController.h"

@interface ShareFinishViewController ()

{
    UIButton *butRedBag;
    UIButton *butRightNow;
    
    UILabel *labelMoney;
    UILabel *labelTime;
    UILabel *labelData;
    
    UIButton *buttonOpen;
}

@end

@implementation ShareFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"分享"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(button:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightNowButton:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *butShareDo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 52, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"分享成功"];
    [self.view addSubview:butShareDo];
    butShareDo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butShareDo setImage:[UIImage imageNamed:@"分享成功"] forState:UIControlStateNormal];
    
    UILabel *labelGet = [CreatView creatWithLabelFrame:CGRectMake(0, 80, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"获得一个新的红包"];
    [self.view addSubview:labelGet];
    
    butRedBag = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, 129, WIDTH_CONTROLLER_DEFAULT - 40, 110) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [self.view addSubview:butRedBag];
    [butRedBag setBackgroundImage:[UIImage imageNamed:@"组-21-拷贝-2"] forState:UIControlStateNormal];
    [butRedBag setBackgroundImage:[UIImage imageNamed:@"组-21-拷贝-2"] forState:UIControlStateHighlighted];
    
    labelMoney = [CreatView creatWithLabelFrame:CGRectMake(15, 16, 190, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"金元宝红包50~70元"];
    [butRedBag addSubview:labelMoney];
    
    labelTime = [CreatView creatWithLabelFrame:CGRectMake(15, 45, 190, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"有效期:截至2015.12.31"];
    [butRedBag addSubview:labelTime];
    
    labelData = [CreatView creatWithLabelFrame:CGRectMake(16, 77, 230, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:11] text:@"最低投资金额:2,000元  理财期限:9个月以上"];
    [butRedBag addSubview:labelData];
    
    butRightNow = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 299, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"立即投资"];
    [self.view addSubview:butRightNow];
    butRightNow.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butRightNow setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butRightNow setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [butRightNow addTarget:self action:@selector(rightNowButton:) forControlEvents:UIControlEventTouchUpInside];
}

////拆红包按钮
//- (void)openRedBagButton:(UIButton *)button
//{
//    buttonOpen = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
//    AppDelegate *app = [[UIApplication sharedApplication] delegate];
//    [app.tabBarVC.view addSubview:buttonOpen];
//    [buttonOpen setBackgroundImage:[UIImage imageNamed:@"打开红包"] forState:UIControlStateNormal];
//    [buttonOpen setBackgroundImage:[UIImage imageNamed:@"打开红包"] forState:UIControlStateHighlighted];
//    [buttonOpen addTarget:self action:@selector(buttonOpenFinish:) forControlEvents:UIControlEventTouchUpInside];
//}

////拆开红包完成
//- (void)buttonOpenFinish:(UIButton *)button
//{
//    [buttonOpen removeFromSuperview];
//    
//    buttonOpen = nil;
//}

//立即投资按钮
- (void)rightNowButton:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)button:(UIBarButtonItem *)bar
{
    
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
