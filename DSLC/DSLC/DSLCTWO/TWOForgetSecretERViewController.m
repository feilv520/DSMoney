//
//  TWOForgetSecretERViewController.m
//  DSLC
//
//  Created by ios on 16/5/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOForgetSecretERViewController.h"
#import "AppDelegate.h"
#import "define.h"

@interface TWOForgetSecretERViewController ()

@end

@implementation TWOForgetSecretERViewController

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
    [self contentShow];
}

- (void)contentShow
{
    //    大背景
    UIImageView *imageBigPic = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"beijing"]];
    [self.view addSubview:imageBigPic];
    imageBigPic.userInteractionEnabled = YES;
    
    //    左上角返回按钮
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 30, 20, 20) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBigPic addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateHighlighted];
    [butCancle addTarget:self action:@selector(buttonForgetCancleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 54, 30, 108, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"找回登录密码"];
    [self.view addSubview:labelTitle];

    UIImageView *imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, self.view.frame.size.height/2 - 100, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageBigPic addSubview:imageTwo];
    imageTwo.userInteractionEnabled = YES;
    
//    手机图标
    UIImageView *imagePhone = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"phoneNumber"]];
    [imageTwo addSubview:imagePhone];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageTwo addSubview:viewLine];
    
//    输入手机号
    UITextField *textFieldPhone = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"请输入绑定手机号" setTintColor:[UIColor whiteColor]];
    [imageTwo addSubview:textFieldPhone];
    textFieldPhone.textColor = [UIColor whiteColor];
    textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldPhone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldPhone setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];

//    短信验证码框
    UIImageView *imageMessage = [CreatView creatImageViewWithFrame:CGRectMake(30, self.view.frame.size.height/2 - 100 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"zhongxing"]];
    [imageBigPic addSubview:imageMessage];
    imageMessage.userInteractionEnabled = YES;
    
    UIImageView *imageSuo = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    [imageMessage addSubview:imageSuo];
    
    UIView *viewLine1 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageMessage addSubview:viewLine1];
    
//    短信验证码输入框
    UITextField *textFieldMessage = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageMessage.frame.size.width - 64 - 10, 20) setPlaceholder:@"短信验证码" setTintColor:[UIColor whiteColor]];
    [imageMessage addSubview:textFieldMessage];
    textFieldMessage.textColor = [UIColor whiteColor];
    textFieldMessage.keyboardType = UIKeyboardTypeNumberPad;
    textFieldMessage.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [textFieldMessage setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldMessage setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
//    获取验证码框
    UIImageView *imageGet = [CreatView creatImageViewWithFrame:CGRectMake(30 + WIDTH_CONTROLLER_DEFAULT/2 + 10, self.view.frame.size.height/2 - 100 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60 - 10 - imageMessage.frame.size.width, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuangyan"]];
    [imageBigPic addSubview:imageGet];
    imageGet.userInteractionEnabled = YES;
    
    UIButton *buttonGet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 5, imageGet.frame.size.width - 20, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"获取验证码"];
    [imageGet addSubview:buttonGet];
    buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonGet addTarget:self action:@selector(buttonGetMessageYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    
//    下一步按钮
    UIButton *butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, self.view.frame.size.height/2 - 100 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40 + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:nil titleText:@"下一步"];
    [imageBigPic addSubview:butNext];
    butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butNext setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
    [butNext addTarget:self action:@selector(clickedNextOneStep:) forControlEvents:UIControlEventTouchUpInside];
}

//获取短信验证码
- (void)buttonGetMessageYanZhengMa:(UIButton *)button
{
    NSLog(@"message");
}

//下一步按钮
- (void)clickedNextOneStep:(UIButton *)button
{
    [self.view endEditing:YES];
    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"找回密码成功"];
    
    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
}

//左上角x按钮
- (void)buttonForgetCancleClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
