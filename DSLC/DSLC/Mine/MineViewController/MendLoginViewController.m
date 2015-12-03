//
//  MendLoginViewController.m
//  DSLC
//
//  Created by ios on 15/10/30.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MendLoginViewController.h"
#import "MendLoginCell.h"
#import "ForgetSecretViewController.h"

@interface MendLoginViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *leftArr;
    NSArray *textArr;
    UIButton *butMake;
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
}

@end

@implementation MendLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"修改登录密码"];
    
    [self contentShow];
}

- (void)contentShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 150) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor huibai];
    [_tableView registerNib:[UINib nibWithNibName:@"MendLoginCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    leftArr = @[@"原登录密码", @"新登录密码", @"确认登录密码"];
    textArr = @[@"请输入原登录密码", @"请输入新登录密码", @"请再次输入新登录密码"];
    
    butMake = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 210, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:butMake];
    [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butMake addTarget:self action:@selector(buttonReally:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MendLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = [leftArr objectAtIndex:indexPath.row];
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textFieldRight.placeholder = [textArr objectAtIndex:indexPath.row];
    cell.textFieldRight.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textFieldRight.tintColor = [UIColor grayColor];
    cell.textFieldRight.delegate = self;
    cell.textFieldRight.tag = indexPath.row + 300;
    [cell.textFieldRight addTarget:self action:@selector(editTextField:) forControlEvents:UIControlEventEditingChanged];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location < 20) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

- (void)editTextField:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:300];
    textField2 = (UITextField *)[self.view viewWithTag:301];
    textField3 = (UITextField *)[self.view viewWithTag:302];
    
    if (textField1.text.length < 6) {
        
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textField2.text.length < 6) {
        
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textField3.text.length < 6) {
        
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (![textField2.text isEqualToString:textField3.text]) {
        
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butMake setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
    
}

//确定按钮
- (void)buttonReally:(UIButton *)button
{
    textField1 = (UITextField *)[self.view viewWithTag:300];
    textField2 = (UITextField *)[self.view viewWithTag:301];
    textField3 = (UITextField *)[self.view viewWithTag:302];
    
    if (textField1.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入登录密码"];
        
    } else if (![NSString validatePassword:textField1.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位含字母和数字,以字母开头"];
        
    } else if (textField2.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入新登录密码"];
        
    } else if (![NSString validatePassword:textField2.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位含字母和数字,以字母开头"];
        
    } else if (textField3.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入确认登录密码"];
        
    } else if (textField3.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else if (![textField2.text isEqualToString:textField3.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else {
        
        self.flagDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        
        NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"],@"optType":@1,@"oldPwd":textField1.text,@"newPwd":textField2.text,@"smsCode":@""};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateUserPwd" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
                [ProgressHUD showMessage:[NSString stringWithFormat:@"%@,需要重新登陆",[responseObject objectForKey:@"resultMsg"]] Width:100 High:20];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } else {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"密码错误"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)rightBarItem:(UIBarButtonItem *)bar
{
    ForgetSecretViewController *findVC = [[ForgetSecretViewController alloc] init];
    findVC.typeString = @"login";
    [self.navigationController pushViewController:findVC animated:YES];
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
