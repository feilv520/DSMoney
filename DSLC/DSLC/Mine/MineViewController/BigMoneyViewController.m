//
//  BigMoneyViewController.m
//  DSLC
//
//  Created by ios on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BigMoneyViewController.h"
#import "BaseViewController.h"
#import "MendDealCell.h"
#import "HistoryMemoryViewController.h"
#import "ApplyScheduleViewController.h"
#import "ChooseOpenAnAccountBank.h"

@interface BigMoneyViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    
    NSArray *nameArray;
    NSArray *textArray;
    
    UIButton *buttonApply;
    UIImageView *imageRight;
    
    UITextField *fileldName;
    UITextField *fieldBank;
    UITextField *fieldBankCard;
    UITextField *fieldPhoneNum;
    UITextField *fieldMoney;
}

@end

@implementation BigMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setTitleString:@"大额充值申请"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"历史记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBar:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnBankName:) name:@"bank" object:nil];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    nameArray = @[@"真实姓名", @"开户银行", @"银行卡号", @"手机号码", @"转账金额"];
    textArray = @[@"请输入真实姓名", @"选择发卡银行", @"银行卡号", @"预留银行开户手机号", @"转账额度"];
    
    buttonApply = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"提交申请"];
    [_tableView.tableFooterView addSubview:buttonApply];
    buttonApply.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonApply addTarget:self action:@selector(applyBigMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 13, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"jiantou"]];
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
    MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = [nameArray objectAtIndex:indexPath.row];
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = [textArray objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.textColor = [UIColor zitihui];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row + 600;
    [cell.textField addTarget:self action:@selector(bigMoneyCashMoney:) forControlEvents:UIControlEventEditingChanged];
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.row == 1) {
        
        [cell addSubview:imageRight];
        cell.textField.enabled = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        ChooseOpenAnAccountBank *chooseOAAB = [[ChooseOpenAnAccountBank alloc] init];
        [self.navigationController pushViewController:chooseOAAB animated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 602) {

        if (range.location == 19) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else if (textField.tag == 603) {

        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else {
        
        return YES;
    }
}

//编辑绑定判断
- (void)bigMoneyCashMoney:(UITextField *)textField
{
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldMoney = (UITextField *)[self.view viewWithTag:604];
    
    if (fileldName.text.length > 0 &&fieldBank.text.length > 0 && fieldBankCard.text.length == 19 && fieldPhoneNum.text.length == 11 && fieldMoney.text.length > 0) {
        
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        if (textField.tag == 603) {
           
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 604) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    return YES;
}

//申请按钮
- (void)applyBigMoney:(UIButton *)button
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _tableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view endEditing:YES];
    
    if (fileldName.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入姓名"];
        
    } else if (fieldBankCard.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入银行卡号"];
        
    } else if (fieldBankCard.text.length != 19) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"银行卡号格式错误"];
        
    } else if (fieldPhoneNum.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:fieldPhoneNum.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else if (fieldMoney.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入转账金额"];
        
    } else {
        [self getData];
        [self.view endEditing:YES];
    }
}

//历史记录
- (void)rightBar:(UIBarButtonItem *)bar
{
    HistoryMemoryViewController *historyVC = [[HistoryMemoryViewController alloc] init];
    [self.navigationController pushViewController:historyVC animated:YES];
}

//回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 100) {
        
        [self.view endEditing:YES];
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
- (void)getData
{
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldMoney = (UITextField *)[self.view viewWithTag:604];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *parameter = @{@"realName":fileldName.text, @"bankName":fieldBank.text, @"account":fieldBankCard.text, @"phone":fieldPhoneNum.text, @"money":fieldMoney.text, @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/bigPutOn" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"zzzzzzz%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSString *IDstr = [[responseObject objectForKey:@"id"] description];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            ApplyScheduleViewController *scheduleVC = [[ApplyScheduleViewController alloc] init];
            scheduleVC.ID = IDstr;
            NSLog(@"1:%@", IDstr);
            [self.navigationController pushViewController:scheduleVC animated:YES];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)returnBankName:(NSNotification *)notice
{
    NSString *bankName = [notice object];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBank.text = bankName;
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
