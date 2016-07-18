//
//  TWOForgetSecretViewController.m
//  DSLC
//
//  Created by ios on 16/5/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOForgetSecretViewController.h"
#import "define.h"
#import "AppDelegate.h"
#import "TWOForgetSecretERViewController.h"

@interface TWOForgetSecretViewController () <UITextFieldDelegate>

{
    UITextField *textFieldSecret;
}

@end

@implementation TWOForgetSecretViewController

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
    [butCancle addTarget:self action:@selector(buttonReturnCancleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 54, 30, 108, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"找回登录密码"];
    [self.view addSubview:labelTitle];
    
    UIImageView *imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, self.view.frame.size.height/2 - 70, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageBigPic addSubview:imageTwo];
    imageTwo.userInteractionEnabled = YES;
    
    UIImageView *imageSecret = [CreatView creatImageViewWithFrame:CGRectMake(22, 10, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"loginSecret"]];
    [imageTwo addSubview:imageSecret];
    
    UIView *viewLine2 = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageTwo addSubview:viewLine2];
    
//    输入密码
    textFieldSecret = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10 - 40, 20) setPlaceholder:@"请输入新的登录密码" setTintColor:[UIColor whiteColor]];
    [imageTwo addSubview:textFieldSecret];
    textFieldSecret.textColor = [UIColor whiteColor];
    textFieldSecret.secureTextEntry = YES;
    textFieldSecret.delegate = self;
    textFieldSecret.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [textFieldSecret setValue:[UIColor colorFromHexCode:@"9db2c7"] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldSecret setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
//    眼睛按钮
    UIButton *butEyes = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(imageTwo.frame.size.width - 40, 10, 20, 20) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageTwo addSubview:butEyes];
    butEyes.tag = 777;
    [butEyes setBackgroundImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
    [butEyes setBackgroundImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateHighlighted];
    [butEyes addTarget:self action:@selector(buttonOpenEyesClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    下一步按钮
    UIButton *butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, self.view.frame.size.height/2 - 70 + 40 + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:nil titleText:@"下一步"];
    [imageBigPic addSubview:butNext];
    butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butNext setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
    [butNext addTarget:self action:@selector(nextOneStepButton:) forControlEvents:UIControlEventTouchUpInside];
}

//眼睛按钮
- (void)buttonOpenEyesClicked:(UIButton *)button
{
    if (button.tag == 777) {
        [button setBackgroundImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateHighlighted];
        textFieldSecret.secureTextEntry = NO;
        button.tag = 888;
    } else {
        [button setBackgroundImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateHighlighted];
        textFieldSecret.secureTextEntry = YES;
        button.tag = 777;
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

//下一步按钮
- (void)nextOneStepButton:(UIButton *)button
{
    if (textFieldSecret.text.length == 0) {
        [ProgressHUD showMessage:@"请输入新的登录密码" Width:100 High:20];
    } else if (![NSString validatePassword:textFieldSecret.text]) {
        [ProgressHUD showMessage:@"登录密码由6-20位数字和密码组成，以字母开头" Width:100 High:20];
    } else {
        [self getFindSecretCode];
    }
}

#pragma mark data======================
- (void)getFindSecretCode
{
    NSDictionary *parmeter = @{@"phone":self.phoneNum, @"password":textFieldSecret.text};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"pwd/findPwd" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"找回登录密码最后一步++++++++++%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self.view endEditing:YES];
            [ProgressHUD showMessage:@"找回密码成功" Width:100 High:20];
            NSArray *viewControllers = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[viewControllers objectAtIndex:0] animated:YES];
            
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//左上角x按钮
- (void)buttonReturnCancleClicked:(UIButton *)button
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
