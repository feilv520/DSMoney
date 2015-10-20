//
//  VerifyViewController.m
//  DSLC
//
//  Created by ios on 15/10/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "VerifyViewController.h"
#import "CreatView.h"
#import "define.h"
#import "UIColor+AddColor.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self naviagationShow];
    [self contentShow];
}

- (void)contentShow
{
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"我们向您绑定的手机号15908987482发送了验证码"];
    [self.view addSubview:label];
    
    UILabel *labelLine1 = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (49.5 / 667.0), WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    labelLine1.alpha = 0.2;
    [label addSubview:labelLine1];
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (60.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (51.0 / 667.0)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    UILabel *labelLine2 = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewDown addSubview:labelLine2];
    labelLine2.alpha = 0.2;
    
    UILabel *labelLine3 = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (50.5 / 667.0), WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewDown addSubview:labelLine3];
    labelLine3.alpha = 0.2;
    
    UILabel *verify = [CreatView creatWithLabelFrame:CGRectMake(14, 0, WIDTH_CONTROLLER_DEFAULT * (50.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (51.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"验证码"];
    [viewDown addSubview:verify];
    
    UIButton *button = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (74.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (60.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (31.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"重新发送\n(20s)"];
    [viewDown addSubview:button];
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (75.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (210.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (31.0 / 667.0))];
    [viewDown addSubview:textFiled];
    textFiled.backgroundColor = [UIColor whiteColor];
    textFiled.placeholder = @"请输入验证码";
    textFiled.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    textFiled.tintColor = [UIColor zitihui];
    
    UIButton *butMakeSure = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:butMakeSure];
    butMakeSure.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (50.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (161.0 / 667.0), WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (100.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0));
    [butMakeSure setTitle:@"确定" forState:UIControlStateNormal];
    [butMakeSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butMakeSure addTarget:self action:@selector(buttonMakeSure:) forControlEvents:UIControlEventTouchUpInside];
    
}

//确定按钮
- (void)buttonMakeSure:(UIButton *)button
{
    NSLog(@"确定");
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"验证银行卡";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
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
