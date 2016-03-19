//
//  SetLoginPasswordViewController.m
//  DSLC
//
//  Created by ios on 16/3/19.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "SetLoginPasswordViewController.h"
#import "SetPasswordTableViewCell.h"

@interface SetLoginPasswordViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    
    NSString *setP1;
    NSString *setP2;
    
    UIButton *setPasswordButton;
    
    NSInteger countIns;
}

@end

@implementation SetLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"设置登录密码"];
    
    self.view.backgroundColor = Color_White;
    
    [self showTableView];
    countIns = 0;
}

- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 120) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor whiteColor];
    
    _tableView.bounces = NO;
    
    [_tableView registerNib:[UINib nibWithNibName:@"SetPasswordTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    setPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    setPasswordButton.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 200) / 2.0, CGRectGetMaxY(_tableView.frame), 200, 50);
    [setPasswordButton addTarget:self action:@selector(setPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
     [setPasswordButton setTitle:@"确认" forState:UIControlStateNormal];
    
    setPasswordButton.enabled = NO;
    
    [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:setPasswordButton];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"设置登录密码";
        cell.passwordTF.placeholder = @"请输入登录密码";
        cell.passwordTF.tag = 1001;
    } else {
        cell.titleLabel.text = @"确认登录密码";
        cell.passwordTF.placeholder = @"请确认登录密码";
        cell.passwordTF.tag = 1002;
    }
    
    [cell.passwordTF addTarget:self action:@selector(editContent:) forControlEvents:UIControlEventEditingChanged];
    
    cell.passwordTF.delegate = self;
    
    return cell;
}

//确定按钮
- (void)setPasswordButtonAction:(UIButton *)button
{
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:1002];
    
    if (textField1.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入登录密码"];
        
    } else if (textField2.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请确认登录密码"];
        
    } else if (![NSString validatePassword:textField1.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位含字母和数字,以字母开头"];
        
    } else if (![textField1.text isEqualToString:textField2.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"设置登录密码不一致"];
        
    } else {
        
        countIns ++;
        if (countIns == 1) {
            [self submitLoadingWithView:self.view loadingFlag:NO height:0];
            
        } else {
            [self submitLoadingWithHidden:NO];
        }
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        
        NSDictionary *parameters = @{@"pwd":textField1.text,@"token":[dic objectForKey:@"token"]};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/setLoginPwd" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            popVC;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"系统异常"];
            NSLog(@"%@",error);
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1001 || textField.tag == 1002) {
        
        if (range.location < 20) {
            
            return YES;
            
        } else {
            
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)editContent:(UITextField *)textField
{
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:1001];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:1002];
    
    if (textField1.text.length == 0) {
        
        //        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入..."];
        [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        setPasswordButton.enabled = NO;
        
    } else if (textField2.text.length < 6) {
        
        //        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"登录密码错误"];
        [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        setPasswordButton.enabled = NO;
        
    } else {
        
        [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [setPasswordButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
        setPasswordButton.enabled = YES;
        
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
