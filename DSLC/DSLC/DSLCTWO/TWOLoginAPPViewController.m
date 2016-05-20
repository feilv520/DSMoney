//
//  TWOLoginAPPViewController.m
//  DSLC
//
//  Created by ios on 16/5/19.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOLoginAPPViewController.h"
#import "define.h"
#import "AppDelegate.h"
#import "TWORegisterViewController.h"
#import "TWOForgetSecretViewController.h"

@interface TWOLoginAPPViewController ()

{
    UIImageView *imageViewBeiJing;
    UIButton *buttonLeft;
    UIButton *buttonRight;
}

@end

@implementation TWOLoginAPPViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loginContent];
}

- (void)loginContent
{
//    大背景
    imageViewBeiJing = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"bigpicture"]];
    [self.view addSubview:imageViewBeiJing];
    imageViewBeiJing.userInteractionEnabled = YES;
    
//    左上角x按钮
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 30, 25, 25) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageViewBeiJing addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateHighlighted];
    [butCancle addTarget:self action:@selector(buttonCancleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    密码登录&验证码登录切换框
    UIImageView *imageOne = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageViewBeiJing addSubview:imageOne];
    imageOne.userInteractionEnabled = YES;
    
//    密码登录按钮
    buttonLeft = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, imageOne.frame.size.width/2, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] titleText:@"密码登录"];
    [imageOne addSubview:buttonLeft];
    buttonLeft.tag = 800;
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateNormal];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateHighlighted];
    buttonLeft.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonLeft addTarget:self action:@selector(buttonLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    验证码登录按钮
    buttonRight = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(imageOne.frame.size.width/2, 0, imageOne.frame.size.width/2, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"验证码登录"];
    [imageOne addSubview:buttonRight];
    buttonRight.tag = 900;
    buttonRight.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonRight addTarget:self action:@selector(buttonRightClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    输入手机号框
    UIImageView *imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageViewBeiJing addSubview:imageTwo];
    imageTwo.userInteractionEnabled = YES;
    
//    手机图标
    UIImageView *imagePhone = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"phoneNumber"]];
    [imageTwo addSubview:imagePhone];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageTwo addSubview:viewLine];
    
//    输入手机号
    UITextField *textFieldPhone = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"手机号" setTintColor:[UIColor whiteColor]];
    [imageTwo addSubview:textFieldPhone];
    textFieldPhone.textColor = [UIColor whiteColor];
    textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldPhone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldPhone setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
//    输入密码码框
    UIImageView *imageThree = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageViewBeiJing addSubview:imageThree];
    imageThree.userInteractionEnabled = YES;
    
//    密码图标
    UIImageView *imageSecret = [CreatView creatImageViewWithFrame:CGRectMake(22, 10, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    [imageThree addSubview:imageSecret];
    
    UIView *viewLine2 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageThree addSubview:viewLine2];
    
//    输入密码
    UITextField *textFieldSecret = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"登录密码" setTintColor:[UIColor whiteColor]];
    [imageThree addSubview:textFieldSecret];
    textFieldSecret.textColor = [UIColor whiteColor];
    textFieldSecret.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [textFieldSecret setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldSecret setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
//    忘记密码?按钮
    UIButton *butForeget = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60 - 30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 9, 60, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"忘记密码?"];
    [imageViewBeiJing addSubview:butForeget];
    butForeget.titleLabel.font = [UIFont systemFontOfSize:12];
    [butForeget addTarget:self action:@selector(buttonClickedForget:) forControlEvents:UIControlEventTouchUpInside];
    
//    登录按钮
    UIButton *butLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:nil titleText:@"登录"];
    [imageViewBeiJing addSubview:butLogin];
    butLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
    
//    快速注册按钮
    UIButton *butFastRegist = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*4 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor fastZhuCeolor] titleText:@"快速注册"];
    [imageViewBeiJing addSubview:butFastRegist];
    butFastRegist.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butFastRegist addTarget:self action:@selector(buttonFastRegister:) forControlEvents:UIControlEventTouchUpInside];
}

//左上角x按钮
- (void)buttonCancleClicked:(UIButton *)button
{
    NSLog(@"x");
}

//密码登录按钮
- (void)buttonLeftClicked:(UIButton *)button
{
    [buttonRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateNormal];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateHighlighted];
    [buttonLeft setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
}

//验证码登录按钮
- (void)buttonRightClicked:(UIButton *)button
{
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [buttonLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateNormal];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateHighlighted];
    [buttonRight setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
}

//忘记密码?按钮
- (void)buttonClickedForget:(UIButton *)button
{
    TWOForgetSecretViewController *forgetVC = [[TWOForgetSecretViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

//快速注册
- (void)buttonFastRegister:(UIButton *)button
{
    TWORegisterViewController *registerVC = [[TWORegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
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
