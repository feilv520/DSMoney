//
//  TWOReceiveNumViewController.m
//  DSLC
//
//  Created by ios on 16/5/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOReceiveNumViewController.h"
#import "define.h"
#import "AppDelegate.h"
#import "TWOAgreeDSLCDelegetViewController.h"

@interface TWOReceiveNumViewController () <UITextFieldDelegate, UIScrollViewDelegate>

{
    UIButton *butGouXuan;
    UIScrollView *_scrollView;

//    邀请码输入框
    UITextField *textFieldInvite;
//    输入验证码输入框
    UITextField *textFieldYan;
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

@implementation TWOReceiveNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    seconds = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    [self contentShow];
}

- (void)contentShow
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    
    UIImageView *imageBigPic = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"bigpicture"]];
    [_scrollView addSubview:imageBigPic];
    imageBigPic.userInteractionEnabled = YES;
    
    //    左上角x按钮
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 30, 25, 25) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBigPic addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateHighlighted];
    [butCancle addTarget:self action:@selector(CancleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *phoneRString = [self.phoneString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    UILabel *labelPhone = [CreatView creatWithLabelFrame:CGRectMake(0, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[NSString stringWithFormat:@"已向%@发送短信", phoneRString]];
    [imageBigPic addSubview:labelPhone];
    
    UIImageView *imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20, WIDTH_CONTROLLER_DEFAULT/2, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"zhongxing"]];
    [imageBigPic addSubview:imageTwo];
    imageTwo.userInteractionEnabled = YES;
    
    UIImageView *imagePhone = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    [imageTwo addSubview:imagePhone];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageTwo addSubview:viewLine];
    
//    输入验证码输入框
    textFieldYan = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"短信验证码" setTintColor:[UIColor whiteColor]];
    [imageTwo addSubview:textFieldYan];
    textFieldYan.textColor = [UIColor whiteColor];
    textFieldYan.delegate = self;
    textFieldYan.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldYan setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIImageView *imageGet = [CreatView creatImageViewWithFrame:CGRectMake(30 + WIDTH_CONTROLLER_DEFAULT/2 + 10, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20, WIDTH_CONTROLLER_DEFAULT - 60 - 10 - imageTwo.frame.size.width, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuangyan"]];
    [imageBigPic addSubview:imageGet];
    imageGet.userInteractionEnabled = YES;
    
    UIButton *buttonGet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 5, imageGet.frame.size.width - 20, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"获取验证码"];
    [imageGet addSubview:buttonGet];
    buttonGet.tag = 969;
    [buttonGet addTarget:self action:@selector(buttonGetYanZhengMa:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageThree = [CreatView creatImageViewWithFrame:CGRectMake(30, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageBigPic addSubview:imageThree];
    imageThree.userInteractionEnabled = YES;
    
    UIImageView *imageInvite = [CreatView creatImageViewWithFrame:CGRectMake(22, 10, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"yaoqingma"]];
    [imageThree addSubview:imageInvite];
    
    UIView *viewLine2 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageThree addSubview:viewLine2];
    
//    输入邀请码输入框
    textFieldInvite = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"邀请码(选填)" setTintColor:[UIColor whiteColor]];
    [imageThree addSubview:textFieldInvite];
    textFieldInvite.delegate = self;
    textFieldInvite.textColor = [UIColor whiteColor];
    [textFieldInvite setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
//    注册按钮
    UIButton *buttRegist = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40*2 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"注册"];
    [imageBigPic addSubview:buttRegist];
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
    
    UIButton *butRightNow = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 140)/2, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40*3 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0/ 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 140, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"已有账号,立即登录"];
    [imageBigPic addSubview:butRightNow];
    [butRightNow addTarget:self action:@selector(buttonRightNowLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        textFieldYan.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        textFieldInvite.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        buttRegist.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        butRightNow.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        butRightNow.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 110)/2, 255.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10 + 20 + 40*3 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0/ 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 110, 20);
    } else {
        textFieldYan.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        textFieldInvite.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        buttRegist.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        butRightNow.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == textFieldYan) {
        if (range.location > 5) {
            return NO;
        } else {
            return YES;
        }
    } else {
        if (range.location > 9) {
            return NO;
        } else {
            return YES;
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 667) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset = CGPointMake(0, self.view.frame.size.height/4 + 20);
        } completion:^(BOOL finished) {
            
        }];
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset = CGPointMake(0, self.view.frame.size.height/4 + 35);
        } completion:^(BOOL finished) {
            
        }];
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset = CGPointMake(0, self.view.frame.size.height/4);
        } completion:^(BOOL finished) {
            
        }];
    }
}

//获取验证码按钮
- (void)buttonGetYanZhengMa:(UIButton *)button
{
    NSDictionary *parmeter = @{@"phone":self.phoneString, @"msgType":@"1"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/getSmsCode" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"注册获取验证码::::::::::::::::::::::%@", responseObject);
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
    NSLog(@"agree同意《大圣理财平台服务协议》页面跳转");
    TWOAgreeDSLCDelegetViewController *agreeDSLC = [[TWOAgreeDSLCDelegetViewController alloc] init];
    pushVC(agreeDSLC);
}

//注册按钮
- (void)registerButtonClicked:(UIButton *)button
{
    if (textFieldYan.text.length == 0) {
        [ProgressHUD showMessage:@"验证码不能为空" Width:100 High:20];
    } else if (textFieldYan.text.length != 6) {
        [ProgressHUD showMessage:@"验证码错误" Width:100 High:20];
    } else if (butGouXuan.tag == 999) {
        [ProgressHUD showMessage:@"请勾选注册协议" Width:100 High:20];
    } else {
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollView.contentOffset = CGPointMake(0, -20);
        } completion:^(BOOL finished) {
            
        }];
        [self registerFuction];
    }
}

//已有账号,立即登录方法
- (void)buttonRightNowLogin:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//左上角x按钮
- (void)CancleClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollView.contentOffset = CGPointMake(0, -20);
        [_scrollView endEditing:YES];
    } completion:^(BOOL finished) {
        
    }];
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:969];
    
    NSString *title = [NSString stringWithFormat:@"%lds",(long)seconds];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
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

#pragma mark 对接接口
#pragma mark --------------------------------

- (void)registerFuction{
    NSDictionary *parmeter = @{@"phone":self.phoneString,@"smsCode":textFieldYan.text,@"invitationCode":textFieldInvite.text,@"clientType":@"iOS",@"ImgData":@""};
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"reg/register" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [hud hide:YES];
        
        NSLog(@"register = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@200]) {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            
            if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                [FileOfManage createWithFile:@"Member.plist"];
                NSDictionary *dicP = [NSDictionary dictionary];
                dicP = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     self.phoneString,@"phone",
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
                [dicP writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            } else {
                NSDictionary *dicN = [NSDictionary dictionary];
                dicN = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     self.phoneString,@"phone",
                                     [responseObject objectForKey:@"key"],@"key",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realname"],@"realname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                     [responseObject objectForKey:@"token"],@"token",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                [dicN writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                NSLog(@"%@",[responseObject objectForKey:@"token"]);
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                [self userSign:[responseObject objectForKey:@"token"]];
                
                [self getMyAccountInfoFuction:[responseObject objectForKey:@"token"]];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadWithWebview" object:[responseObject objectForKey:@"token"]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"yaoLogin" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getProductDetail" object:nil];
            }];
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hide:YES];
        NSLog(@"%@", error);
        
    }];
}

- (void)getMyAccountInfoFuction:(NSString *)tokenString{
    
    NSMutableDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":tokenString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getMyAccountInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [memberDic setObject:[responseObject objectForKey:@"invitationMyCode"] forKey:@"invitationMyCode"];
            
            [memberDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)userSign:(NSString *)tokenString{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    NSMutableDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":tokenString,@"signDate":dateString};
     
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
