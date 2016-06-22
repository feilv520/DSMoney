//
//  TWOSetDealSecretViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOSetDealSecretViewController.h"
#import "TWOPhoneNumCell.h"
#import "TWOGetCodeCell.h"
#import "TWOChangeLoginFinishViewController.h"
#import "TWOSetLoginSecretViewController.h"

@interface TWOSetDealSecretViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UITextField *_textField;
    UIButton *butNext;
    NSInteger seconds;
    NSTimer *timer;
}

@end

@implementation TWOSetDealSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"设置登录密码"];
    
    [self tabelViewShow];
    seconds = 60;
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.scrollEnabled = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"TWOPhoneNumCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOGetCodeCell" bundle:nil] forCellReuseIdentifier:@"reuseCode"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 15, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor findZiTiColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [_tableView.tableFooterView addSubview:butNext];
    butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butNext.layer.cornerRadius = 5;
    butNext.layer.masksToBounds = YES;
    [butNext addTarget:self action:@selector(nextOneStep:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TWOPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imagePhone.image = [UIImage imageNamed:@"手机"];
        cell.labelPhone.text = [self.phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        TWOGetCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCode"];
        
        cell.imageLeft.image = [UIImage imageNamed:@"yanzhenma"];
        cell.textFieldCode.placeholder = @"请输入短信验证码";
        cell.textFieldCode.tintColor = [UIColor grayColor];
        cell.textFieldCode.textColor = [UIColor findZiTiColor];
        cell.textFieldCode.delegate = self;
        cell.textFieldCode.tag = 333;
        cell.textFieldCode.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textFieldCode addTarget:self action:@selector(textFieldNextOneStepGray:) forControlEvents:UIControlEventEditingChanged];
        
        cell.butGetCode.layer.cornerRadius = 6;
        cell.butGetCode.layer.masksToBounds = YES;
        cell.butGetCode.layer.borderColor = [[UIColor profitColor] CGColor];
        cell.butGetCode.layer.borderWidth = 1;
        cell.butGetCode.tag = 921;
        [cell.butGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.butGetCode setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
        [cell.butGetCode addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//按钮置灰
- (void)textFieldNextOneStepGray:(UITextField *)textField
{
    _textField = (UITextField *)[self.view viewWithTag:333];
    if (_textField.text.length == 0) {
        butNext.backgroundColor = [UIColor findZiTiColor];
    } else {
        butNext.backgroundColor = [UIColor profitColor];
    }
}

//获取验证码按钮
- (void)getCode:(UIButton *)button
{
    NSLog(@"code");
    [self getcodeData];
}

#pragma mark code--------------------------------------------------------
- (void)getcodeData
{
    NSDictionary *parermeter = @{@"phone":self.phoneStr, @"msgType":@"3"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/getSmsCode" parameters:parermeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"设置登录密码:%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 5) {
        return NO;
    } else {
        return YES;
    }
}

//下一步按钮
- (void)nextOneStep:(UIButton *)button
{
    _textField = (UITextField *)[self.view viewWithTag:333];
    
    if (_textField.text.length == 0) {

    } else if (_textField.text.length < 5) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
    } else {
        [self.view endEditing:YES];
        [self nextOneStepData];
    }
}

//下一步校验验证码接口
#pragma mark data=====================
- (void)nextOneStepData
{
    NSDictionary *parmeter = @{@"phone":self.phoneStr, @"smsCode":_textField.text};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/checkSmsCode" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"下一步校验验证码---------%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            TWOSetLoginSecretViewController *loginSecretVC = [[TWOSetLoginSecretViewController alloc] init];
            pushVC(loginSecretVC);
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:921];
    
    NSString *title = [NSString stringWithFormat:@"%lds",(long)seconds];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor profitColor].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        [button setTitle:@"获取验证码" forState: UIControlStateNormal];
        [button setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
        [button setEnabled:YES];
    }else{
        seconds--;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor orangecolor].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        [button setTitleColor:[UIColor orangecolor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setEnabled:NO];
    }
}

- (void)releaseTImer {
    if (timer) {
        if ([timer respondsToSelector:@selector(isValid)]) {
            if ([timer isValid]) {
                [timer invalidate];
                seconds = 60;
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
