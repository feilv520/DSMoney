//
//  TWOCodeChangePhoneNumViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOCodeChangePhoneNumViewController.h"
#import "TWOImputNewPhoneNumViewController.h"

@interface TWOCodeChangePhoneNumViewController () <UITextFieldDelegate>

{
    UITextField *textFieldCode;
    UIButton *buttNext;
}

@end

@implementation TWOCodeChangePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"更换绑定手机号"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 56) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, viewBottom.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIImageView *imageSuo = [CreatView creatImageViewWithFrame:CGRectMake(22, 18, 20, 20) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"yanzhenma"]];
    [viewBottom addSubview:imageSuo];
    
    textFieldCode = [CreatView creatWithfFrame:CGRectMake(59, 13, WIDTH_CONTROLLER_DEFAULT - 42 - 30 , 30) setPlaceholder:@"请输入登录密码" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldCode];
    textFieldCode.delegate = self;
    textFieldCode.secureTextEntry = YES;
    textFieldCode.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    textFieldCode.textColor = [UIColor findZiTiColor];
    [textFieldCode addTarget:self action:@selector(buttonGrayTextField:) forControlEvents:UIControlEventEditingChanged];
    
    buttNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 56 + 15, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor findZiTiColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:buttNext];
    buttNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttNext.layer.cornerRadius = 5;
    buttNext.layer.masksToBounds = YES;
    [buttNext addTarget:self action:@selector(nextOneStepButton:) forControlEvents:UIControlEventTouchUpInside];
}

//按钮置灰
- (void)buttonGrayTextField:(UITextField *)textField
{
    if (textField.text.length == 0) {
        buttNext.backgroundColor = [UIColor findZiTiColor];
    } else {
        buttNext.backgroundColor = [UIColor profitColor];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location < 20) {
        return YES;
    } else {
        return NO;
    }
}

//下一步按钮
- (void)nextOneStepButton:(UIButton *)button
{
    if (textFieldCode.text.length == 0) {

    } else {
        [self.view endEditing:YES];
        [self getDataSecret];
    }
}

#pragma mark data-------------------------
- (void)getDataSecret
{
    NSDictionary *parermeter = @{@"password":textFieldCode.text, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"check/checkUserPwd" parameters:parermeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"登录密码更换手机号:------------%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            TWOImputNewPhoneNumViewController *imputNumVC = [[TWOImputNewPhoneNumViewController alloc] init];
            [self.navigationController pushViewController:imputNumVC animated:YES];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"登录密码更换手机号:------------%@", error);
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
