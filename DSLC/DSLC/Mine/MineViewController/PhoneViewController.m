//
//  PhoneViewController.m
//  DSLC
//
//  Created by ios on 15/10/22.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "PhoneViewController.h"
#import "ChangeNumViewController.h"
#import "MyAfHTTPClient.h"

@interface PhoneViewController () <UITextFieldDelegate>

{
    UITextField *textFieldPhoneNumber;
    UITextField *textFieldSmsCode;
    UIButton *butNext;
    
    NSInteger seconds;
    NSTimer *timer;
}

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    seconds = 120;
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"身份验证"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewTop = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewTop];
    
    UILabel *labelNew = [CreatView creatWithLabelFrame:CGRectMake(10, 1, 60, 49) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[NSString stringWithFormat:@"%@", @"原手机号"]];
    
    textFieldPhoneNumber = [CreatView creatWithfFrame:CGRectMake(CGRectGetMaxX(labelNew.frame)+ 10, 1, WIDTH_CONTROLLER_DEFAULT - 100, 49.5) setPlaceholder:@"请输入原来的手机号" setTintColor:[UIColor grayColor]];
    textFieldPhoneNumber.tag = 77777;
    textFieldPhoneNumber.delegate = self;
    textFieldPhoneNumber.font = [UIFont systemFontOfSize:15];
    textFieldPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldPhoneNumber addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
    [viewTop addSubview:textFieldPhoneNumber];
    [viewTop addSubview:labelNew];
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 50)backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    UILabel *labelVerify = [CreatView creatWithLabelFrame:CGRectMake(10, 1, 50, 49) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"验证码"];
    [viewDown addSubview:labelVerify];
    
    textFieldSmsCode = [CreatView creatWithfFrame:CGRectMake(CGRectGetMaxX(labelNew.frame)+ 10, 10, 180, 30) setPlaceholder:@"请输入验证码" setTintColor:[UIColor grayColor]];
    [viewDown addSubview:textFieldSmsCode];
    textFieldSmsCode.tag = 66666;
    textFieldSmsCode.delegate = self;
    textFieldSmsCode.keyboardType = UIKeyboardTypeNumberPad;
    textFieldSmsCode.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [textFieldSmsCode addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *butGet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 100, 10, 90, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"获取验证码"];
    [viewDown addSubview:butGet];
    butGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butGet.layer.cornerRadius = 4;
    butGet.layer.masksToBounds = YES;
    butGet.tag = 9080;
    butGet.layer.borderWidth = 0.5;
    butGet.layer.borderColor = [[UIColor daohanglan] CGColor];
    [butGet addTarget:self action:@selector(getNumButton:) forControlEvents:UIControlEventTouchUpInside];
    
    butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 170, WIDTH_CONTROLLER_DEFAULT - 80, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:butNext];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butNext addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
}

//获取验证码
- (void)getNumButton:(UIButton *)button
{
    if (textFieldPhoneNumber.text.length <= 0){
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:textFieldPhoneNumber.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else {
    
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameter = @{@"phone":textFieldPhoneNumber.text, @"msgType":@"2"};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已发送"];
            NSLog(@"ooooooo%@", responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"fffffffff%@", error);
            
        }];
        
    }
}

#pragma mark textField delegate
#pragma mark --------------------------------

- (void)textFieldEdit:(UITextField *)textField
{
    if (textFieldPhoneNumber.text.length != 11) {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textFieldSmsCode.text.length != 6) {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 77777) {
        
        if (range.location < 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else {
        
        if (range.location == 6) {
            
            return NO;
            
        } else {
            
            return YES;
        }
    }
}

//下一步按钮
- (void)nextButton:(UIButton *)button
{
    if (textFieldPhoneNumber.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:textFieldPhoneNumber.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else if (textFieldSmsCode.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入验证码"];
        
    } else if (textFieldSmsCode.text.length != 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
        
    } else {
        
        NSDictionary *parameter = @{@"smsCode":textFieldSmsCode.text,@"phone":textFieldPhoneNumber.text,};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/checkSmsCode" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"ooooooo%@", responseObject);
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                
                ChangeNumViewController *changeNumVC = [[ChangeNumViewController alloc] init];
                [self.navigationController pushViewController:changeNumVC animated:YES];
                
            } else {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"fffffffff%@", error);
            
        }];

    }
    
    
//    if ([textFieldSmsCode.text length] > 0 && [textFieldPhoneNumber.text length] > 0) {
//        
//        NSDictionary *parameter = @{@"smsCode":textFieldSmsCode.text,@"phone":textFieldPhoneNumber.text,};
//        
//        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/checkSmsCode" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
//            
//            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
//            NSLog(@"ooooooo%@", responseObject);
//            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
//                
//                ChangeNumViewController *changeNumVC = [[ChangeNumViewController alloc] init];
//                [self.navigationController pushViewController:changeNumVC animated:YES];
//                
//            } else {
//                
//                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
//            }
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            NSLog(@"fffffffff%@", error);
//            
//        }];
//
//    } else {
//        
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)labelLineShow:(UILabel *)label
{
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.2;
}

#pragma mark 验证码倒计时
#pragma mark --------------------------------

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:9080];
    
    NSString *title = [NSString stringWithFormat:@"重新发送(%lds)",seconds];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 120;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor daohanglan].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        [button setTitle:@"获取验证码" forState: UIControlStateNormal];
        [button setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        [button setEnabled:YES];
    }else{
        seconds--;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor zitihui].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setEnabled:NO];
    }
}

- (void)releaseTImer {
    if (timer) {
        if ([timer respondsToSelector:@selector(isValid)]) {
            if ([timer isValid]) {
                [timer invalidate];
                seconds = 120;
            }
        }
    }
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
