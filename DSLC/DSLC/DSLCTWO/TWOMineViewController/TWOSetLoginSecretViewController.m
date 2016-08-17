//
//  TWOSetLoginSecretViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOSetLoginSecretViewController.h"
#import "TWOChangeLoginFinishViewController.h"

@interface TWOSetLoginSecretViewController ()

{
    UIButton *buttonMake;
    UITextField *textFieldEmail;
}

@end

@implementation TWOSetLoginSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"设置登录密码"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 56) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 56, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIImageView *imageSign = [CreatView creatImageViewWithFrame:CGRectMake(21, 17, 22, 22) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"yanzhenma"]];
    [viewBottom addSubview:imageSign];
    
    textFieldEmail = [CreatView creatWithfFrame:CGRectMake(59, 10, WIDTH_CONTROLLER_DEFAULT - 59 - 40, 36) setPlaceholder:@"请输入登录密码" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldEmail];
    textFieldEmail.delegate = self;
    textFieldEmail.textColor = [UIColor ZiTiColor];
    textFieldEmail.secureTextEntry = YES;
    textFieldEmail.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [textFieldEmail addTarget:self action:@selector(makeSureChangeGray:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *buttonEye = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 30, 17, 22, 22) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [viewBottom addSubview:buttonEye];
    buttonEye.tag = 330;
    [buttonEye setBackgroundImage:[UIImage imageNamed:@"setbiyan"] forState:UIControlStateNormal];
    [buttonEye setBackgroundImage:[UIImage imageNamed:@"setbiyan"] forState:UIControlStateHighlighted];
    [buttonEye addTarget:self action:@selector(buttonCloseEyesOrOpen:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(20, 60, WIDTH_CONTROLLER_DEFAULT - 40, 30) backgroundColor:[UIColor qianhuise] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"登录密码由6-20位数字和字母组成,以字母开头"];
    [self.view addSubview:labelAlert];
    
    buttonMake = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 60 + labelAlert.frame.size.height + 4, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor findZiTiColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:buttonMake];
    buttonMake.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonMake.layer.cornerRadius = 5;
    buttonMake.layer.masksToBounds = YES;
    [buttonMake addTarget:self action:@selector(buttonMakeLoginSecret:) forControlEvents:UIControlEventTouchUpInside];
}

//睁眼闭眼按钮
- (void)buttonCloseEyesOrOpen:(UIButton *)button
{
    if (button.tag == 330) {
        textFieldEmail.secureTextEntry = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateHighlighted];
        button.tag = 440;
    } else {
        textFieldEmail.secureTextEntry = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"setbiyan"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"setbiyan"] forState:UIControlStateHighlighted];
        button.tag = 330;
    }
}

//按钮置灰
- (void)makeSureChangeGray:(UITextField *)textField
{
    if (textField.text.length == 0) {
        buttonMake.backgroundColor = [UIColor findZiTiColor];
    } else {
        buttonMake.backgroundColor = [UIColor profitColor];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 19) {
        return NO;
    } else {
        return YES;
    }
}

//确定按钮
- (void)buttonMakeLoginSecret:(UIButton *)button
{
    if (textFieldEmail.text.length == 0) {
        
    } else if (![NSString validatePassword:textFieldEmail.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"登录密码由6-20位数字和密码组成，以字母开头"];
    } else {
        [self setSecretData];
    }
}

//设置登录密码接口
#pragma mark setData=============================
- (void)setSecretData
{
    NSDictionary *parmeter = @{@"newPwd":textFieldEmail.text, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"pwd/updateUserLoginPwd" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"设置登录密码:::::::::::::%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            TWOChangeLoginFinishViewController *loginFinish = [[TWOChangeLoginFinishViewController alloc] init];
            loginFinish.state = YES;
            pushVC(loginFinish);
            
            // 刷新任务中心列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"taskListFuction" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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
