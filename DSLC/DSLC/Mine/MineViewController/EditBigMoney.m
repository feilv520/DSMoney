//
//  EditBigMoney.m
//  DSLC
//
//  Created by ios on 15/11/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "EditBigMoney.h"
#import "MendDealCell.h"

@interface EditBigMoney () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tabelView;
    UIButton *buttonOk;
    
    NSArray *nameArray;
    NSArray *textArray;
    
    UITextField *fileldName;
    UITextField *fieldBank;
    UITextField *fieldBankCard;
    UITextField *fieldPhoneNum;
    UITextField *fieldMoney;
}

@end

@implementation EditBigMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"大额充值申请"];
    
    [self contentShow];
}

- (void)contentShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    _tabelView.backgroundColor = [UIColor huibai];
    [_tabelView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    nameArray = @[@"真实姓名", @"开户银行", @"银行卡号", @"手机号码", @"转账金额"];
    textArray = @[[DES3Util decrypt:self.schedule.realName], self.schedule.bankName, [DES3Util decrypt:self.schedule.account], [DES3Util decrypt:self.schedule.phone], [DES3Util decrypt:self.schedule.money]];
    
    buttonOk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tabelView.tableFooterView addSubview:buttonOk];
    buttonOk.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonOk addTarget:self action:@selector(makeSureEditReturn:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessageNotice:) name:@"send" object:nil];
}

- (void)sendMessageNotice:(NSNotification *)notice
{
    
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
    
    cell.textField.text = [textArray objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.textField.textColor = [UIColor zitihui];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row + 600;
    [cell.textField addTarget:self action:@selector(bigMoneyCanEdit:) forControlEvents:UIControlEventEditingChanged];
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//编辑绑定判断
- (void)bigMoneyCanEdit:(UITextField *)textField
{
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldMoney = (UITextField *)[self.view viewWithTag:604];
    
    if (fileldName.text.length > 0 &&fieldBank.text.length > 0 && fieldBankCard.text.length == 19 && fieldPhoneNum.text.length == 11 && fieldMoney.text.length > 0) {
        
        [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//确定按钮
- (void)makeSureEditReturn:(UIButton *)button
{
    if (fileldName.text.length > 0 &&fieldBank.text.length > 0 && fieldBankCard.text.length == 19 && fieldPhoneNum.text.length == 11 && fieldMoney.text.length > 0) {
        
        NSArray *viewController = [self.navigationController viewControllers];
        [self getData];
        [self.navigationController popToViewController:[viewController objectAtIndex:3] animated:YES];
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
    NSLog(@"3:%@", self.schedule.Id);
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *paremeter = @{@"id":self.schedule.Id, @"realName":fileldName.text, @"bankName":fieldBank.text, @"account":fieldBankCard.text, @"phone":fieldPhoneNum.text, @"money":fieldMoney.text, @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateBigPutOnSerialNum" parameters:paremeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
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
