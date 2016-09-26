//
//  TWORegisterViewController.m
//  DSLC
//
//  Created by ios on 16/5/19.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWORegisterViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "TWOReceiveNumViewController.h"

@interface TWORegisterViewController () <UITextFieldDelegate, UIScrollViewDelegate>
{
    //手机号textField
    UITextField *textFieldPhone;
    UIScrollView *_scrollview;
}
@end

@implementation TWORegisterViewController

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
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    [self.view addSubview:_scrollview];
    _scrollview.delegate = self;
    
    UIImageView *imageBigPic = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"bigpicture"]];
    [_scrollview addSubview:imageBigPic];
    imageBigPic.userInteractionEnabled = YES;
    
//    左上角x按钮
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 30, 25, 25) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBigPic addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"logincuo"] forState:UIControlStateHighlighted];
    [butCancle addTarget:self action:@selector(CancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    输入手机号框
    UIImageView *imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, 160.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageBigPic addSubview:imageTwo];
    imageTwo.userInteractionEnabled = YES;
    
//    手机图标
    UIImageView *imagePhone = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"phoneNumber"]];
    [imageTwo addSubview:imagePhone];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageTwo addSubview:viewLine];
    
//    输入手机号
    textFieldPhone = [CreatView creatWithfFrame:CGRectMake(22 + 22 + 10 + 10, 10, imageTwo.frame.size.width - 64 - 10, 20) setPlaceholder:@"手机号" setTintColor:[UIColor whiteColor]];
    [imageTwo addSubview:textFieldPhone];
    textFieldPhone.textColor = [UIColor whiteColor];
    textFieldPhone.delegate = self;
    textFieldPhone.tag = 1000;
    textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldPhone setValue:[UIColor colorFromHexCode:@"9db2c7"] forKeyPath:@"_placeholderLabel.textColor"];
    [textFieldPhone setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    UIButton *butLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30, 160.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40*2 + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 60, 40) backgroundColor:[UIColor clearColor] textColor:nil titleText:@"验证手机号"];
    [imageBigPic addSubview:butLogin];
    butLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateHighlighted];
    [butLogin addTarget:self action:@selector(buttonCheckPhoneNum:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butRightLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 140)/2, 170.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40*2 + 40.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 40 + 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 140, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"已有账号,立即登录"];
    [imageBigPic addSubview:butRightLogin];
    butRightLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butRightLogin addTarget:self action:@selector(haveNumberRightNowLogin:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(0, 100);
        } completion:^(BOOL finished) {
            
        }];
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(0, 110);
        } completion:^(BOOL finished) {
            
        }];
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(0, 120);
        } completion:^(BOOL finished) {
            
        }];
    }
}

//已有账号,立即登录按钮
- (void)haveNumberRightNowLogin:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

//验证手机号按钮
- (void)buttonCheckPhoneNum:(UIButton *)button
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollview.contentOffset = CGPointMake(0, -20);
    } completion:^(BOOL finished) {
        
    }];
    if (textFieldPhone.text.length == 0) {
        [ProgressHUD showMessage:@"电话号码不能为空" Width:100 High:20];
    } else if (![NSString validateMobile:textFieldPhone.text]) {
        [ProgressHUD showMessage:@"请输入正确的电话号码" Width:100 High:20];
    } else {
        [self checkPhone];
    }
}

//左上角x按钮
- (void)CancleButtonClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollview.contentOffset = CGPointMake(0, -20);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 加限制
#pragma mark --------------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1000) {
        
        if (range.location < 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else {
        return YES;
    }
}

#pragma mark 对接接口
#pragma mark --------------------------------

- (void)checkPhone{
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"check/checkPhone" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"验证手机号 = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@302]){
            
//            TWOReceiveNumViewController *receiveNum = [[TWOReceiveNumViewController alloc] init];
//            receiveNum.phoneString = textFieldPhone.text;
//            [self.navigationController pushViewController:receiveNum animated:YES];
            [self sendToMessage];
            
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)sendToMessage
{
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text,@"msgType":@"1"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/getSmsCode" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getSmsCode = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]){
            TWOReceiveNumViewController *receiveNum = [[TWOReceiveNumViewController alloc] init];
            receiveNum.phoneString = textFieldPhone.text;
            [self.navigationController pushViewController:receiveNum animated:YES];
            
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:@301]) {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];

        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
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
