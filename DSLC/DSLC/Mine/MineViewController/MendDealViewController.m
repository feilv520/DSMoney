//
//  MendDealViewController.m
//  DSLC
//
//  Created by ios on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MendDealViewController.h"
#import "MendDealCell.h"
#import "MendDeal2Cell.h"
#import "FindDealViewController.h"

@interface MendDealViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *nameArray;
    NSArray *textArray;
    UIButton *buttonMake;
    
    UITextField *textLast;
    UITextField *textNew;
    UITextField *textMakeSure;
    UITextField *textPhone;
    UITextField *textNum;
    
    NSInteger seconds;
    NSTimer *timer;
}

@end

@implementation MendDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"修改交易密码"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"找回" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarPress:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    seconds = 120;
    [self tableViewShow];
}

- (void)rightBarPress:(UIBarButtonItem *)bar
{
    FindDealViewController *findDealVC = [[FindDealViewController alloc] init];
    [self.navigationController pushViewController:findDealVC animated:YES];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 250) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor huibai];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDeal2Cell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    nameArray = @[@"原交易密码", @"新交易密码", @"确认新交易密码", @"您的手机号", @"验证码"];
    textArray = @[@"请输入原交易密码", @"请输入新交易密码", @"请再次输入新交易密码", @"请输入手机号", @""];
    
    buttonMake = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 310, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:buttonMake];
    buttonMake.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonMake addTarget:self action:@selector(makeSureButtonMendDeal:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        
        MendDeal2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.labelLeft.text = @"验证码";
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.placeholder = @"请输入验证码";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.tag = 704;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.delegate = self;
        [cell.textField addTarget:self action:@selector(mendDealTextField:) forControlEvents:UIControlEventEditingChanged];
        
        [cell.buttonGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.buttonGet.layer.cornerRadius = 3;
        cell.buttonGet.tag = 1090;
        cell.buttonGet.layer.masksToBounds = YES;
        cell.buttonGet.layer.borderColor = [[UIColor daohanglan] CGColor];
        cell.buttonGet.layer.borderWidth = 0.5;
        [cell.buttonGet addTarget:self action:@selector(getCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.labelLeft.text = [nameArray objectAtIndex:indexPath.row];
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.placeholder = [textArray objectAtIndex:indexPath.row];
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.tag = indexPath.row + 700;
        cell.textField.delegate = self;
        [cell.textField addTarget:self action:@selector(mendDealTextField:) forControlEvents:UIControlEventEditingChanged];
        
        if (indexPath.row == 3) {
            
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)mendDealTextField:(UITextField *)textField
{
    textLast = (UITextField *)[self.view viewWithTag:700];
    textNew = (UITextField *)[self.view viewWithTag:701];
    textMakeSure = (UITextField *)[self.view viewWithTag:702];
    textPhone = (UITextField *)[self.view viewWithTag:703];
    textNum = (UITextField *)[self.view viewWithTag:704];
    
    if (textLast.text.length < 6) {
        
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textNew.text.length < 6) {
        
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textMakeSure.text.length < 6) {
        
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (![textNew.text isEqualToString:textMakeSure.text]) {
        
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (![NSString validateMobile:textPhone.text]) {
        
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textNum.text.length < 6) {
        
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonMake setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 703) {
        
        if (range.location < 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else if (textField.tag == 704) {
        
        if (range.location == 6) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else {
        
        if (range.location <= 19) {
            
            return YES;
            
        } else {
            
            return NO;
        }
    }
}

//确定按钮
- (void)makeSureButtonMendDeal:(UIButton *)button
{
    [self.view endEditing:YES];
    
    textLast = (UITextField *)[self.view viewWithTag:700];
    textNew = (UITextField *)[self.view viewWithTag:701];
    textMakeSure = (UITextField *)[self.view viewWithTag:702];
    textPhone = (UITextField *)[self.view viewWithTag:703];
    textNum = (UITextField *)[self.view viewWithTag:704];
    
    if (textLast.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入交易密码"];
        
    } else if (textLast.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"密码错误"];
        
    } else if (textNew.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位字符，至少包含字母和数字两种"];
        
    } else if (textMakeSure.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else if (![textNew.text isEqualToString:textMakeSure.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else if (![NSString validateMobile:textPhone.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else if (textNum.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
        
    } else {
        
        NSDictionary *parameter = @{@"userId":[self.flagDic objectForKey:@"id"],@"optType":@1,@"oldPayPwd":textLast.text,@"newPwd":textNew.text,@"smsCode":@""};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateUserPwd" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
 
    }
}

// 获得验证码
- (void)getCodeButtonAction:(UIButton *)btn{
    
    [self.view endEditing:YES];
    
    textPhone = (UITextField *)[self.view viewWithTag:703];
    
    if (textPhone.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:textPhone.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入手机格式有误"];
        
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameters = @{@"phone":textPhone.text,@"msgType":@"4"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:1090];
    
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
