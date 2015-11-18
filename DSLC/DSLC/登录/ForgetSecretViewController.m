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
}

@end

@implementation ForgetSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"找回登录密码"];
    
    [self tableViewShowTime];
    
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
//    textFieldPhoneNum.text = @"15940942599";
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
        cell.textField.tag = 500;
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textField addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
        
        [cell.butGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.butGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.butGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
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
            
            cell.labelTitle.text = @"绑定手机号";
            cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            cell.textField.hidden = YES;
            [cell addSubview:textFieldPhoneNum];
            textFieldPhoneNum.tag = 1000;
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
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
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
    textField1 = (UITextField *)[self.view viewWithTag:500];
    textField2 = (UITextField *)[self.view viewWithTag:902];
    textField3 = (UITextField *)[self.view viewWithTag:903];
    
    if (textFieldPhoneNum.text.length > 0 && textField1.text.length > 0 && textField2.text.length > 0 && textField3.text.length > 0 && textField2.text == textField3.text) {
        
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butEnsure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    }
    
}

//获取验证码
- (void)getCodeButtonAction:(UIButton *)btn{
    [self.view endEditing:YES];
    if (textFieldPhoneNum.text.length == 0) {
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
    } else {
        NSDictionary *parameters = @{@"phone":textFieldPhoneNum.text};
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
    textField1 = (UITextField *)[self.view viewWithTag:500];
    textField2 = (UITextField *)[self.view viewWithTag:902];
    textField3 = (UITextField *)[self.view viewWithTag:903];
    
    if (textFieldPhoneNum.text.length > 0 && textField1.text.length > 0 && textField2.text.length > 0 && textField3.text.length > 0 && [textField2.text isEqualToString:textField3.text]) {
        
        NSDictionary *parameter = @{@"userId":[self.flagDic objectForKey:@"id"],@"optType":@2,@"oldPwd":@"",@"newPwd":textField2.text,@"smsCode":textField1.text};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateUserPwd" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
                NSArray *array = self.navigationController.viewControllers;
                [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
        
        
    } else if (![textField3.text isEqualToString:textField2.text]) {
        
        [self.view endEditing:YES];
        [ProgressHUD showMessage:@"输入的登录密码与确认的登录密码不匹配" Width:80 High:80];
        
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
