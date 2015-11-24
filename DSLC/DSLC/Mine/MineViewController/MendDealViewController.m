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
        cell.textField.delegate = self;
        [cell.textField addTarget:self action:@selector(mendDealTextField:) forControlEvents:UIControlEventEditingChanged];
        
        [cell.buttonGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.buttonGet.layer.cornerRadius = 3;
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
        
    } else if (textPhone.text.length < 11) {
        
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
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入信息"];
        
    } else if (textLast.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入的原交易密码有误"];
        
    } else if (textNew.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入的新交易密码不符合要求"];
        
    } else if (textMakeSure.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入的新交易密码与原交易密码不匹配"];
        
    } else if (![textNew.text isEqualToString:textMakeSure.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入的新交易密码与原交易密码不匹配"];
        
    } else if (textPhone.text.length < 11) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入的手机号有误"];
        
    } else if (textNum.text.length < 6) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入的验证码有误"];
        
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
    
    textNum = (UITextField *)[self.view viewWithTag:704];
    
    if (textNum.text.length == 0) {
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
    } else {
        NSDictionary *parameters = @{@"phone":textNum.text,@"msgType":@"4"};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
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
