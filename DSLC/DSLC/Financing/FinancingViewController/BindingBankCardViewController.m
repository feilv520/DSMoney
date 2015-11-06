//
//  BindingBankCardViewController.m
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BindingBankCardViewController.h"
#import "MendDeal2Cell.h"
#import "BindingBankCell.h"
#import "BindingBankSucceController.h"

@interface BindingBankCardViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    UIButton *buttonMake;
    
    UITextField *textField3;
    UITextField *textField4;
    UITextField *textField5;
    
    NSArray *nameArray;
    NSArray *TEXTfIELDaRRAY;
    
    UIButton *buttonGood;
}

@end

@implementation BindingBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"绑定银行卡"];
    
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130)];
    viewFoot.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = viewFoot;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MendDeal2Cell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"BindingBankCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    nameArray = @[@"持卡人", @"开户行", @"开户省市", @"银行卡号", @"预留手机号", @""];
    TEXTfIELDaRRAY = @[@"黄冬明", @"选择开户银行", @"选择省市", @"请输入本人银行卡号", @"请输入在银行预留的手机号", @""];
    
    UIButton *buttonHint = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 10, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"若没有选择开户行和开户省市,在您提现时需要再次补充"];
    [viewFoot addSubview:buttonHint];
    buttonHint.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonHint setImage:[UIImage imageNamed:@"提示"] forState:UIControlStateNormal];
    
    buttonGood = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 90, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [viewFoot addSubview:buttonGood];
    buttonGood.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonGood setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonGood setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonGood addTarget:self action:@selector(buttonBindingBank:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 140, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:buttonSafe];
    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        
        MendDeal2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.labelLeft.text = @"验证码";
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.placeholder = @"请输入验证码";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.tag = 704;
        cell.textField.delegate = self;
        [cell.textField addTarget:self action:@selector(bindingBankTextField:) forControlEvents:UIControlEventEditingChanged];
        
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
        
        BindingBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.labelLeft.text = [nameArray objectAtIndex:indexPath.row];
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.placeholder = [TEXTfIELDaRRAY objectAtIndex:indexPath.row];
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.tag = indexPath.row + 600;
        [cell.textField addTarget:self action:@selector(bindingBankTextField:) forControlEvents:UIControlEventEditingChanged];
        
        if (indexPath.row == 0) {
            
            cell.textField.enabled = NO;
            [cell.textField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        
        if (indexPath.row == 1 || indexPath.row == 2) {
            
            cell.textField.enabled = NO;
        }
        
        if (indexPath.row == 1 || indexPath.row == 2) {
            
            cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//确定按钮
- (void)buttonBindingBank:(UIButton *)button
{
    textField3 = (UITextField *)[self.view viewWithTag:603];
    textField4 = (UITextField *)[self.view viewWithTag:604];
    textField5 = (UITextField *)[self.view viewWithTag:704];
    
    if (textField3.text.length > 0 && textField4.text.length > 0 && textField5.text.length > 0) {
        
        BindingBankSucceController *succeeVC = [[BindingBankSucceController alloc] init];
        [self.navigationController pushViewController:succeeVC animated:YES];
        
    } else {
        
        
    }
}

- (void)bindingBankTextField:(UITextField *)textField
{
    textField3 = (UITextField *)[self.view viewWithTag:603];
    textField4 = (UITextField *)[self.view viewWithTag:604];
    textField5 = (UITextField *)[self.view viewWithTag:704];
    
    if (textField3.text.length > 0 && textField4.text.length > 0 && textField5.text.length > 0) {
        
        [buttonGood setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonGood setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonGood setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonGood setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

// 获得验证码
- (void)getCodeButtonAction:(UIButton *)btn
{
//    [self.view endEditing:YES];
//    
//    textField5 = (UITextField *)[self.view viewWithTag:704];
//    
//    if (textField5.text.length == 0) {
//        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
//    } else {
//        NSDictionary *parameters = @{@"phone":textField5.text};
//        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
//            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//        }];
//    }
    
    NSLog(@"666666");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    textField3 = (UITextField *)[self.view viewWithTag:603];
    textField4 = (UITextField *)[self.view viewWithTag:604];
    textField5 = (UITextField *)[self.view viewWithTag:704];
    
    if (scrollView.contentOffset.y > 0) {
        
        [textField3 resignFirstResponder];
        [textField4 resignFirstResponder];
        [textField5 resignFirstResponder];
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
