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

@interface RegisterViewController (){
    NSInteger number;
    NSInteger buttonTag;
    UIButton *payButton;
    UILabel *lableRedLine;
    UIView *buttonWithView;
    RegisterOfView *registerV;
    RegisterProcess *registerP;
    RegisterOfResult *registerR;
    RegisterOfPassButton *registerB;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"注册大圣理财"];
    
    number = 0;
    
    [self RegisterProcessPhoto];
    [self RegisterNav];
    [self RegisterMessage];
    [self RegisterSureButton];
    
}

// 注册流程图一
- (void)RegisterProcessPhoto{
    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArray = [rootBundle loadNibNamed:@"RegisterProcess" owner:nil options:nil];
    registerP = [rootArray lastObject];
    
    registerP.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 103);
    
    [self.view addSubview:registerP];
    
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
    [userRegister setTitleColor:Color_Red forState:UIControlStateNormal];
    
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
    
    [self.view addSubview:buttonWithView];
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

// 注册信息
- (void)RegisterMessage{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArray = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
    registerV = [rootArray firstObject];
    
    registerV.frame = CGRectMake(0, 160, WIDTH_CONTROLLER_DEFAULT, 292);
    
    [self.view addSubview:registerV];
}

// 立即抢购
- (void)RegisterSureButton{
    payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 420, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [payButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:payButton];
    
}

// 确认按钮执行方法 (第二步 : 实名验证)
- (void)sureButtonAction:(UIButton *)btn{
    
    [buttonWithView removeFromSuperview];
    [payButton removeFromSuperview];
    [registerV removeFromSuperview];
    registerV = nil;
    
    registerP.photoImageView.image = [UIImage imageNamed:@"register-2"];
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArrayOfView = [rootBundle loadNibNamed:@"RegisterOfView" owner:nil options:nil];
    NSArray *rootArrayOfResult = [rootBundle loadNibNamed:@"RegisterOfResult" owner:nil options:nil];
    NSArray *rootArrayOfPButton = [rootBundle loadNibNamed:@"RegisterOfPassButton" owner:nil options:nil];
    
    registerR = [rootArrayOfResult lastObject];
    
    registerR.frame = CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 65);
    
    registerV = [rootArrayOfView objectAtIndex:1];
    
    registerV.frame = CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 134);
    
    registerB = [rootArrayOfPButton lastObject];
    
    registerB.frame = CGRectMake(0, 320, WIDTH_CONTROLLER_DEFAULT, 100);
    
    [registerB.passButton addTarget:self action:@selector(passButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [registerB.sureButton addTarget:self action:@selector(sureButtonActionFinish:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerV];
    [self.view addSubview:registerR];
    [self.view addSubview:registerB];
    
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
    
    [self.view addSubview:registerV];
    [self.view addSubview:registerR];
    [self.view addSubview:registerB];
    
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
