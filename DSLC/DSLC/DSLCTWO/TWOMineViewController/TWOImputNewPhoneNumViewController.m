//
//  TWOImputNewPhoneNumViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOImputNewPhoneNumViewController.h"
#import "TWOPhoneNumCell.h"
#import "TWOGetCodeCell.h"
#import "TWOImputPhoneNumCell.h"

@interface TWOImputNewPhoneNumViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    UIButton *butMakeSure;
    UITextField *textFieldCode;
    UITextField *textFieldPhone;
    NSInteger seconds;
    NSTimer *timer;
}

@end

@implementation TWOImputNewPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"更换绑定手机号"];
    seconds = 60;
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOImputPhoneNumCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOGetCodeCell" bundle:nil] forCellReuseIdentifier:@"reuseCode"];
    
//    确定按钮
    butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 15, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tableView.tableFooterView addSubview:butMakeSure];
    butMakeSure.layer.cornerRadius = 5;
    butMakeSure.layer.masksToBounds = YES;
    butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butMakeSure addTarget:self action:@selector(makeSureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        TWOImputPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.imagePic.image = [UIImage imageNamed:@"手机"];
        cell.textFieldPhone.delegate = self;
        cell.textFieldPhone.tag = 800;
        cell.textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
        cell.textFieldPhone.textColor = [UIColor ZiTiColor];
        cell.textFieldPhone.placeholder = @"请输入需要更换绑定的手机号";
        cell.textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textFieldPhone.tintColor = [UIColor grayColor];
        cell.buttonEye.hidden = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        TWOGetCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCode"];
        
        cell.imageLeft.image = [UIImage imageNamed:@"yanzhenma"];
        cell.textFieldCode.placeholder = @"请输入短信验证码";
        cell.textFieldCode.tintColor = [UIColor grayColor];
        cell.textFieldCode.textColor = [UIColor ZiTiColor];
        cell.textFieldCode.delegate = self;
        cell.textFieldCode.tag = 333;
        cell.textFieldCode.keyboardType = UIKeyboardTypeNumberPad;
        
        cell.butGetCode.layer.cornerRadius = 6;
        cell.butGetCode.layer.masksToBounds = YES;
        cell.butGetCode.layer.borderColor = [[UIColor profitColor] CGColor];
        cell.butGetCode.layer.borderWidth = 1;
        cell.butGetCode.tag = 19890502;
        [cell.butGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.butGetCode addTarget:self action:@selector(getCodeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

//获取验证码
- (void)getCodeButton:(UIButton *)button
{
    NSLog(@"code");
    textFieldPhone = (UITextField *)[self.view viewWithTag:800];
    textFieldCode = (UITextField *)[self.view viewWithTag:333];
    
    if (textFieldPhone.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入要更换的绑定手机号"];
    } else if (![NSString validateMobile:textFieldPhone.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"您输入的手机格式不正确"];
    } else {
        [self getCode];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textFieldPhone = (UITextField *)[self.view viewWithTag:800];
    textFieldCode = (UITextField *)[self.view viewWithTag:333];
    
    if (textField == textFieldPhone) {
        if (range.location > 10) {
            return NO;
        } else {
            return YES;
        }
    } else {
        if (range.location > 5) {
            return NO;
        } else {
            return YES;
        }
    }
}

//确定按钮方法
- (void)makeSureButtonClicked:(UIButton *)button
{
    textFieldPhone = (UITextField *)[self.view viewWithTag:800];
    textFieldCode = (UITextField *)[self.view viewWithTag:333];
    
    if (textFieldPhone.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入要更换的绑定手机号"];
    } else if (![NSString validateMobile:textFieldPhone.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"您输入的手机格式不正确"];
    } else if (textFieldCode.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入短信验证码"];
    } else if (textFieldCode.text.length != 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入不少于6位短信验证码"];
    } else {
        [self.view endEditing:YES];
        [self getDataMakeSure];
    }
}

#pragma mark data-----------------------------
- (void)getDataMakeSure
{
    textFieldPhone = (UITextField *)[self.view viewWithTag:800];
    textFieldCode = (UITextField *)[self.view viewWithTag:333];
    
    NSDictionary *parmeter = @{@"phone":textFieldPhone.text, @"smsCode":textFieldCode.text, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/updateUserPhone" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"更换手机号:~~~~~~~~%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"twoPhone" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            NSArray *viewControllers = [self.navigationController viewControllers];
            [self.navigationController popToViewController:[viewControllers objectAtIndex:2] animated:YES];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"更换手机号:~~~~~~~~%@", error);
    }];
}

//获取验证码按钮掉接口
- (void)getCode
{
    textFieldPhone = (UITextField *)[self.view viewWithTag:800];
    textFieldCode = (UITextField *)[self.view viewWithTag:333];
    
    NSDictionary *parermeter = @{@"phone":textFieldPhone.text, @"msgType":@"2"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"three/getSmsCode" parameters:parermeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"////////更换手机号获取验证码:%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:19890502];
    
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
