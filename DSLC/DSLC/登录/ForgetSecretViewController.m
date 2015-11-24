//
//  ForgetSecretViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ForgetSecretViewController.h"
#import "ForgetSecretCell.h"
#import "ForgetSecret2Cell.h"

@interface ForgetSecretViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    UITextField *textFieldPhoneNum;
    NSArray *titleArr;
    NSArray *textFieldArr;
    UIButton *butEnsure;
    UITextField *textField0;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    
    NSInteger seconds;
    
    NSTimer *timer;
}

@end

@implementation ForgetSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    seconds = 120;
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"找回登录密码"];
    
    [self tableViewShowTime];
    
}
//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableViewShowTime
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 200) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.scrollEnabled = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"ForgetSecretCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"ForgetSecret2Cell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    
    titleArr = @[@"设置新登录密码", @"确认新登录密码"];
    textFieldArr = @[@"请输入新登录密码", @"请再次输入新登录密码"];
    
    textFieldPhoneNum = [CreatView creatWithfFrame:CGRectMake(130, 10, WIDTH_CONTROLLER_DEFAULT - 130 - 10, 30) setPlaceholder:nil setTintColor:[UIColor grayColor]];
    textFieldPhoneNum.placeholder = @"请输入手机号";
    textFieldPhoneNum.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldPhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    
    butEnsure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 260, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:butEnsure];
    [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butEnsure addTarget:self action:@selector(ensureButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        ForgetSecret2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        
        cell.labelTitle.text = @"验证码";
        cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.placeholder = @"请输入验证码";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.tag = 5000;
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textField addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
        
        [cell.butGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.butGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.butGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.butGet.tag = 9080;
        cell.butGet.layer.cornerRadius = 3;
        cell.butGet.layer.masksToBounds = YES;
        cell.butGet.layer.borderWidth = 0.5;
        cell.butGet.layer.borderColor = [[UIColor daohanglan] CGColor];
        [cell.butGet addTarget:self action:@selector(getCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        ForgetSecretCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        if (indexPath.row == 0) {
            
            cell.labelTitle.text = @"手机号";
            cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            cell.textField.hidden = YES;
            [cell addSubview:textFieldPhoneNum];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            textFieldPhoneNum.tag = 1000;
            textFieldPhoneNum.delegate = self;
            
        } else {
            
            cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row - 2];
            cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            
            cell.textField.placeholder = [textFieldArr objectAtIndex:indexPath.row - 2];
            cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            cell.textField.tintColor = [UIColor grayColor];
            cell.textField.tag = 900 + indexPath.row;
            if (indexPath.row == 2 || indexPath.row == 3) {
                cell.textField.secureTextEntry = YES;
            }
            cell.textField.delegate = self;
            [cell.textField addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
        }
        
        if (indexPath.row == 3) {
            
            cell.labelLine.backgroundColor = [UIColor grayColor];
            cell.labelLine.alpha = 0.2;
            
        } else {
            
            cell.labelLine.hidden = YES;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)textFieldEditing:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:5000];
    textField2 = (UITextField *)[self.view viewWithTag:902];
    textField3 = (UITextField *)[self.view viewWithTag:903];
    
    if (![NSString validateMobile:textFieldPhoneNum.text]) {

        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];

    } else if (textField1.text.length < 6) {

        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textField2.text.length <6) {

        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textField3.text.length < 6) {

        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (![textField2.text isEqualToString:textField3.text]) {

        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1000) {
        
        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else if (textField.tag == 5000) {
        
        if (range.location == 6) {
            
            return NO;
            
        } else {
            
            return YES;
            
        }
        
    } else if (textField.tag == 902) {
        
        if (range.location <= 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else {
        
        if (range.location <= 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
    }
}

//获取验证码
- (void)getCodeButtonAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    
    textFieldPhoneNum = (UITextField *)[self.view viewWithTag:1000];
    
    if (textFieldPhoneNum.text.length == 0) {
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
        
    } else if (![NSString validateMobile:textFieldPhoneNum.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameters = @{@"phone":textFieldPhoneNum.text,@"msgType":@"3"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

//确定按钮
- (void)ensureButton:(UIButton *)button
{
    [self.view endEditing:YES];
    
    textField1 = (UITextField *)[self.view viewWithTag:5000];
    textField2 = (UITextField *)[self.view viewWithTag:902];
    textField3 = (UITextField *)[self.view viewWithTag:903];
    
    if (textFieldPhoneNum.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入信息"];
    } else if (![NSString validateMobile:textFieldPhoneNum.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
    } else if (textField1.text.length < 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
    } else if (textField2.text.length <6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位字符，至少包含字母和数字两种"];
    } else if (textField3.text.length < 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位字符，至少包含字母和数字两种"];
    } else if (![textField2.text isEqualToString:textField3.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
    } else {        
        NSDictionary *parameter = @{@"phone":textFieldPhoneNum.text,@"smsCode":textField1.text,@"password":textField2.text,@"msgType":@"3"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/findPwd" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
                NSArray *array = self.navigationController.viewControllers;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
                [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
            } else {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 验证码倒计时
#pragma mark --------------------------------

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:9080];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 120;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor daohanglan].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        [button setTitle:@"获取验证码" forState: UIControlStateNormal];
        [button setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        [button setEnabled:YES];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"重新发送(%lds)",seconds];
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
                seconds = 120;
            }
        }
    }
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
