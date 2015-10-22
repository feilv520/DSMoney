//
//  PayMoneyViewController.m
//  DSLC
//
//  Created by ios on 15/10/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "PayMoneyViewController.h"
#import "CreatView.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "ChooseStyleViewController.h"

@interface PayMoneyViewController () <UITextFieldDelegate>

{
    UIButton *butNext;
    UITextField *_textField;
}

@end

@implementation PayMoneyViewController

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

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"充值";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (100.0 / 667.0)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    viewBottom.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelLine1 = [CreatView creatWithLabelFrame:CGRectMake(10, HEIGHT_CONTROLLER_DEFAULT * (49.5 / 677.0), WIDTH_CONTROLLER_DEFAULT - 20, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewBottom addSubview:labelLine1];
    labelLine1.alpha = 0.2;
    
    UILabel *labelLine2 = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (99.5 / 667.5), WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewBottom addSubview:labelLine2];
    labelLine2.alpha = 0.2;
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (110.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (110.0 / 667.0)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    UILabel *labelLine3 = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewDown addSubview:labelLine3];
    labelLine3.alpha = 0.2;
    
    UILabel *labelLine4 = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (109.5 / 667.0), WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewDown addSubview:labelLine4];
    labelLine4.alpha = 0.2;
    
    butNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:butNext];
    butNext.frame = CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT * (270.0 / 667.0), WIDTH_CONTROLLER_DEFAULT - 80, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0));
    [butNext setTitle:@"下一步" forState:UIControlStateNormal];
    [butNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butNext addTarget:self action:@selector(buttonNext:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelOne = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"温馨提示"];
    [viewDown addSubview:labelOne];
    
    UILabel *labelTwo = [CreatView creatWithLabelFrame:CGRectMake(10, 50, WIDTH_CONTROLLER_DEFAULT - 10, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"1.充值成功后,即可体现在您的个人账户余额中。"];
    [viewDown addSubview:labelTwo];
    
    UILabel *labelThree = [CreatView creatWithLabelFrame:CGRectMake(10, 80, WIDTH_CONTROLLER_DEFAULT - 20, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"2.一次最高可以充值50万。"];
    [viewDown addSubview:labelThree];
    
    UILabel *labelBalance = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT * (90.0 / 375.0), 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"账户余额(元)"];
    [viewBottom addSubview:labelBalance];
    
    UILabel *labelYuE = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (110.0 / 375.0), 10, WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (120.0 / 375.0), 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"9.93"];
    [viewBottom addSubview:labelYuE];
    
    UILabel *labelCash = [CreatView creatWithLabelFrame:CGRectMake(10, HEIGHT_CONTROLLER_DEFAULT * (60.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (90.0 / 375.0), 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"充值金额(元)"];
    [viewBottom addSubview:labelCash];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (110.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (60.0 / 667.0), WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (120.0 / 375.0), 30) setPlaceholder:@"充值金额最小为1元" setTintColor:[UIColor grayColor]];
    [self.view addSubview:_textField];
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    _textField.delegate = self;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [_textField addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
    UIImageView *imageSafe = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (97.5 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (330.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (18.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (18.0 / 667.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"iocn_saft"]];
    [self.view addSubview:imageSafe];

    UILabel *moneySafe = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (117.5 / 375), HEIGHT_CONTROLLER_DEFAULT * (330.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (170 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (18.0/ 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:11] text:@"由中国银行保障您的账户资金安全"];
    [self.view addSubview:moneySafe];
}

- (void)textFieldEdit:(UITextField *)textField
{
    if ([textField.text length] > 0) {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (void)buttonNext:(UIButton *)button
{
    if ([_textField.text length] == 0) {
        
        
    } else {
        
        ChooseStyleViewController *chooseStyleVC = [[ChooseStyleViewController alloc] init];
        [self.navigationController pushViewController:chooseStyleVC animated:YES];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
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
