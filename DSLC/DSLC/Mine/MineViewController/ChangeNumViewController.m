//
//  ChangeNumViewController.m
//  DSLC
//
//  Created by ios on 15/10/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ChangeNumViewController.h"

@interface ChangeNumViewController () <UITextFieldDelegate>

{
    UITextField *_textField1;
    UITextField *_textField2;
    UIButton *butMakeSure;
}

@end

@implementation ChangeNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"更换手机号"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewTop = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewTop];
    
    UILabel *labelLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [self.view addSubview:labelLine1];
    [self labelLineShow:labelLine1];
    
    UILabel *labelNew = [CreatView creatWithLabelFrame:CGRectMake(10, 0.5, 65, 49.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"新手机号"];
    [viewTop addSubview:labelNew];
    
    _textField1 = [CreatView creatWithfFrame:CGRectMake(85, 10, WIDTH_CONTROLLER_DEFAULT - 95, 30) setPlaceholder:@"请输入新手机号" setTintColor:[UIColor grayColor]];
    [viewTop addSubview:_textField1];
    _textField1.delegate = self;
    _textField1.tag = 309;
    _textField1.keyboardType = UIKeyboardTypeNumberPad;
    _textField1.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [_textField1 addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 50)backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    UILabel *labelVerify = [CreatView creatWithLabelFrame:CGRectMake(10, 0.5, 65, 49.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"验证码"];
    [viewDown addSubview:labelVerify];
    
    _textField2 = [CreatView creatWithfFrame:CGRectMake(85, 10, 150, 30) setPlaceholder:@"请输入验证码" setTintColor:[UIColor grayColor]];
    [viewDown addSubview:_textField2];
    _textField2.delegate = self;
    _textField2.tag = 308;
    _textField2.keyboardType = UIKeyboardTypeNumberPad;
    _textField2.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [_textField2 addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
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
    
    butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT * (170.0 / 667.0), WIDTH_CONTROLLER_DEFAULT - 80, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:butMakeSure];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butMakeSure addTarget:self action:@selector(makeSureButtonLast:) forControlEvents:UIControlEventTouchUpInside];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (textField.tag == 308) {
//        
//        if (range.location == 11) {
//            
//            return NO;
//            
//        } else {
//            
//            return YES;
//            
//        }
//        
//    } else {
//        
//        if (range.location == 6) {
//            
//            return NO;
//            
//        } else {
//            
//            return YES;
//        }
//    }
//}

- (void)textFieldEdit:(UITextField *)textField
{
    if ([_textField1.text length] == 11 && [_textField2.text length] == 6) {
        
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//获取验证码
- (void)getNumButton:(UIButton *)button
{
    NSDictionary *parameter = @{@"phone":@"15940942599"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        NSLog(@"ooooooo%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"fffffffff%@", error);
        
    }];
}

//确定按钮
- (void)makeSureButtonLast:(UIButton *)button
{
    if ([_textField1.text length] == 11 && [_textField2.text length] == 6) {
        
        NSDictionary *parameter = @{@"phone":_textField1.text,@"smsCode":_textField2.text};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateUserPhone" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"更换手机号成功"];
            NSLog(@"ooooooo%@", responseObject);
            NSArray *viewControllers = [self.navigationController viewControllers];
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                [self.navigationController popToViewController:[viewControllers objectAtIndex:1] animated:YES];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"fffffffff%@", error);
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"网络不给力啦!"];
            
        }];
        
    } else {
        
    }
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
