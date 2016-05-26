//
//  TWOReceiveNumViewController.m
//  DSLC
//
//  Created by ios on 16/5/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOReceiveNumViewController.h"
#import "define.h"

@interface TWOReceiveNumViewController ()

{
    UIButton *butGouXuan;
}

@end

@implementation TWOReceiveNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self contentShow];
}

- (void)contentShow
{
    UIImageView *imageBigPic = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"bigpicture"]];
    [self.view addSubview:imageBigPic];
    imageBigPic.userInteractionEnabled = YES;
    
    //    左上角x按钮
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 30, 25, 25) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBigPic addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateHighlighted];
    [butCancle addTarget:self action:@selector(CancleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelPhone = [CreatView creatWithLabelFrame:CGRectMake(0, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"已向158****2456发送短信"];
    [imageBigPic addSubview:labelPhone];
    
    UIImageView *imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20, WIDTH_CONTROLLER_DEFAULT/2, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"zhongxing"]];
    [imageBigPic addSubview:imageTwo];
    imageTwo.userInteractionEnabled = YES;
    
    UIImageView *imagePhone = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    [imageTwo addSubview:imagePhone];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageTwo addSubview:viewLine];
    
//    输入验证码输入框
    UITextField *textFieldYan = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"短信验证码" setTintColor:[UIColor whiteColor]];
    [imageTwo addSubview:textFieldYan];
    textFieldYan.textColor = [UIColor whiteColor];
    textFieldYan.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    textFieldYan.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldYan setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldYan setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    UIImageView *imageGet = [CreatView creatImageViewWithFrame:CGRectMake(30 + WIDTH_CONTROLLER_DEFAULT/2 + 10, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20, WIDTH_CONTROLLER_DEFAULT - 60 - 10 - imageTwo.frame.size.width, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuangyan"]];
    [imageBigPic addSubview:imageGet];
    imageGet.userInteractionEnabled = YES;
    
    UIButton *buttonGet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 5, imageGet.frame.size.width - 20, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"获取验证码"];
    [imageGet addSubview:buttonGet];
    buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonGet addTarget:self action:@selector(buttonGetYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageThree = [CreatView creatImageViewWithFrame:CGRectMake(30, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageBigPic addSubview:imageThree];
    imageThree.userInteractionEnabled = YES;
    
    UIImageView *imageInvite = [CreatView creatImageViewWithFrame:CGRectMake(22, 10, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"yaoqingma"]];
    [imageThree addSubview:imageInvite];
    
    UIView *viewLine2 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageThree addSubview:viewLine2];
    
//    输入邀请码输入框
    UITextField *textFieldInvite = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"邀请码(选填)" setTintColor:[UIColor whiteColor]];
    [imageThree addSubview:textFieldInvite];
    textFieldInvite.textColor = [UIColor whiteColor];
    textFieldInvite.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [textFieldInvite setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldInvite setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
//    注册按钮
    UIButton *buttRegist = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40*2 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"注册"];
    [imageBigPic addSubview:buttRegist];
    buttRegist.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttRegist setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [buttRegist setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
    [buttRegist addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    勾选按钮
    butGouXuan = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 84 - 6, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40*3 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 8, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBigPic addSubview:butGouXuan];
    [butGouXuan setBackgroundImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateNormal];
    [butGouXuan setBackgroundImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateHighlighted];
    butGouXuan.tag = 000;
    [butGouXuan addTarget:self action:@selector(buttonGouXuanOrNo:) forControlEvents:UIControlEventTouchUpInside];
    
//    协议按钮
    UIButton *buttonAgree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 84 + 6, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40*3 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 3, 168, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"同意《大圣理财平台服务协议》"];
    [imageBigPic addSubview:buttonAgree];
    buttonAgree.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [buttonAgree addTarget:self action:@selector(buttonClickedAgree:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butRightNow = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40*3 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0/ 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"已有账号,立即登录"];
    [imageBigPic addSubview:butRightNow];
    butRightNow.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butRightNow addTarget:self action:@selector(buttonRightNowLogin:) forControlEvents:UIControlEventTouchUpInside];
}

//获取验证码按钮
- (void)buttonGetYanZhengMa:(UIButton *)button
{
    NSLog(@"code");
}

//勾选按钮
- (void)buttonGouXuanOrNo:(UIButton *)button
{
    if (button.tag == 000) {
        
        [button setBackgroundImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"weixuan"] forState:UIControlStateHighlighted];
        button.tag = 999;
        
    } else {
        
        [button setBackgroundImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateHighlighted];
        button.tag = 000;
    }
}

//协议按钮
- (void)buttonClickedAgree:(UIButton *)button
{
    NSLog(@"agree");
}

//注册按钮
- (void)registerButtonClicked:(UIButton *)button
{
    if (butGouXuan.tag == 999) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请勾选服务协议才能注册"];
    } else {
        NSLog(@"注册");
    }
}

//已有账号,立即登录方法
- (void)buttonRightNowLogin:(UIButton *)button
{
    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
}

//左上角x按钮
- (void)CancleClicked:(UIButton *)button
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
