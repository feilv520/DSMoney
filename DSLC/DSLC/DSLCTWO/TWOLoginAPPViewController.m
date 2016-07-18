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
#import "TWOForgetSecretERViewController.h"

@interface TWOLoginAPPViewController () <UIScrollViewDelegate, UITextFieldDelegate>

{
    UIImageView *imageViewBeiJing;
    UIButton *buttonLeft;
    UIButton *buttonRight;
    UIImageView *imageThree;
    UIButton *butForeget;
    UIImageView *imageMessage;
    UIImageView *imageGet;
    UIImageView *imageSuo;
    UIImageView *imagePhone;
    UIImageView *imageSecret;
    UIImageView *imageOne;
    UIImageView *imageTwo;
    UIView *viewLine;
    UIView *viewLine1;
    UIView *viewLine2;
    UIButton *buttonGet;
    UIButton *butCancle;
    UIButton *butLogin;
    UIButton *butFastRegist;
    UIScrollView *_scrollView;
    UITextField *textFieldPhone;
    UITextField *textFieldSecret;
    UITextField *textFieldMessage;
    UIScrollView *_scrollview;
    NSInteger seconds;
    NSTimer *timer;
    
    // 提交表单loading
    MBProgressHUD *hud;
    
    //签到猴子需要的控件
    UIButton *buttonHei;
    UIView *viewDown;
    UILabel *labelMonkey;
    UIImageView *imageSign;
}

@end

@implementation TWOLoginAPPViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loginContent];
    seconds = 60;
}


- (void)loginContent
{
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
        _scrollView.userInteractionEnabled = YES;
    }
    //    _scrollView.contentSize = CGSizeMake(0, self.view.frame.size.height + self.view.frame.size.height/2 - 50);
    [self.view addSubview:_scrollView];
    
    //    大背景
    if (imageViewBeiJing == nil) {
        
        imageViewBeiJing = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"bigpicture"]];
        imageViewBeiJing.userInteractionEnabled = YES;
    }
    [_scrollView addSubview:imageViewBeiJing];
    
    //    左上角x按钮
    if (butCancle == nil) {
        
        butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 30, 25, 25) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateNormal];
        [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateHighlighted];
        [butCancle addTarget:self action:@selector(buttonCancleClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageViewBeiJing addSubview:butCancle];
    
    //    密码登录&验证码登录切换框
    if (imageOne == nil) {
        
        imageOne = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
        imageOne.userInteractionEnabled = YES;
    }
    [imageViewBeiJing addSubview:imageOne];
    
    //    密码登录按钮
    if (buttonLeft == nil) {
        
        buttonLeft = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, imageOne.frame.size.width/2, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] titleText:@"密码登录"];
        buttonLeft.tag = 800;
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateNormal];
        [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateHighlighted];
        buttonLeft.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [buttonLeft addTarget:self action:@selector(buttonLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageOne addSubview:buttonLeft];
    
    //    验证码登录按钮
    if (buttonRight == nil) {
        
        buttonRight = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(imageOne.frame.size.width/2, 0, imageOne.frame.size.width/2, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"验证码登录"];
        buttonRight.tag = 900;
        buttonRight.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [buttonRight addTarget:self action:@selector(buttonRightClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageOne addSubview:buttonRight];
    
    //    输入手机号框
    if (imageTwo == nil) {
        
        imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
        imageTwo.userInteractionEnabled = YES;
    }
    [imageViewBeiJing addSubview:imageTwo];
    
    //    手机图标
    if (imagePhone == nil) {
        
        imagePhone = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"phoneNumber"]];
    }
    [imageTwo addSubview:imagePhone];
    
    if (viewLine == nil) {
        
        viewLine = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    }
    [imageTwo addSubview:viewLine];
    
    //    输入手机号
    if (textFieldPhone == nil) {
        
        textFieldPhone = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"手机号" setTintColor:[UIColor whiteColor]];
        textFieldPhone.text = @"";
        textFieldPhone.tag = 1000;
        textFieldPhone.clearButtonMode = UITextFieldViewModeAlways;
        textFieldPhone.textColor = [UIColor whiteColor];
        textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
        textFieldPhone.delegate = self;
        [textFieldPhone setValue:[UIColor colorFromHexCode:@"9db2c7"] forKeyPath:@"_placeholderLabel.textColor"];
    }
    [imageTwo addSubview:textFieldPhone];
    
    //    输入密码框
    if (imageThree == nil) {
        
        imageThree = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
        imageThree.userInteractionEnabled = YES;
    }
    [imageViewBeiJing addSubview:imageThree];
    
    //    密码图标
    if (imageSecret == nil) {
        
        imageSecret = [CreatView creatImageViewWithFrame:CGRectMake(22, 10, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    }
    [imageThree addSubview:imageSecret];
    
    if (viewLine2 == nil) {
        
        viewLine2 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    }
    [imageThree addSubview:viewLine2];
    
    //    输入密码
    if (textFieldSecret == nil) {
        
        textFieldSecret = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageThree.frame.size.width - 64 - 10, 20) setPlaceholder:@"登录密码" setTintColor:[UIColor whiteColor]];
        textFieldSecret.text = @"";
        textFieldSecret.tag = 1001;
        textFieldSecret.clearButtonMode = UITextFieldViewModeAlways;
        textFieldSecret.secureTextEntry = YES;
        textFieldSecret.textColor = [UIColor whiteColor];
        textFieldSecret.delegate = self;
        [textFieldSecret setValue:[UIColor colorFromHexCode:@"9db2c7"] forKeyPath:@"_placeholderLabel.textColor"];
    }
    [imageThree addSubview:textFieldSecret];
    
    //    忘记密码?按钮
    if (butForeget == nil) {
        
        butForeget = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60 - 30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 9, 60, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"忘记密码?"];
        butForeget.titleLabel.font = [UIFont systemFontOfSize:12];
        [butForeget addTarget:self action:@selector(buttonClickedForget:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageViewBeiJing addSubview:butForeget];
    
    //    登录按钮
    if (butLogin == nil) {
        
        butLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:nil titleText:@"登录"];
        butLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
        [butLogin addTarget:self action:@selector(loginAppButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageViewBeiJing addSubview:butLogin];
    
    //    快速注册按钮
    if (butFastRegist == nil) {
        
        butFastRegist = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*4 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 60, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor fastZhuCeolor] titleText:@"快速注册"];
        [butFastRegist addTarget:self action:@selector(buttonFastRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageViewBeiJing addSubview:butFastRegist];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        textFieldSecret.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        buttonLeft.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        buttonRight.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        butLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        butFastRegist.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    } else {
        textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        textFieldSecret.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        buttonLeft.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        buttonRight.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        butLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        butFastRegist.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    }
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        imageOne.frame = CGRectMake(30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40);
        imageTwo.frame = CGRectMake(30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40, WIDTH_CONTROLLER_DEFAULT - 60, 40);
        imageThree.frame = CGRectMake(30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT - 60, 40);
        butForeget.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60 - 30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 9, 60, 20);
        butLogin.frame = CGRectMake(30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40);
        butFastRegist.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*4 + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 60, 20);
    }
}

//密码登录
- (void)secretLoginShow
{
    [self scrollviewContentOffSet];
    
    textFieldPhone.text = @"";
    
    [imageMessage removeFromSuperview];
    [imageGet removeFromSuperview];
    imageMessage = nil;
    imageGet = nil;
    
    //    输入密码框
    if (imageThree == nil) {
        
        imageThree = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
        imageThree.userInteractionEnabled = YES;
    }
    [imageViewBeiJing addSubview:imageThree];
    
    //    密码图标
    if (imageSecret == nil) {
        
        imageSecret = [CreatView creatImageViewWithFrame:CGRectMake(22, 10, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    }
    [imageThree addSubview:imageSecret];
    
    if (viewLine2 == nil) {
        
        viewLine2 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    }
    [imageThree addSubview:viewLine2];
    
    //    输入密码
    if (textFieldSecret == nil) {
        
        textFieldSecret = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageThree.frame.size.width - 64 - 10, 20) setPlaceholder:@"登录密码" setTintColor:[UIColor whiteColor]];
        textFieldSecret.text = @"";
        textFieldSecret.clearButtonMode = UITextFieldViewModeAlways;
        textFieldSecret.textColor = [UIColor whiteColor];
        textFieldSecret.delegate = self;
        textFieldSecret.tag = 1001;
        textFieldSecret.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [textFieldSecret setValue:[UIColor colorFromHexCode:@"9db2c7"] forKeyPath:@"_placeholderLabel.textColor"];
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            textFieldSecret.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        }
    }
    [imageThree addSubview:textFieldSecret];
    
    //    忘记密码?按钮
    if (butForeget == nil) {
        
        butForeget = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60 - 30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 9, 60, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"忘记密码?"];
        butForeget.titleLabel.font = [UIFont systemFontOfSize:12];
        [butForeget addTarget:self action:@selector(buttonClickedForget:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageViewBeiJing addSubview:butForeget];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        imageThree.frame = CGRectMake(30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT - 60, 40);
        butForeget.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60 - 30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*3 + 9, 60, 20);
    }
}

//验证码登录
- (void)messageLoginShow
{
    [self scrollviewContentOffSet];
    
    textFieldPhone.text = @"";
    
    [imageThree removeFromSuperview];
    [butForeget removeFromSuperview];
    imageThree = nil;
    butForeget = nil;
    
    //    短信验证码框
    if (imageMessage == nil) {
        
        imageMessage = [CreatView creatImageViewWithFrame:CGRectMake(30, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT/2, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"zhongxing"]];
        imageMessage.userInteractionEnabled = YES;
    }
    [imageViewBeiJing addSubview:imageMessage];
    
    if (imageSuo == nil) {
        
        imageSuo = [CreatView creatImageViewWithFrame:CGRectMake(22, 10, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    }
    [imageMessage addSubview:imageSuo];
    
    if (viewLine1 == nil) {
        
        viewLine1 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    }
    [imageMessage addSubview:viewLine1];
    
    //    短信验证码输入框
    if (textFieldMessage == nil) {
        
        textFieldMessage = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageMessage.frame.size.width - 64 - 10, 20) setPlaceholder:@"短信验证码" setTintColor:[UIColor whiteColor]];
        textFieldMessage.text = @"";
        textFieldMessage.clearButtonMode = UITextFieldViewModeWhileEditing;
        textFieldMessage.textColor = [UIColor whiteColor];
        textFieldMessage.keyboardType = UIKeyboardTypeNumberPad;
        textFieldMessage.delegate = self;
        [textFieldMessage setValue:[UIColor colorFromHexCode:@"9db2c7"] forKeyPath:@"_placeholderLabel.textColor"];
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            textFieldMessage.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        } else {
            textFieldMessage.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        }
    }
    [imageMessage addSubview:textFieldMessage];
    
    //    获取验证码框
    if (imageGet == nil) {
        
        imageGet = [CreatView creatImageViewWithFrame:CGRectMake(30 + WIDTH_CONTROLLER_DEFAULT/2 + 10, 228.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT - 60 - 10 - imageMessage.frame.size.width, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuangyan"]];
        imageGet.userInteractionEnabled = YES;
    }
    [imageViewBeiJing addSubview:imageGet];
    
    if (buttonGet == nil) {
        
        buttonGet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 5, imageGet.frame.size.width - 20, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"获取验证码"];
        buttonGet.tag = 552;
        buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [buttonGet addTarget:self action:@selector(getMessageYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        }
    }
    [imageGet addSubview:buttonGet];
    
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        imageMessage.frame = CGRectMake(30, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT/2, 40);
        imageGet.frame = CGRectMake(30 + WIDTH_CONTROLLER_DEFAULT/2 + 10, 208.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)*2 + 40*2, WIDTH_CONTROLLER_DEFAULT - 60 - 10 - imageMessage.frame.size.width, 40);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 667) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset = CGPointMake(0, self.view.frame.size.height/4.0 + 20);
        } completion:^(BOOL finished) {
            
        }];
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset = CGPointMake(0, self.view.frame.size.height/4.0 + 25);
        } completion:^(BOOL finished) {
            
        }];
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset = CGPointMake(0, self.view.frame.size.height/4.0 + 50);
        } completion:^(BOOL finished) {
            
        }];
    }
}

//左上角x按钮
- (void)buttonCancleClicked:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//密码登录按钮
- (void)buttonLeftClicked:(UIButton *)button
{
    [self secretLoginShow];
    
    [buttonRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [buttonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateNormal];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateHighlighted];
    [buttonLeft setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
}

//验证码登录按钮
- (void)buttonRightClicked:(UIButton *)button
{
    [self messageLoginShow];
    
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [buttonLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateNormal];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"whitelogin"] forState:UIControlStateHighlighted];
    [buttonRight setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
}

//获取短信验证码
- (void)getMessageYanZhengMa:(UIButton *)button
{
    if (textFieldPhone.text.length == 0) {
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
    } else if (![NSString validateMobile:textFieldPhone.text]) {
        [ProgressHUD showMessage:@"手机号格式不正确" Width:100 High:20];
    } else {
        [self sendToMessage];
    }
}

//登录按钮
- (void)loginAppButton:(UIButton *)button
{
    [self scrollviewContentOffSet];
    
    if (textFieldPhone.text.length == 0) {
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
    } else if (![NSString validateMobile:textFieldPhone.text]) {
        [ProgressHUD showMessage:@"手机号格式不正确" Width:100 High:20];
    } else {
        
        if (imageGet == nil) {
            if (textFieldSecret.text.length == 0) {
                [ProgressHUD showMessage:@"请输入密码" Width:100 High:20];
                return;
            }
            [self loginFuction];
        } else {
            [self registerFuction];
        }
    }
}

//忘记密码?按钮
- (void)buttonClickedForget:(UIButton *)button
{
    [self scrollviewContentOffSet];
    TWOForgetSecretERViewController *forgetSVC = [[TWOForgetSecretERViewController alloc] init];
    [self.navigationController pushViewController:forgetSVC animated:YES];
}

//快速注册
- (void)buttonFastRegister:(UIButton *)button
{
    [self scrollviewContentOffSet];
    TWORegisterViewController *registerVC = [[TWORegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:552];
    
    NSString *title = [NSString stringWithFormat:@"%lds",(long)seconds];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [button setTitle:@"获取验证码" forState: UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setEnabled:YES];
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        }
        
    }else{
        seconds--;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setEnabled:NO];
    }
}

- (void)releaseTImer {
    if (timer) {
        if ([timer respondsToSelector:@selector(isValid)]) {
            if ([timer isValid]) {
                [timer invalidate];
                seconds = 60;
            }
        }
    }
}

//封装偏移量归0
- (void)scrollviewContentOffSet
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollView.contentOffset = CGPointMake(0, -20);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self scrollviewContentOffSet];
}

#pragma mark 验证限制
#pragma mark --------------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1000) {
        
        if (range.location < 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else if (textField.tag == 1001){
        
        if (range.location < 20) {
            
            return YES;
            
        } else {
            
            return NO;
        }
    } else {
        
        if (range.location < 6) {
            
            return YES;
            
        } else {
            
            return NO;
        }
    }
}


#pragma mark 对接登录接口
#pragma mark --------------------------------

- (void)loginFuction{
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text,@"password":textFieldSecret.text};
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"login" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"register = %@",responseObject);
        
        [hud hide:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@200]) {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            
            if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                [FileOfManage createWithFile:@"Member.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [DES3Util encrypt:textFieldSecret.text],@"password",
                                     textFieldPhone.text,@"phone",
                                     [responseObject objectForKey:@"key"],@"key",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                     [responseObject objectForKey:@"token"],@"token",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",
                                     [responseObject objectForKey:@""],nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [DES3Util encrypt:textFieldSecret.text],@"password",
                                     textFieldPhone.text,@"phone",
                                     [responseObject objectForKey:@"key"],@"key",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                     [responseObject objectForKey:@"token"],@"token",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                NSLog(@"%@",[responseObject objectForKey:@"token"]);
            }
            
            [self getMyAccountInfoFuction];
            
            // 判断是否存在isLogin.plist文件
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                [self userSign];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"safeJiBie" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"safeTest" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadWithWebview" object:[responseObject objectForKey:@"token"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"yaoLogin" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getProductDetail" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getSelectionVC" object:nil];
            }];
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 验证码登录接口
#pragma mark --------------------------------

- (void)registerFuction{
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text,@"smsCode":textFieldMessage.text,@"invitationCode":@"",@"clientType":@"iOS"};
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"reg/register" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"register = %@",responseObject);
        
        [hud hide:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@200]) {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            
            if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                [FileOfManage createWithFile:@"Member.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     textFieldPhone.text,@"phone",
                                     [responseObject objectForKey:@"key"],@"key",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                     [responseObject objectForKey:@"token"],@"token",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     textFieldPhone.text,@"phone",
                                     [responseObject objectForKey:@"key"],@"key",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                     [responseObject objectForKey:@"token"],@"token",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                NSLog(@"%@",[responseObject objectForKey:@"token"]);
            }
            
            // 判断是否存在isLogin.plist文件
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            
            [self getMyAccountInfoFuction];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self userSign];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"safeJiBie" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"safeTest" object:nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadWithWebview" object:[responseObject objectForKey:@"token"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"yaoLogin" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getProductDetail" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getSelectionVC" object:nil];
            }];
        } else {
            [hud hide:YES];
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        NSLog(@"%@", error);
        
    }];
}

- (void)sendToMessage{
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text,@"msgType":@"1"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/getSmsCode" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getSmsCode = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]){
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)getMyAccountInfoFuction{
    
    NSMutableDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":[memberDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getMyAccountInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [memberDic setObject:[responseObject objectForKey:@"invitationMyCode"] forKey:@"invitationMyCode"];
            
            [memberDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)userSign{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    NSMutableDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":[memberDic objectForKey:@"token"],@"signDate":dateString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sign/userSign" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"userSign = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            if (![[responseObject objectForKey:@"signMonkeyNum"] isEqualToString:@"0"]){
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showMonkey" object:[responseObject objectForKey:@"signMonkeyNum"]];
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
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
