//
//  FindDealViewController.m
//  DSLC
//
//  Created by ios on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FindDealViewController.h"
#import "MendDealCell.h"
#import "MendDeal2Cell.h"

@interface FindDealViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *leftArray;
    NSArray *textArray;
    UIButton *butReally;
    
    UITextField *textPhoneNum;
    UITextField *textCheckNum;
    UITextField *textNewDeal;
    UITextField *textMakeNew;
    
    NSInteger seconds;
    NSTimer *timer;
}

@end

@implementation FindDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"找回交易密码"];
    
    seconds = 120;
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    _tableView.tableFooterView.backgroundColor = [UIColor huibai];
    _tableView.backgroundColor = [UIColor huibai];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDeal2Cell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    leftArray = @[@"绑定手机号", @"", @"设置新交易密码", @"确认新交易密码"];
    textArray = @[@"请输入手机号", @"", @"请输入新交易密码", @"请再次输入新交易密码"];
    
    butReally = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tableView.tableFooterView addSubview:butReally];
    butReally.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butReally addTarget:self action:@selector(findSecretMakeSure:) forControlEvents:UIControlEventTouchUpInside];
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
        
        MendDeal2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        [cell.buttonGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.buttonGet.layer.cornerRadius = 3;
        cell.buttonGet.layer.masksToBounds = YES;
        cell.buttonGet.layer.borderWidth = 0.5;
        cell.buttonGet.tag = 5678;
        cell.buttonGet.layer.borderColor = [[UIColor daohanglan] CGColor];
        [cell.buttonGet addTarget:self action:@selector(getCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.labelLeft.text = @"验证码";
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.placeholder = @"请输入验证码";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.tag = 701;
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textField addTarget:self action:@selector(findSecretTextFieldEdit:) forControlEvents:UIControlEventEditingChanged];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.labelLeft.text = [leftArray objectAtIndex:indexPath.row];
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        
        cell.textField.placeholder = [textArray objectAtIndex:indexPath.row];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.tag = indexPath.row + 700;
        cell.textField.delegate = self;
        [cell.textField addTarget:self action:@selector(findSecretTextFieldEdit:) forControlEvents:UIControlEventEditingChanged];
        
        if (indexPath.row == 0) {
            
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 700) {
        
        if (range.location < 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else if (textField.tag == 701) {
        
        if (range.location == 6) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else {
        
        if (range.location < 20) {
            
            return YES;
            
        } else {
            
            return NO;
        }
    }
}

- (void)findSecretTextFieldEdit:(UITextField *)textField
{
    textPhoneNum = (UITextField *)[self.view viewWithTag:700];
    textCheckNum = (UITextField *)[self.view viewWithTag:701];
    textNewDeal = (UITextField *)[self.view viewWithTag:702];
    textMakeNew = (UITextField *)[self.view viewWithTag:703];
    
    if (![NSString validateMobile:textPhoneNum.text]) {
        
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];

    } else if (textCheckNum.text.length != 6) {
        
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];

    } else if (textNewDeal.text.length < 6) {
        
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];

    } else if (![textNewDeal.text isEqualToString:textMakeNew.text]) {
        
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];

    } else {
        
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        if (textField.tag == 702) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 703) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    return YES;
}

//确定按钮
- (void)findSecretMakeSure:(UIButton *)button
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _tableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view endEditing:YES];
    
    textPhoneNum = (UITextField *)[self.view viewWithTag:700];
    textCheckNum = (UITextField *)[self.view viewWithTag:701];
    textNewDeal = (UITextField *)[self.view viewWithTag:702];
    textMakeNew = (UITextField *)[self.view viewWithTag:703];
    
    if (textPhoneNum.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:textPhoneNum.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else if (textCheckNum.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入验证码"];
        
    }else if (textCheckNum.text.length != 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
        
    } else if (textNewDeal.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请设置新交易密码"];
        
    } else if (![NSString validatePassword:textNewDeal.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位含字母和数字,以字母开头"];
        
    } else if (textMakeNew.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入确认交易密码"];
        
    } else if (textMakeNew.text.length < 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else if (![textNewDeal.text isEqualToString:textMakeNew.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else {
        
        NSArray *viewController = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[viewController objectAtIndex:2] animated:YES];
    }
        
}

// 获得验证码
- (void)getCodeButtonAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    
    textPhoneNum = (UITextField *)[self.view viewWithTag:700];
    
    if (textPhoneNum.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:textPhoneNum.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameters = @{@"phone":textPhoneNum.text, @"msgType":@"4 "};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:5678];
    
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
        NSString *title = [NSString stringWithFormat:@"重新发送(%lds)",(long)seconds];
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor zitihui].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setEnabled:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 100) {
        
        [self.view endEditing:YES];
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
