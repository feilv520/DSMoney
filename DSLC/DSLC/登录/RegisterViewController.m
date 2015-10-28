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

@interface RegisterViewController (){
    UILabel *lableRedLine;
    NSInteger buttonTag;
    RegisterOfView *registerV;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"注册大圣理财"];
    
    [self RegisterProcessPhoto];
    [self RegisterNav];
    [self RegisterMessage];
    [self RegisterSureButton];
}

// 注册流程图一
- (void)RegisterProcessPhoto{
    NSBundle *rootBundle = [NSBundle mainBundle];
    NSArray *rootArray = [rootBundle loadNibNamed:@"RegisterProcess" owner:nil options:nil];
    RegisterProcess *registerP = [rootArray lastObject];
    
    registerP.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 103);
    
    [self.view addSubview:registerP];
    
}

// 注册导航 (用户注册/理财师注册)
- (void)RegisterNav{
    
    UIView *buttonWithView = [[UIView alloc] initWithFrame:CGRectMake(0, 103, WIDTH_CONTROLLER_DEFAULT, 50)];
    
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
    registerV = [rootArray lastObject];
    
    registerV.frame = CGRectMake(0, 160, WIDTH_CONTROLLER_DEFAULT, 292);
    
    [self.view addSubview:registerV];
}

// 立即抢购
- (void)RegisterSureButton{
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 420, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [payButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:payButton];
    
}

- (void)sureButtonAction:(UIButton *)btn{
    [ProgressHUD showMessage:@"确认" Width:100 High:20];
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
