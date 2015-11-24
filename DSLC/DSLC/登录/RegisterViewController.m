//
//  RegisterViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RegisterViewController.h"
#import "define.h"
#import "RegisterProcess.h"
#import "CreatView.h"
#import "RegisterOfView.h"
#import "RegisterOfResult.h"
#import "RegisterOfPassButton.h"
#import "InviteRegisterViewController.h"
#import "RiskAlertBookViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>{
    NSInteger number;
    NSInteger buttonTag;
    UIButton *payButton;
    UILabel *lableRedLine;
    UIView *buttonWithView;
    RegisterOfView *registerV;
    RegisterProcess *registerP;
    RegisterOfResult *registerR;
    RegisterOfPassButton *registerB;
    
    NSTimer *timer;
    NSInteger seconds;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.scrollView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"注册大圣理财"];
    
    number = 0;
    
    seconds = 120;
    
    self.scrollView.contentSize = CGSizeMake(1, 730);
    
    [self RegisterProcessPhoto];
    [self RegisterNav];
    [self RegisterMessage];
    [self RegisterSureButton];
    
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
    [self.navigationController popViewControllerAnimated:YES];
}

// 注册流程图一
- (void)RegisterProcessPhoto{
    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArray = [rootBundle loadNibNamed:@"RegisterProcess" owner:nil options:nil];
    registerP = [rootArray lastObject];
    
    registerP.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, (103 / 375.0) * HEIGHT_CONTROLLER_DEFAULT);
    
    [self.scrollView addSubview:registerP];
    
}

// 注册导航 (用户注册/理财师注册)
- (void)RegisterNav{
    
    buttonWithView = [[UIView alloc] initWithFrame:CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 50)];
    
    buttonWithView.backgroundColor = Color_White;
    
    UIButton *userRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *teacherRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    
    userRegister.tag = 1000;
    teacherRegister.tag = 1001;
    
    buttonTag = 1000;
    
    userRegister.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT / 2.0, 48);
    teacherRegister.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT / 2.0, 0, WIDTH_CONTROLLER_DEFAULT / 2.0, 48);
    
    [userRegister setTitle:@"用户注册" forState:UIControlStateNormal];
    [userRegister setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
    
    [teacherRegister setTitle:@"理财师注册" forState:UIControlStateNormal];
    [teacherRegister setTitleColor:Color_Black forState:UIControlStateNormal];
    
    userRegister.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    teacherRegister.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    [userRegister addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [teacherRegister addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonWithView addSubview:userRegister];
    [buttonWithView addSubview:teacherRegister];
    
    lableRedLine = [CreatView creatWithLabelFrame:CGRectMake(0, 48, WIDTH_CONTROLLER_DEFAULT / 2.0, 2) backgroundColor:[UIColor daohanglan] textColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont systemFontOfSize:0] text:@""];
    [buttonWithView addSubview:lableRedLine];
    
    [self.scrollView addSubview:buttonWithView];
}

// 导航按钮执行方法
- (void)buttonAction:(UIButton *)btn{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        if (btn.tag == 1000) {
            if (btn.tag != buttonTag){
                lableRedLine.frame = CGRectMake(0, 48, WIDTH_CONTROLLER_DEFAULT / 2.0, 2);
                [btn setTitleColor:Color_Red forState:UIControlStateNormal];
                
                UIButton *button = (UIButton *)[self.view viewWithTag:buttonTag];
                [button setTitleColor:Color_Black forState:UIControlStateNormal];
                
                buttonTag = btn.tag;
            }
            
            registerV.inviteNumber.text = @"邀请码(选填)";
            registerV.sandMyselfIDCard.placeholder = @"请输入邀请码";
            [registerV.problemButton setImage:[UIImage imageNamed:@"iconfont-register-gantanhao001"] forState:UIControlStateNormal];
            
        } else {
            if (btn.tag != buttonTag){
                lableRedLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT / 2, 48, WIDTH_CONTROLLER_DEFAULT / 2.0, 2);
                [btn setTitleColor:Color_Red forState:UIControlStateNormal];
                
                UIButton *button = (UIButton *)[self.view viewWithTag:buttonTag];
                [button setTitleColor:Color_Black forState:UIControlStateNormal];
                
                buttonTag = btn.tag;
            }
            
            registerV.inviteNumber.text = @"上传名片";
            registerV.sandMyselfIDCard.placeholder = @"请上传您的个人名片";
            [registerV.problemButton setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
            
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)InviteShuoMing:(UIButton *)button
{
    InviteRegisterViewController *invite = [[InviteRegisterViewController alloc] init];
    [self.navigationController pushViewController:invite animated:YES];
}

// 注册信息
- (void)RegisterMessage{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArray = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
    registerV = [rootArray firstObject];
    
    registerV.frame = CGRectMake(0, 160, WIDTH_CONTROLLER_DEFAULT, (125 / 375.0) * HEIGHT_CONTROLLER_DEFAULT);
    
    [registerV.sandMyselfIDCard addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [registerV.smsCode addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [registerV.phoneNumber addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [registerV.loginPassword addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [registerV.sureLoginPassword addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
    registerV.phoneNumber.delegate = self;
    registerV.smsCode.delegate = self;
    registerV.phoneNumber.delegate = self;
    registerV.loginPassword.delegate = self;
    registerV.sureLoginPassword.delegate = self;
    registerV.sandMyselfIDCard.delegate = self;
    
    registerV.getCode.layer.masksToBounds = YES;
    registerV.getCode.layer.borderWidth = 1.f;
    registerV.getCode.tag = 9080;
    registerV.getCode.layer.borderColor = [UIColor daohanglan].CGColor;
    [registerV.getCode setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
    registerV.getCode.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    registerV.getCode.layer.cornerRadius = 4.f;
    
    [registerV.getCode addTarget:self action:@selector(getCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerV.problemButton addTarget:self action:@selector(InviteShuoMing:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:registerV];
}

// 确认按钮
- (void)RegisterSureButton{
    
    UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tapButton.frame = CGRectMake(0, 400, WIDTH_CONTROLLER_DEFAULT/2, 15);
    [tapButton setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
    [tapButton setTitleColor:Color_Black forState:UIControlStateNormal];
    [tapButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    tapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [tapButton setTitle:@"平台服务条款" forState:UIControlStateNormal];
    [self.scrollView addSubview:tapButton];
    
    UIButton *bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bookButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 400, WIDTH_CONTROLLER_DEFAULT/2, 15);
    [bookButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bookButton.titleLabel setFont:[UIFont fontWithName:@"CenturyGothic" size:12]];
    [bookButton addTarget:self action:@selector(bookButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    bookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bookButton setTitle:@"<<风险提示书>>" forState:UIControlStateNormal];
    [bookButton setTitleColor:[UIColor chongzhiColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:bookButton];
    
    payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 440, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"确定" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [payButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    
    [self.scrollView addSubview:payButton];
    
}

// 确认按钮执行方法 (第二步 : 实名验证)
- (void)sureButtonAction:(UIButton *)btn{
    
    if ([registerV.phoneNumber.text length] <= 0) {
    
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
        
    } else if ([registerV.smsCode.text length] <= 0) {
        
        [ProgressHUD showMessage:@"请输入验证码" Width:100 High:20];
        
    } else if ([registerV.loginPassword.text length] <= 0) {
        
        [ProgressHUD showMessage:@"请输入设置密码" Width:100 High:20];
        
    } else if ([registerV.sureLoginPassword.text length] <= 0) {
     
        [ProgressHUD showMessage:@"请输入确认密码" Width:100 High:20];
        
    } else {
        [self RegisterButtonAction];
    }
}

- (void)sureButtonActionFinish:(UIButton *)btn{
    [registerB removeFromSuperview];
    [registerR removeFromSuperview];
    [registerV removeFromSuperview];
    registerB = nil;
    registerR = nil;
    registerV = nil;
    
    registerP.photoImageView.image = [UIImage imageNamed:@"register-3"];

    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArrayOfView = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
    NSArray *rootArrayOfResult = [rootBundle loadNibNamed:@"RegisterOfResult" owner:nil options:nil];
    NSArray *rootArrayOfPButton = [rootBundle loadNibNamed:@"RegisterOfPassButton" owner:nil options:nil];
    
    registerR = [rootArrayOfResult lastObject];
    
    registerR.frame = CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 65);
    
    registerR.titleSuccess.text = @"验证成功";
    registerR.passTitle.text = @"您可以绑定银行卡，也可以选择跳过．";
    
    registerV = [rootArrayOfView lastObject];
    
    registerV.frame = CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 313);
    
    registerB = [rootArrayOfPButton lastObject];
    
    registerB.frame = CGRectMake(0, CGRectGetMaxY(registerV.frame), WIDTH_CONTROLLER_DEFAULT, 100);
    
    [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerB.sureButton addTarget:self action:@selector(sureButtonActionPass:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:registerV];
    [self.scrollView addSubview:registerR];
    [self.scrollView addSubview:registerB];
    
}

- (void)sureButtonActionPass:(UIButton *)btn{
    [ProgressHUD showMessage:@"完成" Width:100 High:100];
}

- (void)passButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// 检测验证码
- (void)checkSmsCode{
    
    NSDictionary *parameters = @{@"smsCode":registerV.smsCode.text};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/checkSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [self RegisterButtonAction];
        }
        [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

// 注册按钮执行的方法
- (void)RegisterButtonAction{
    [self.view endEditing:YES];
    if (registerV.phoneNumber.text.length < 11) {
        [ProgressHUD showMessage:@"手机号必须为11位" Width:100 High:20];
    } else if (registerV.smsCode.text.length < 6) {
        [ProgressHUD showMessage:@"验证码必须为6位" Width:100 High:20];
    } else if (registerV.loginPassword.text.length < 6){
        [ProgressHUD showMessage:@"密码必须为6-12位" Width:100 High:20];
    } else if (![registerV.loginPassword.text isEqualToString:registerV.sureLoginPassword.text]){
        [ProgressHUD showMessage:@"输入的登录密码与确认的登录密码不匹配" Width:100 High:20];
    } else {
        NSDictionary *parameters = @{@"phone":registerV.phoneNumber.text,@"smsCode":registerV.smsCode.text,@"password":registerV.loginPassword.text,@"invitationCode":registerV.sandMyselfIDCard.text,@"finaCard":registerV.sandMyselfIDCard.text};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/register" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
    //            [buttonWithView removeFromSuperview];
    //            [payButton removeFromSuperview];
    //            [registerV removeFromSuperview];
    //            registerV = nil;
    //        
    //            registerP.photoImageView.image = [UIImage imageNamed:@"register-2"];
    //        
    //            NSBundle *rootBundle = [NSBundle mainBundle];
    //            NSArray *rootArrayOfView = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
    //            NSArray *rootArrayOfResult = [rootBundle loadNibNamed:@"RegisterOfResult" owner:nil options:nil];
    //            NSArray *rootArrayOfPButton = [rootBundle loadNibNamed:@"RegisterOfPassButton" owner:nil options:nil];
    //        
    //            registerR = [rootArrayOfResult lastObject];
    //        
    //            registerR.frame = CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 65);
    //        
    //            registerV = [rootArrayOfView objectAtIndex:1];
    //        
    //            registerV.frame = CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 134);
    //        
    //            registerB = [rootArrayOfPButton lastObject];
    //        
    //            registerB.frame = CGRectMake(0, 320, WIDTH_CONTROLLER_DEFAULT, 100);
    //        
    //            [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //            [registerB.sureButton addTarget:self action:@selector(sureButtonActionFinish:) forControlEvents:UIControlEventTouchUpInside];
    //            
    //            [self.scrollView addSubview:registerV];
    //            [self.scrollView addSubview:registerR];
    //            [self.scrollView addSubview:registerB];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == registerV.phoneNumber) {
        if (range.location > 10) {
            return NO;
        }
    } else if (textField == registerV.smsCode) {
        if (range.location > 5) {
            return NO;
        }
    } else if (textField == registerV.loginPassword) {
        if (range.location > 11) {
            return NO;
        }
    } else if (textField == registerV.sureLoginPassword) {
        if (range.location > 11) {
            return NO;
        }
    } else {
        return YES;
    }
    return YES;
}

// 风险提示书
- (void)bookButtonAction:(UIButton *)btn
{
    RiskAlertBookViewController *riskVC = [[RiskAlertBookViewController alloc] init];
    riskVC.disign = YES;
    [self.navigationController pushViewController:riskVC animated:YES];
}

// 获得验证码
- (void)getCodeButtonAction:(UIButton *)btn{
    [self.view endEditing:YES];
    
    if (registerV.phoneNumber.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameters = @{@"phone":registerV.phoneNumber.text,@"msgType":@"1"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [ProgressHUD showMessage:@"系统异常" Width:100 High:20];
            NSLog(@"%@",error);
        }];
    }
}

// 按钮变颜色
- (void)textFieldEdit:(UITextField *)textField{
    if ([registerV.smsCode.text length] > 0 && [registerV.phoneNumber.text length] > 0 && [registerV.loginPassword.text length] > 0 && [registerV.sureLoginPassword.text length] > 0) {
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
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
