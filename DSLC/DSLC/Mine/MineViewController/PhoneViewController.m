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
}

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"身份验证"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewTop = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewTop];

    UILabel *labelLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [self.view addSubview:labelLine1];
    [self labelLineShow:labelLine1];
    
    UILabel *labelNew = [CreatView creatWithLabelFrame:CGRectMake(10, 0.5, 60, 49.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[NSString stringWithFormat:@"%@", @"原手机号"]];
    
    textFieldPhoneNumber = [CreatView creatWithfFrame:CGRectMake(CGRectGetMaxX(labelNew.frame)+ 10, 1, WIDTH_CONTROLLER_DEFAULT - 100, 49.5) setPlaceholder:@"请输入原来的手机号" setTintColor:[UIColor grayColor]];
    textFieldPhoneNumber.font = [UIFont systemFontOfSize:15];
    textFieldPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    [textFieldPhoneNumber addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [textFieldPhoneNumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [viewTop addSubview:textFieldPhoneNumber];
    [viewTop addSubview:labelNew];
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 50)backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    UILabel *labelVerify = [CreatView creatWithLabelFrame:CGRectMake(10, 0.5, 50, 49.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"验证码"];
    [viewDown addSubview:labelVerify];
    
    textFieldSmsCode = [CreatView creatWithfFrame:CGRectMake(CGRectGetMaxX(labelNew.frame)+ 10, 10, 180, 30) setPlaceholder:@"请输入验证码" setTintColor:[UIColor grayColor]];
    [viewDown addSubview:textFieldSmsCode];
    textFieldSmsCode.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [textFieldSmsCode addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    [textFieldSmsCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *butGet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 100, 10, 90, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"获取验证码"];
    [viewDown addSubview:butGet];
    butGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butGet.layer.cornerRadius = 4;
    butGet.layer.masksToBounds = YES;
    butGet.layer.borderWidth = 0.5;
    butGet.layer.borderColor = [[UIColor daohanglan] CGColor];
    [butGet addTarget:self action:@selector(getNumButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [viewDown addSubview:labelLine2];
    [self labelLineShow:labelLine2];
    
    UILabel *labelLine3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [viewDown addSubview:labelLine3];
    [self labelLineShow:labelLine3];
    
    butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT * (170.0 / 667.0), WIDTH_CONTROLLER_DEFAULT - 80, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:butNext];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butNext addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];

}

//获取验证码
- (void)getNumButton:(UIButton *)button
{
    NSDictionary *parameter = @{@"phone":@"13354288036"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        NSLog(@"ooooooo%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"fffffffff%@", error);
        
    }];
}

#pragma mark textField delegate
#pragma mark --------------------------------

- (void)textFieldEdit:(UITextField *)textField
{
    if ([textFieldSmsCode.text length] > 0 && [textFieldPhoneNumber.text length] > 0) {
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == textFieldSmsCode) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    } else if (textField == textFieldPhoneNumber) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

//下一步按钮
- (void)nextButton:(UIButton *)button
{
    if ([textFieldSmsCode.text length] > 0 && [textFieldPhoneNumber.text length] > 0) {
        
        NSDictionary *parameter = @{@"smsCode":textFieldSmsCode.text};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/checkSmsCode" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            NSLog(@"ooooooo%@", responseObject);
            if ([[responseObject objectForKey:@"result"] isEqualToString:@"200"]) {
                
//                ChangeNumViewController *changeNumVC = [[ChangeNumViewController alloc] init];
//                [self.navigationController pushViewController:changeNumVC animated:YES];
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"fffffffff%@", error);
            
        }];
        ChangeNumViewController *changeNumVC = [[ChangeNumViewController alloc] init];
        [self.navigationController pushViewController:changeNumVC animated:YES];
    } else {
        
    }
}

//获取验证码按钮
- (void)getValidationNum:(UIButton *)button
{
    NSLog(@"获取验证码");
}

- (void)labelLineShow:(UILabel *)label
{
    label.backgroundColor = [UIColor grayColor];
    label.alpha = 0.2;
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
