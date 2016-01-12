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
#import "City.h"
#import "BankName.h"
#import "AddBankCell.h"
#import "ChooseOpenAnAccountBank.h"
#import "CanNotBindingBankCard.h"
#import "sys/utsname.h"

@interface RegisterViewController ()<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
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
    
    //绑定银行卡
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *textFieldArr;
    UIImageView *imageViewRight;
    UIImageView *imageRight;
    UIImageView *imageRightView;
    UIImageView *imageRightViewZ;
    UILabel *labelZBank;
    
    NSDictionary *dicRealName;
    
    UITextField *textFieldZero;
    UITextField *textFieldOne;
    UITextField *textFieldTwo;
    UITextField *textFieldThree;
    UITextField *textFieldFour;
    UITextField *textFieldFive;
    UITextField *textFieldSix;
    UITextField *textFieldSeven;
    
    City *city;
    City *cityS;
    BankName *bankName;
    NSString *bankZ;
    
    // 姓名
    NSString *ownerCardName;
    NSString *ownerCardNumber;
    NSString *ownerID;
    NSString *ownerBCard;
    NSString *ownerRegisterTime;
    NSString *ownerTelephoneNumber;
    
    // 绑定的银行卡Id
    NSString *bankCardId;
    // 交易记录Id
    NSString *tranId;
    NSString *tranCode;
}

@property (nonatomic) LLPaySdk *sdk;
@property (nonatomic) NSMutableDictionary *orderDic;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic, strong) RegisterOfView *registerV;

@property (nonatomic, assign) BOOL flag;

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dicRealName = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSLog(@"手机型号: %@",[self deviceVersion]);
    
    self.scrollView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 800);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnBankName:) name:@"bankR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnCityWithPName:) name:@"cityPR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnCityWithSName:) name:@"citySR" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnCityWithZName:) name:@"cityZR" object:nil];
    
}

- (void)returnBankName:(NSNotification *)notice
{
    bankName = [notice object];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldTwo.text = bankName.bankName;
    [_tableView reloadData];
}

- (void)returnCityWithPName:(NSNotification *)notice {
    city = [notice object];
    textFieldThree = (UITextField *)[self.view viewWithTag:403];
    textFieldThree.text = city.cityName;
}

- (void)returnCityWithSName:(NSNotification *)notice {
    cityS = [notice object];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFour.text = cityS.cityName;
}

- (void)returnCityWithZName:(NSNotification *)notice {
    bankZ = [notice object];
    textFieldFive = (UITextField *)[self.view viewWithTag:405];
    //    textFieldFive.font = [UIFont systemFontOfSize:10];
    textFieldFive.hidden = YES;
    //    textFieldFive.text = bankZ;
    labelZBank.text = bankZ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"注册大圣理财"];
    
    number = 0;
    
    userID = @"";
    
    seconds = 60;
    
    ownerCardNumber = @"220204199204180655";
    
    ownerCardName = @"马成铭";
    
    self.scrollView.contentSize = CGSizeMake(1, 900);
    
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
    
    registerP.frame = CGRectMake(0, 0, WIDTH_CVIEW_DEFAULT, (103 / 375.0) * HEIGHT_CONTROLLER_DEFAULT);
    
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
            
            self.registerV.phoneNumber.text = @"";
            self.registerV.smsCode.text = @"";
            self.registerV.loginPassword.text = @"";
            self.registerV.sureLoginPassword.text = @"";
            
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
            
            self.registerV.phoneNumber.text = @"";
            self.registerV.smsCode.text = @"";
            self.registerV.loginPassword.text = @"";
            self.registerV.sureLoginPassword.text = @"";
            
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
    
    self.registerV.frame = CGRectMake(0, 160, WIDTH_CVIEW_DEFAULT, 225);
    
//    [self showViewControllerContent];
    
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
    
    [self.view endEditing:YES];
    
    NSDictionary *parameter = @{@"userId":[NSString stringWithFormat:@"%@",ownerID],@"realName":self.registerV.realName.text,@"IDCardNum":self.registerV.IDCard.text};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/authRrealName" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            NSLog(@"%@",responseObject);
            
            
            
            ownerCardName = self.registerV.realName.text;
            ownerCardNumber = self.registerV.IDCard.text;
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [registerB removeFromSuperview];
            [self.registerV removeFromSuperview];
            registerB = nil;
            self.registerV = nil;
            
            registerP.photoImageView.image = [UIImage imageNamed:@"register-3"];
            
            NSBundle *rootBundle = [NSBundle mainBundle];
//            NSArray *rootArrayOfView = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
//                        NSArray *rootArrayOfResult = [rootBundle loadNibNamed:@"RegisterOfResult" owner:nil options:nil];
            
//                        registerR = [rootArrayOfResult lastObject];
            
            registerR.frame = CGRectMake(0, 95, WIDTH_CONTROLLER_DEFAULT, 65);
            
            registerR.titleSuccess.text = @"验证成功";
            registerR.passTitle.text = @"您可以绑定银行卡，也可以选择跳过．";
            
            [self.scrollView addSubview:registerR];
            
            [self showViewControllerContent];
            
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
            
            if (![self.registerV.sandMyselfIDCard.placeholder isEqualToString:@"名片.png"]){
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"理财师注册必须上传头像"];
                return;
            }
            
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
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
                    NSString *dataTime = [formatter stringFromDate:[NSDate date]];
                    
                    ownerID = [responseDic objectForKey:@"userId"];
                    ownerRegisterTime = dataTime;
                    ownerTelephoneNumber = self.registerV.phoneNumber.text;
                    
                    userID = [responseObject objectForKey:@"userId"];
                    
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
        
                    registerR.frame = CGRectMake(0, 103, WIDTH_CVIEW_DEFAULT, 65);
        
                    self.registerV = [rootArrayOfView objectAtIndex:1];
        
                    self.registerV.frame = CGRectMake(0, 180, WIDTH_CVIEW_DEFAULT, 90);
        
                    registerB = [rootArrayOfPButton lastObject];
        
                    registerB.frame = CGRectMake(0, 290, WIDTH_CVIEW_DEFAULT, 100);
        
                    [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    [registerB.sureButton addTarget:self action:@selector(sureButtonActionFinish:) forControlEvents:UIControlEventTouchUpInside];
        
                    [self.scrollView addSubview:self.registerV];
                    [self.scrollView addSubview:registerR];
                    [self.scrollView addSubview:registerB];
                    
                    // 跳过操作
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
//                    [self.navigationController popViewControllerAnimated:YES];
                    tapButton.hidden = YES;
                    bookButton.hidden = YES;
                    
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
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
                    NSString *dataTime = [formatter stringFromDate:[NSDate date]];
                    
                    ownerID = [responseObject objectForKey:@"userId"];
                    ownerTelephoneNumber = self.registerV.phoneNumber.text;
                    ownerRegisterTime = dataTime;
                    
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
        
                    registerR.frame = CGRectMake(0, 103, WIDTH_CVIEW_DEFAULT, 65);
        
                    self.registerV = [rootArrayOfView objectAtIndex:1];
        
                    self.registerV.frame = CGRectMake(0, 180, WIDTH_CVIEW_DEFAULT, 90);
        
                    registerB = [rootArrayOfPButton lastObject];
        
                    registerB.frame = CGRectMake(0, 290, WIDTH_CVIEW_DEFAULT, 100);
        
                    [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    [registerB.sureButton addTarget:self action:@selector(sureButtonActionFinish:) forControlEvents:UIControlEventTouchUpInside];
        
                    [self.scrollView addSubview:self.registerV];
                    [self.scrollView addSubview:registerR];
                    [self.scrollView addSubview:registerB];
                
//                     返回方法
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
//                    [self.navigationController popViewControllerAnimated:YES];
                    tapButton.hidden = YES;
                    bookButton.hidden = YES;
                    
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
    
    if (textField.tag == 401) {
        
        if (range.location < 19) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else if (textField.tag == 407) {
        
        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    }

    
    return YES;
}

// 风险提示书
- (void)bookButtonAction:(UIButton *)btn
{
    RiskAlertBookViewController *riskVC = [[RiskAlertBookViewController alloc] init];
    
    if (self.flag)
        riskVC.disign = @"registerOfP";
    else
        riskVC.disign = @"registerOfL";
    
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

#pragma mark 绑定银行卡
#pragma mark --------------------------------

- (void)showViewControllerContent
{

    titleArr = @[@"持卡人", @"银行卡号", @"开户行", @"开户行省",@"开户行市", @"开户行支行",  @"支付金额", @"手机号"];
    textFieldArr = @[ownerCardName, @"请输入本人银行卡号", @"请选择开户银行", @"请选择开户所在的省", @"请选择开户所在的市", @"请输入开户行支行", @"0.01元", @"请输入预留在银行的手机号"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, WIDTH_CVIEW_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.scrollView addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.scrollEnabled = NO;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CVIEW_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (90.0 / 667.0))];
    _tableView.tableFooterView = view;
    _tableView.backgroundColor = [UIColor huibai];
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    NSArray *rootArrayOfPButton = [rootBundle loadNibNamed:@"RegisterOfPassButton" owner:nil options:nil];
    
    registerB = [rootArrayOfPButton lastObject];
    
    registerB.frame = CGRectMake(0, 0, WIDTH_CVIEW_DEFAULT, 100);
    
    [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerB.sureButton addTarget:self action:@selector(boundCardNumber:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.tableFooterView = registerB;
    
    [_tableView registerNib:[UINib nibWithNibName:@"AddBankCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    imageViewRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    imageRightView = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    imageRightViewZ = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    
    labelZBank = [CreatView creatWithLabelFrame:CGRectMake(120, 10, WIDTH_CONTROLLER_DEFAULT * (230 / 375.0), 35) backgroundColor:Color_Clear textColor:Color_Black textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:14] text:nil];
    labelZBank.numberOfLines = 0;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        if (textField.tag == 402) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 404) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 405) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 150);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 407) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 150);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    } else {
        if (textField.tag == 407) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 150);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (bankName == nil) {
            return 5;
        } else if ([bankName.bankName isEqualToString:@"工商银行"] || [bankName.bankName isEqualToString:@"农业银行"] || [bankName.bankName isEqualToString:@"中国银行"] || [bankName.bankName isEqualToString:@"招商银行"] ||[bankName.bankName isEqualToString:@"光大银行"]) {
            return 5;
        } else {
            return 6;
        }
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10.0;
    }
    return 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
    
    cell.textField.font = [UIFont systemFontOfSize:14];
    cell.textField.tintColor = [UIColor yuanColor];
    cell.textField.delegate = self;
    
    if (indexPath.section == 1)
        cell.textField.tag = indexPath.row + 406;
    else
        cell.textField.tag = indexPath.row + 400;
    
    if (indexPath.section == 0) {
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.textField.text = [textFieldArr objectAtIndex:indexPath.row];
        } else {
            cell.textField.placeholder = [textFieldArr objectAtIndex:indexPath.row];
        }
    } else {
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row + 6];
        if (indexPath.row == 0) {
            cell.textField.text = @"0.01元";
        } else {
            cell.textField.placeholder = [textFieldArr objectAtIndex:indexPath.row + 6];
        }
    }
    
    if (cell.textField.tag == 405) {
        cell.textField.text = @"";
        cell.textField.placeholder = @"请输入开户行支行";
        //        cell.textField.userInteractionEnabled = YES;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
    }
    
    if (indexPath.row == 1 || indexPath.row == 4) {
        
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textField.userInteractionEnabled = NO;
        } else {
            cell.textField.text = @"";
            cell.textField.userInteractionEnabled = YES;
        }
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        
        if (indexPath.row == 3) {
            
            [cell addSubview:imageViewRight];
            cell.textField.enabled = NO;
        }
        
        if (indexPath.row == 2) {
            
            [cell addSubview:imageRight];
            cell.textField.enabled = NO;
        }
        
        if (indexPath.row == 4) {
            [cell addSubview:imageRightView];
            cell.textField.enabled = NO;
        }
        
        if (indexPath.row == 5) {
            [cell addSubview:imageRightViewZ];
            [cell addSubview:labelZBank];
            cell.textField.enabled = NO;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2 || indexPath.row == 3 ) {
        
        ChooseOpenAnAccountBank *chooseBank = [[ChooseOpenAnAccountBank alloc] init];
        if (indexPath.row == 2) {
            chooseBank.flagSelect = @"22";
        } else if (indexPath.row == 3) {
            chooseBank.flagSelect = @"33";
        }
        [self.navigationController pushViewController:chooseBank animated:YES];
    } else if (indexPath.row == 4) {
        if (city == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请先选择开户行省"];
            return;
        }
        ChooseOpenAnAccountBank *chooseBank = [[ChooseOpenAnAccountBank alloc] init];
        chooseBank.flagSelect = @"44";
        chooseBank.cityCode = city.cityCode;
        
        [self.navigationController pushViewController:chooseBank animated:YES];
    } else if (indexPath.row == 5) {
        if (city == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请先选择开户行省和市"];
            return;
        }
        ChooseOpenAnAccountBank *chooseBank = [[ChooseOpenAnAccountBank alloc] init];
        chooseBank.flagSelect = @"55";
        chooseBank.cityCode = city.cityCode;
        chooseBank.pCode = cityS.cityCode;
        chooseBank.bankCode = bankName.bankCode;
        chooseBank.cityName = city.cityName;
        [self.navigationController pushViewController:chooseBank animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 100) {
        
        [self.view endEditing:YES];
    }
}

//绑定银行卡
- (void)getBankCard
{
    textFieldZero = (UITextField *)[self.view viewWithTag:400];
    textFieldOne = (UITextField *)[self.view viewWithTag:401];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldThree = (UITextField *)[self.view viewWithTag:403];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFive = (UITextField *)[self.view viewWithTag:405];
    textFieldSix = (UITextField *)[self.view viewWithTag:406];
    textFieldSeven = (UITextField *)[self.view viewWithTag:407];
    
    NSLog(@"textFieldFive = %@",textFieldFive.text);
    
    NSDictionary *parmeter;
    if (textFieldFive == nil || [textFieldFive.text isEqualToString:@""]) {
        parmeter = @{@"userId":userID, @"cardName":textFieldTwo.text, @"cardAccount":textFieldOne.text, @"proviceCode":city.cityCode, @"cityCode":cityS.cityCode, @"bankCode":bankName.bankCode, @"phone":textFieldSeven.text, @"bankBranch":@"", @"checkKey":@"ckAixn8sFNhwmmCvkRgjuA=="};
    } else {
        parmeter = @{@"userId":userID, @"cardName":textFieldTwo.text, @"cardAccount":textFieldOne.text, @"proviceCode":city.cityCode, @"cityCode":cityS.cityCode, @"bankCode":bankName.bankCode, @"phone":textFieldSeven.text, @"bankBranch":bankZ, @"checkKey":@"ckAixn8sFNhwmmCvkRgjuA=="};
    }
    
    NSLog(@"parmeter == %@",parmeter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/addBankCard" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"7777777绑定银行卡:%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"绑卡成功"];
            
            bankCardId = [responseObject objectForKey:@"bankCardId"];
            tranId = [responseObject objectForKey:@"tranId"];
            tranCode = [responseObject objectForKey:@"tranCode"];

            self.orderDic = [self createOrder];
            
            [self pay:nil];
            
        } else {
            CanNotBindingBankCard *canNot = [[CanNotBindingBankCard alloc] init];
            [self.navigationController pushViewController:canNot animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
}

#pragma mark 连连支付按钮
#pragma mark --------------------------------

- (void)boundCardNumber:(id)sender{
    [self getBankCard];
}

#pragma mark - 订单支付
- (void)pay:(id)sender{
    
    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    // 进行签名
    NSDictionary *signedOrder = [payUtil signedOrderDic:self.orderDic
                                             andSignKey:kLLPartnerKey];
    NSLog(@"self.orderDic = %@",self.orderDic);
    
//        [LLPaySdk sharedSdk].sdkDelegate = self;
    
    // TODO: 根据需要使用特定支付方式
    
    // 快捷支付
//            [[LLPaySdk sharedSdk] presentQuickPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 认证支付
    //    [[LLPaySdk sharedSdk] presentVerifyPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 预授权
    //  [self.sdk presentPreAuthPaySdkInViewController:self withTraderInfo:signedOrder];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    self.sdk = [[LLPaySdk alloc] init];
    self.sdk.sdkDelegate = self;
    [self.sdk presentVerifyPaySdkInViewController:app.tabBarVC withTraderInfo:signedOrder];
//    [self.sdk presentPaySdkInViewController:app.tabBarVC withTraderInfo:signedOrder];
}



#pragma -mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
// TODO: 开发人员需要根据实际业务调整逻辑
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            msg = @"支付成功";
            
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"])
            {
                //
                //NSString *payBackAgreeNo = dic[@"agreementno"];
                // TODO: 协议号
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"绑卡成功,请登录"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else if ([result_pay isEqualToString:@"PROCESSING"])
            {
                msg = @"支付单处理中";
            }
            else if ([result_pay isEqualToString:@"FAILURE"])
            {
                msg = @"支付单失败";
            }
            else if ([result_pay isEqualToString:@"REFUND"])
            {
                msg = @"支付单已退款";
            }
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            msg = dic[@"ret_msg"];
        }
            break;
        default:
            break;
    }
}

- (NSMutableDictionary *)createOrder{
    
    NSString *partnerPrefix = @"GCCT"; // TODO: 修改成自己公司前缀
    
    NSString *signType = @"MD5";    // MD5 || RSA || HMAC
    
    NSString *user_id = [NSString stringWithFormat:@"%@",ownerID]; //
    // user_id，一个user_id标示一个用户
    // user_id为必传项，需要关联商户里的用户编号，一个user_id下的所有支付银行卡，身份证必须相同
    // demo中需要开发测试自己填入user_id, 可以先用自己的手机号作为标示，正式上线请使用商户内的用户编号
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    textFieldOne = (UITextField *)[self.view viewWithTag:401];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    
    NSString *risk_item = [NSString stringWithFormat:@"{\"frms_ware_category\":\"2009\",\"user_info_mercht_userno\":\"%@\",\"user_info_bind_phone\":\"%@\",\"user_info_dt_register\":\"%@\",\"user_info_full_name\":\"%@\",\"user_info_id_type\":\"0\",\"user_info_id_no\":\"%@\",\"user_info_identify_state\":\"1\",\"user_info_identify_type\":\"4\"}",
                           user_id,
                           textFieldOne.text,
                           @"20151227163421",
                           ownerCardName,
                           ownerCardNumber];
    
    NSString *noString = [NSString stringWithFormat:@"http://www.dslc.cn/payReturn.do?tranId=%@&userId=%@&bankCardId=%@",tranId,user_id,bankCardId];
    NSLog(@"http:// = %@",noString);
    
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    [param setDictionary:@{
                           @"sign_type":signType,
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
                           @"busi_partner":@"101001",
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
                           @"dt_order":simOrder,
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           //                           @"money_order":@"0.10",
                           //交易金额	money_order	是	Number(8,2)	该笔订单的资金总额，单位为RMB-元。大于0的数字，精确到小数点后两位。 如：49.65
                           @"money_order" : @"0.01",
                           
                           @"no_order":tranCode,
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
                           @"name_goods":@"订单名",
                           //商品名称	name_goods	否	String(40)
                           @"info_order":simOrder,
                           //订单附加信息	info_order	否	String(255)	商户订单的备注信息
                           @"valid_order":@"10080",
                           //分钟为单位，默认为10080分钟（7天），从创建时间开始，过了此订单有效时间此笔订单就会被设置为失败状态不能再重新进行支付。
                           //                           @"shareing_data":@"201412030000035903^101001^10^分账说明1|201310102000003524^101001^11^分账说明2|201307232000003510^109001^12^分账说明3"
                           // 分账信息数据 shareing_data  否 变(1024)
                           
                           @"notify_url":noString,
                           //服务器异步通知地址	notify_url	是	String(64)	连连钱包支付平台在用户支付成功后通知商户服务端的地址，如：http://payhttp.xiaofubao.com/back.shtml
                           
                           
                           //                           @"risk_item":@"{\"user_info_bind_phone\":\"13958069593\",\"user_info_dt_register\":\"20131030122130\"}",
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                           @"risk_item" : risk_item,
                           
                           @"user_id": user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           
                           
                           //                           @"flag_modify":@"1",
                           //修改标记 flag_modify 否 String 0-可以修改，默认为0, 1-不允许修改 与id_type,id_no,acct_name配合使用，如果该用户在商户系统已经实名认证过了，则在绑定银行卡的输入信息不能修改，否则可以修改
                           
                           @"card_no":textFieldOne.text,
                           //银行卡号 card_no 否 银行卡号前置，卡号可以在商户的页面输入
                           
                           //                           @"no_agree":@"2014070900123076",
                           //签约协议号 否 String(16) 已经记录快捷银行卡的用户，商户在调用的时候可以与pay_type一块配合使用
                           }];
    
    BOOL isIsVerifyPay = YES;
    
    if (isIsVerifyPay) {
        
        [param addEntriesFromDictionary:@{
                                          @"id_no":ownerCardNumber,
                                          //证件号码 id_no 否 String
                                          @"acct_name":ownerCardName,
                                          //银行账号姓名 acct_name 否 String
                                          }];
    }
    
    
    param[@"oid_partner"] = kLLOidPartner;
    
    
    return param;
}

- (void)buttonPressOK:(UIButton *)button
{
    NSLog(@"获取验证码");
    [self.view endEditing:YES];
    
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    
    if (textFieldFour.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:textFieldFour.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入手机格式有误"];
        
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameters = @{@"phone":textFieldFour.text,@"msgType":@"4"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                
            } else {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 401) {
        NSLog(@"401 = %@",textField.text);
        ownerBCard = textField.text;
    }
}

- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //CLog(@"%@",deviceString);
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    //CLog(@"NOTE: Unknown device type: %@", deviceString);
    
    return deviceString;
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
