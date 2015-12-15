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

@interface RegisterViewController ()<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    NSInteger number;
    NSInteger buttonTag;
    UIButton *payButton;
    UILabel *lableRedLine;
    UIView *buttonWithView;
    
    RegisterProcess *registerP;
    RegisterOfResult *registerR;
    RegisterOfPassButton *registerB;
    
    NSTimer *timer;
    NSInteger seconds;
    
    UIButton *tapButton;
    
    // 上传按钮
    UIButton *butBlack;
    UIView *viewDown;
    
    NSData *finaCard;
    
    NSString *userID;
    
    UIButton *bookButton;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic, strong) RegisterOfView *registerV;

@property (nonatomic, assign) BOOL flag;

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
    
    userID = 0;
    
    seconds = 60;
    
    self.scrollView.contentSize = CGSizeMake(1, 750);
    
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
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        if (btn.tag == 1000) {
            if (btn.tag != buttonTag){
                lableRedLine.frame = CGRectMake(0, 48, WIDTH_CONTROLLER_DEFAULT / 2.0, 2);
                [btn setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
                
                UIButton *button = (UIButton *)[self.view viewWithTag:buttonTag];
                [button setTitleColor:Color_Black forState:UIControlStateNormal];
                [bookButton setTitle:@"《大圣理财平台用户服务协议》" forState:UIControlStateNormal];
                buttonTag = btn.tag;
            }
            
            self.registerV.inviteNumber.text = @"邀请码(选填)";
            self.registerV.sandMyselfIDCard.placeholder = @"请输入邀请码";
            [self.registerV.problemButton setImage:[UIImage imageNamed:@"iconfont-register-gantanhao001"] forState:UIControlStateNormal];
            
            self.flag = NO;
        } else {
            if (btn.tag != buttonTag){
                lableRedLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT / 2, 48, WIDTH_CONTROLLER_DEFAULT / 2.0, 2);
                [btn setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
                
                UIButton *button = (UIButton *)[self.view viewWithTag:buttonTag];
                [button setTitleColor:Color_Black forState:UIControlStateNormal];
                
                buttonTag = btn.tag;
            }
            
            self.registerV.inviteNumber.text = @"上传名片";
            self.registerV.sandMyselfIDCard.placeholder = @"请上传您的个人名片";
            self.registerV.sandMyselfIDCard.userInteractionEnabled = NO;
            [self.registerV.problemButton setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
            
            [bookButton setTitle:@"《大圣理财平台理财师服务协议》" forState:UIControlStateNormal];
            self.flag = YES;
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)InviteShuoMing:(UIButton *)button
{
    [self.view endEditing:YES];
    if (self.flag) {
        butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.tabBarVC.view addSubview:butBlack];
        butBlack.alpha = 0.3;
        [butBlack addTarget:self action:@selector(buttonBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
        viewDown = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 180, WIDTH_CONTROLLER_DEFAULT, 160) backgroundColor:[UIColor huibai]];
        [app.tabBarVC.view addSubview:viewDown];
        
        [self viewDownShow];
    } else {
        
        InviteRegisterViewController *invite = [[InviteRegisterViewController alloc] init];
        [self.navigationController pushViewController:invite animated:YES];
        
    }
}

// 注册信息
- (void)RegisterMessage{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArray = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];

    self.registerV = [rootArray firstObject];
    
    self.registerV.frame = CGRectMake(0, 160, WIDTH_CONTROLLER_DEFAULT, 225);
    
    [self.registerV.sandMyselfIDCard addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [self.registerV.smsCode addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [self.registerV.phoneNumber addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [self.registerV.loginPassword addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [self.registerV.sureLoginPassword addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
    self.registerV.phoneNumber.delegate = self;
    self.registerV.smsCode.delegate = self;
    self.registerV.loginPassword.delegate = self;
    self.registerV.sureLoginPassword.delegate = self;
    self.registerV.sandMyselfIDCard.delegate = self;
    
    self.registerV.phoneNumber.tintColor = [UIColor grayColor];
    self.registerV.smsCode.tintColor = [UIColor grayColor];
    self.registerV.loginPassword.tintColor = [UIColor grayColor];
    self.registerV.sureLoginPassword.tintColor = [UIColor grayColor];
    self.registerV.sandMyselfIDCard.tintColor = [UIColor grayColor];
    
    self.registerV.getCode.layer.masksToBounds = YES;
    self.registerV.getCode.layer.borderWidth = 1.f;
    self.registerV.getCode.tag = 9080;
    self.registerV.getCode.layer.borderColor = [UIColor daohanglan].CGColor;
    [self.registerV.getCode setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
    self.registerV.getCode.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    self.registerV.getCode.layer.cornerRadius = 4.f;
    
    [self.registerV.getCode addTarget:self action:@selector(getCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerV.problemButton addTarget:self action:@selector(InviteShuoMing:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:self.registerV];
}

// 确认按钮
- (void)RegisterSureButton{
    
    tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tapButton.frame = CGRectMake(0, 400, WIDTH_CONTROLLER_DEFAULT/3, 15);
    [tapButton setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
    [tapButton setTitleColor:Color_Black forState:UIControlStateNormal];
    [tapButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    tapButton.tag = 88888888;
    tapButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [tapButton setTitle:@"注册即同意" forState:UIControlStateNormal];
    [self.scrollView addSubview:tapButton];
    [tapButton addTarget:self action:@selector(checkChooseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bookButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3, 400, WIDTH_CONTROLLER_DEFAULT/3*2, 15);
    [bookButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bookButton.titleLabel setFont:[UIFont fontWithName:@"CenturyGothic" size:12]];
    [bookButton addTarget:self action:@selector(bookButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    bookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bookButton setTitle:@"《大圣理财平台用户服务协议》" forState:UIControlStateNormal];
    [bookButton setTitleColor:[UIColor chongzhiColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:bookButton];
    
    CGRect width = [[UIScreen mainScreen] bounds];
    
    if (width.size.width == 320) {
        
        tapButton.frame = CGRectMake(0, 400, WIDTH_CONTROLLER_DEFAULT/3, 15);
        bookButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3, 400, WIDTH_CONTROLLER_DEFAULT/3*2, 15);
        
    } else {
        
        tapButton.frame = CGRectMake(0, 400, WIDTH_CONTROLLER_DEFAULT/3 + 10, 15);
        bookButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 + 10, 400, WIDTH_CONTROLLER_DEFAULT/3*2, 15);
    }
    
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

//勾选按钮
- (void)checkChooseButton:(UIButton *)button
{
    if (button.tag == 88888888) {
        
        button.tintColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:@"iconfont-complete-拷贝-3"] forState:UIControlStateNormal];
        button.tag = 9876;
        
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        button.tintColor = [UIColor grayColor];
        [button setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
        button.tag = 88888888;
        
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

// 确认按钮执行方法 (第二步 : 实名验证)
- (void)sureButtonAction:(UIButton *)btn{
    [self RegisterButtonAction];
}

- (void)sureButtonActionFinish:(UIButton *)btn{
    
    NSLog(@"self.registerV.realName.text = %@",self.registerV.realName.text);
    NSLog(@"self.registerV.IDCard.text = %@",self.registerV.IDCard.text);
    
    NSDictionary *parameter = @{@"userId":userID,@"realName":self.registerV.realName.text,@"IDCardNum":self.registerV.IDCard.text};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/authRrealName" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            NSLog(@"%@",responseObject);
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [registerB removeFromSuperview];
            [registerR removeFromSuperview];
            [self.registerV removeFromSuperview];
            registerB = nil;
            registerR = nil;
            self.registerV = nil;
        
            registerP.photoImageView.image = [UIImage imageNamed:@"register-3"];
        
            NSBundle *rootBundle = [NSBundle mainBundle];
            NSArray *rootArrayOfView = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
            NSArray *rootArrayOfResult = [rootBundle loadNibNamed:@"RegisterOfResult" owner:nil options:nil];
            NSArray *rootArrayOfPButton = [rootBundle loadNibNamed:@"RegisterOfPassButton" owner:nil options:nil];
        
            registerR = [rootArrayOfResult lastObject];
        
            registerR.frame = CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 65);
        
            registerR.titleSuccess.text = @"验证成功";
            registerR.passTitle.text = @"您可以绑定银行卡，也可以选择跳过．";
            
            self.registerV = [rootArrayOfView lastObject];
        
            self.registerV.frame = CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 270);
        
            registerB = [rootArrayOfPButton lastObject];
        
            registerB.frame = CGRectMake(0, CGRectGetMaxY(self.registerV.frame), WIDTH_CONTROLLER_DEFAULT, 100);
        
            [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [registerB.sureButton addTarget:self action:@selector(sureButtonActionPass:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.scrollView addSubview:self.registerV];
            [self.scrollView addSubview:registerR];
            [self.scrollView addSubview:registerB];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
}

- (void)sureButtonActionPass:(UIButton *)btn{
    [ProgressHUD showMessage:@"完成" Width:100 High:100];
}

- (void)passButtonAction:(UIButton *)btn{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// 检测验证码
- (void)checkSmsCode{
    
    NSDictionary *parameters = @{@"smsCode":self.registerV.smsCode.text};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/checkSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [self RegisterButtonAction];
        }
        [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

// 注册按钮执行的方法
- (void)RegisterButtonAction
{
    [self.view endEditing:YES];
    
    if (self.registerV.phoneNumber.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (self.registerV.phoneNumber.text.length != 11) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else if (self.registerV.smsCode.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入验证码"];
        
    } else if (self.registerV.smsCode.text.length != 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
        
    } else if (self.registerV.loginPassword.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请设置登录密码"];
        
    } else if (![NSString validatePassword:self.registerV.loginPassword.text]){
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位字符,以字母开头"];
        
    } else if (self.registerV.sureLoginPassword.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入确认密码"];
        
    } else if (self.registerV.sureLoginPassword.text.length < 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else if (![self.registerV.loginPassword.text isEqualToString:self.registerV.sureLoginPassword.text]){
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else if (tapButton.tintColor != [UIColor whiteColor]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请勾选大圣理财平台服务协议"];
        
    } else {
        NSDictionary *parameters = [NSDictionary dictionary];
        if (self.flag) {
            
            NSLog(@"理财师注册");
            
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"cardIDImage.png"];
            
            UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            
            finaCard = [[MyAfHTTPClient sharedClient] resetSizeOfImageData:savedImage maxSize:1024 * 2];
        
            parameters = @{@"phone":self.registerV.phoneNumber.text,@"smsCode":self.registerV.smsCode.text,@"password":self.registerV.loginPassword.text,@"invitationCode":@"",@"ImgData":finaCard};
            
            NSString *URLPostString = [NSString stringWithFormat:@"%@%@",MYAFHTTP_BASEURL,@"app/register"];
            
            [[MyAfHTTPClient sharedClient] POST:URLPostString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                
                [formData appendPartWithFileData:finaCard name:@"ImgData" fileName:fileName mimeType:@"application/octet-stream"];
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                NSData *doubi = responseObject;
                NSMutableString *responseString = [[NSMutableString alloc] initWithData:doubi encoding:NSUTF8StringEncoding];
                
                NSString *character = nil;
                for (int i = 0; i < responseString.length; i ++) {
                    character = [responseString substringWithRange:NSMakeRange(i, 1)];
                    if ([character isEqualToString:@"\\"])
                        [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
                }
                responseString = [[responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]] copy];
                
                NSLog(@"responseString = %@",responseString);
                
                NSDictionary *responseDic = [MyAfHTTPClient parseJSONStringToNSDictionary:responseString];
                
                NSLog(@"%@",responseDic);
                
                if ([[responseDic objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseDic objectForKey:@"resultMsg"]];
                    
                    [buttonWithView removeFromSuperview];
                    [payButton removeFromSuperview];
                    [self.registerV removeFromSuperview];
                    self.registerV = nil;
        
                    registerP.photoImageView.image = [UIImage imageNamed:@"register-2"];
        
                    NSBundle *rootBundle = [NSBundle mainBundle];
                    NSArray *rootArrayOfView = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
                    NSArray *rootArrayOfResult = [rootBundle loadNibNamed:@"RegisterOfResult" owner:nil options:nil];
                    NSArray *rootArrayOfPButton = [rootBundle loadNibNamed:@"RegisterOfPassButton" owner:nil options:nil];
        
                    registerR = [rootArrayOfResult lastObject];
        
                    registerR.frame = CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 65);
        
                    self.registerV = [rootArrayOfView objectAtIndex:1];
        
                    self.registerV.frame = CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 90);
        
                    registerB = [rootArrayOfPButton lastObject];
        
                    registerB.frame = CGRectMake(0, 290, WIDTH_CONTROLLER_DEFAULT, 100);
        
                    [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    [registerB.sureButton addTarget:self action:@selector(sureButtonActionFinish:) forControlEvents:UIControlEventTouchUpInside];
        
                    [self.scrollView addSubview:self.registerV];
                    [self.scrollView addSubview:registerR];
                    [self.scrollView addSubview:registerB];
                    
                    // 跳过操作
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
//                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseDic objectForKey:@"resultMsg"]];
                }

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
            
        } else {
            
            NSLog(@"普通注册");
            
            parameters = @{@"phone":self.registerV.phoneNumber.text,@"smsCode":self.registerV.smsCode.text,@"password":self.registerV.loginPassword.text,@"invitationCode":self.registerV.sandMyselfIDCard.text,@"finaCard":@""};
            
            [[MyAfHTTPClient sharedClient] postWithURLString:@"app/register" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
                
                NSLog(@"%@",responseObject);
                if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                    
                    userID = [responseObject objectForKey:@"userId"];
                    
                    [buttonWithView removeFromSuperview];
                    [payButton removeFromSuperview];
                    [self.registerV removeFromSuperview];
                    self.registerV = nil;
        
                    registerP.photoImageView.image = [UIImage imageNamed:@"register-2"];
        
                    NSBundle *rootBundle = [NSBundle mainBundle];
                    NSArray *rootArrayOfView = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
                    NSArray *rootArrayOfResult = [rootBundle loadNibNamed:@"RegisterOfResult" owner:nil options:nil];
                    NSArray *rootArrayOfPButton = [rootBundle loadNibNamed:@"RegisterOfPassButton" owner:nil options:nil];
        
                    registerR = [rootArrayOfResult lastObject];
        
                    registerR.frame = CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 65);
        
                    self.registerV = [rootArrayOfView objectAtIndex:1];
        
                    self.registerV.frame = CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 90);
        
                    registerB = [rootArrayOfPButton lastObject];
        
                    registerB.frame = CGRectMake(0, 290, WIDTH_CONTROLLER_DEFAULT, 100);
        
                    [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    [registerB.sureButton addTarget:self action:@selector(sureButtonActionFinish:) forControlEvents:UIControlEventTouchUpInside];
        
                    [self.scrollView addSubview:self.registerV];
                    [self.scrollView addSubview:registerR];
                    [self.scrollView addSubview:registerB];
                    
                    // 返回方法
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
//                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    //
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
            
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.registerV.phoneNumber) {
        if (range.location > 10) {
            return NO;
        }
    } else if (textField == self.registerV.smsCode) {
        if (range.location > 5) {
            return NO;
        }
    } else if (textField == self.registerV.loginPassword) {
        if (range.location > 19) {
            return NO;
        }
    } else if (textField == self.registerV.sureLoginPassword) {
        if (range.location > 19) {
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
    
    if (self.registerV.phoneNumber.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:self.registerV.phoneNumber.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameters = @{@"phone":self.registerV.phoneNumber.text,@"msgType":@"1"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"系统异常"];
            NSLog(@"%@",error);
        }];
    }
}

// 按钮变颜色
- (void)textFieldEdit:(UITextField *)textField{
//    if ([self.registerV.smsCode.text length] > 0 && [self.registerV.phoneNumber.text length] > 0 && [self.registerV.loginPassword.text length] > 0 && [self.registerV.sureLoginPassword.text length] > 0) {
//        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
//        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
//        
//    } else {
//        
//        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
//        [payButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
//    }
}

#pragma mark 验证码倒计时
#pragma mark --------------------------------

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:9080];
    
    NSString *title = [NSString stringWithFormat:@"重新发送(%lds)",(long)seconds];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
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
                seconds = 60;
            }
        }
    }
}

#pragma mark 上传头像
#pragma mark --------------------------------

//弹出框
- (void)viewDownShow
{
    UIButton *butCamera = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"拍照"];
    [viewDown addSubview:butCamera];
    butCamera.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCamera addTarget:self action:@selector(takeCamera:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine1 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butCamera addSubview:labelLine1];
    labelLine1.alpha = 0.2;
    
    UIButton *butPicture = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 50, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"从手机相册选择"];
    [viewDown addSubview:butPicture];
    butPicture.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butPicture addTarget:self action:@selector(chooseFromPicture:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 110, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"取消"];
    [viewDown addSubview:butCancle];
    butCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCancle addTarget:self action:@selector(buttonCancle:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine2 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butPicture addSubview:labelLine2];
    labelLine2.alpha = 0.3;
    
    UILabel *labelLine3 = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butCancle addSubview:labelLine3];
    labelLine3.alpha = 0.3;
}

//取消按钮
- (void)buttonCancle:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
}

//黑色遮罩层消失
- (void)buttonBlackDisappear:(UIButton *)button
{
    [button removeFromSuperview];
    [viewDown removeFromSuperview];
    
    viewDown = nil;
    button = nil;
}

//拍照
- (void)takeCamera:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
    
    NSLog(@"拍照");
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    //            sourceType = UIImagePickerControllerSourceTypeCamera;
    //        }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

//从相册选择
- (void)chooseFromPicture:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
    
    NSLog(@"从相册选择");
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    
    pickerImage.delegate = self;
    
    pickerImage.navigationBar.barTintColor = [UIColor colorWithRed:223.0/255 green:74.0/255 blue:67.0/255 alpha:1];
    
    pickerImage.allowsEditing = NO;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"cardIDImage.png"];
    
    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"上传成功"];
    
    self.registerV.sandMyselfIDCard.placeholder = @"名片.png";
    
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    NSLog(@"%@",fullPath);
    
    [imageData writeToFile:fullPath atomically:NO];
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
