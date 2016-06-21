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
#import "TWOForgetSecretViewController.h"

@interface TWOForgetSecretERViewController () <UITextFieldDelegate>

{
    UITextField *textFieldPhone;
    UITextField *textFieldMessage;
    NSInteger seconds;
    NSTimer *timer;
}

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
    
    seconds = 60;
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
    [butCancle setBackgroundImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateHighlighted];
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
    textFieldPhone = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"请输入绑定手机号" setTintColor:[UIColor whiteColor]];
    [imageTwo addSubview:textFieldPhone];
    textFieldPhone.delegate = self;
    textFieldPhone.textColor = [UIColor whiteColor];
    textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldPhone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

//    短信验证码框
    UIImageView *imageMessage = [CreatView creatImageViewWithFrame:CGRectMake(30, self.view.frame.size.height/2 - 100 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"zhongxing"]];
    [imageBigPic addSubview:imageMessage];
    imageMessage.userInteractionEnabled = YES;
    
    UIImageView *imageSuo = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    [imageMessage addSubview:imageSuo];
    
    UIView *viewLine1 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageMessage addSubview:viewLine1];
    
//    短信验证码输入框
    textFieldMessage = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageMessage.frame.size.width - 64 - 10, 20) setPlaceholder:@"短信验证码" setTintColor:[UIColor whiteColor]];
    [imageMessage addSubview:textFieldMessage];
    textFieldMessage.delegate = self;
    textFieldMessage.textColor = [UIColor whiteColor];
    textFieldMessage.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldMessage setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
//    获取验证码框
    UIImageView *imageGet = [CreatView creatImageViewWithFrame:CGRectMake(30 + WIDTH_CONTROLLER_DEFAULT/2 + 10, self.view.frame.size.height/2 - 100 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60 - 10 - imageMessage.frame.size.width, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuangyan"]];
    [imageBigPic addSubview:imageGet];
    imageGet.userInteractionEnabled = YES;
    
    UIButton *buttonGet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 5, imageGet.frame.size.width - 20, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"获取验证码"];
    [imageGet addSubview:buttonGet];
    buttonGet.tag = 121;
    [buttonGet addTarget:self action:@selector(buttonGetMessageYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    
//    下一步按钮
    UIButton *butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, self.view.frame.size.height/2 - 100 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40 + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:nil titleText:@"下一步"];
    [imageBigPic addSubview:butNext];
    [butNext setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
    [butNext addTarget:self action:@selector(clickedNextOneStep:) forControlEvents:UIControlEventTouchUpInside];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        textFieldMessage.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    } else {
        textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        textFieldMessage.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == textFieldPhone) {
        if (range.location > 10) {
            return NO;
        } else {
            return YES;
        }
    } else {
        if (range.location > 5) {
            return NO;
        } else {
            return YES;
        }
    }
}

//获取短信验证码
- (void)buttonGetMessageYanZhengMa:(UIButton *)button
{
    NSLog(@"message");
    if (textFieldPhone.text.length == 0) {
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
    } else if (![NSString validateMobile:textFieldPhone.text]) {
        [ProgressHUD showMessage:@"手机号格式有误" Width:100 High:20];
    } else {
        [self getMessageCode];
    }
}

//下一步按钮
- (void)clickedNextOneStep:(UIButton *)button
{
    if (textFieldPhone.text.length == 0) {
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
    } else if (![NSString validateMobile:textFieldPhone.text]) {
        [ProgressHUD showMessage:@"手机号格式有误" Width:100 High:20];
    } else if (textFieldMessage.text.length == 0) {
        [ProgressHUD showMessage:@"请输入短信验证码" Width:100 High:20];
    } else if (textFieldMessage.text.length != 6) {
        [ProgressHUD showMessage:@"短信验证码格式有误" Width:100 High:20];
    } else {
        [self.view endEditing:YES];
        [self messageCodeData];
    }
}

//获取验证码接口
- (void)getMessageCode
{
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text, @"msgType":@"3"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/getSmsCode" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"找回登录密码获取验证码:=========%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//校验验证码接口
- (void)messageCodeData
{
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text, @"smsCode":textFieldMessage.text};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/checkSmsCode" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"找回登录密码校验验证码:~~~~~~~~~~~~%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            TWOForgetSecretViewController *twoForgetVC = [[TWOForgetSecretViewController alloc] init];
            twoForgetVC.phoneNum = textFieldPhone.text;
            [self.navigationController pushViewController:twoForgetVC animated:YES];
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:121];
    
    NSString *title = [NSString stringWithFormat:@"%lds",(long)seconds];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [button setTitle:@"获取验证码" forState: UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setEnabled:YES];
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
