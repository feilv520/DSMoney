//
//  LiftupMoneyViewController.m
//  DSLC
//
//  Created by ios on 15/11/11.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "LiftupMoneyViewController.h"
#import "BankWhichCell.h"
#import "AddBankCell.h"
#import "BindingBankCardLiftUpMoney.h"

@interface LiftupMoneyViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
    NSArray *everyArr;
    UILabel *labelLineDown;
    UIButton *buttonNext;
    UITextField *_textField;
}

@end

@implementation LiftupMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"提现"];
    
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor huibai];
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 265)];
    _tabelView.tableFooterView = viewFoot;
    [_tabelView registerNib:[UINib nibWithNibName:@"BankWhichCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tabelView registerNib:[UINib nibWithNibName:@"AddBankCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    UIView *viewWite = [CreatView creatViewWithFrame:CGRectMake(0, 8, WIDTH_CONTROLLER_DEFAULT, 137) backgroundColor:[UIColor whiteColor]];
    [viewFoot addSubview:viewWite];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(10, 15, WIDTH_CONTROLLER_DEFAULT - 20, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"温馨提示"];
    [viewWite addSubview:labelAlert];
    
    everyArr = @[@"1.每天最多可提现3次", @"2.每天提现限额5万", @"3.每次提现大于100"];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *labelEvery = [CreatView creatWithLabelFrame:CGRectMake(10, 45 + 29 * i, WIDTH_CONTROLLER_DEFAULT - 20, 29) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[everyArr objectAtIndex:i]];
        [viewWite addSubview:labelEvery];
    }
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 136.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewWite addSubview:labelLine];
    labelLine.alpha = 0.3;
    
    UILabel *labelTop = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewWite addSubview:labelTop];
    labelTop.backgroundColor = [UIColor grayColor];
    labelTop.alpha = 0.3;
    
    labelLineDown = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 197, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [viewFoot addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(buttonNextOneStep:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 245, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:buttonSafe];
    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        BankWhichCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imageBank.image = [UIImage imageNamed:@"2013123115540975"];
        
        cell.labelBank.text = @"中国工商银行卡(储蓄卡)";
        cell.labelBank.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelNum.text = @"尾号8888";
        cell.labelNum.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelNum.textAlignment = NSTextAlignmentRight;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.labelTitle.text = @"提现金额";
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.textField.placeholder = @"本次最多可提现1.00元";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor yuanColor];
        cell.textField.tag = 111111;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textField addTarget:self action:@selector(textFieldLiftUpMoney:) forControlEvents:UIControlEventEditingChanged];
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(cell.textField.frame.size.width - 20, 0, 15, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor yuanColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"元"];
        [cell.textField addSubview:label];
        
        [cell addSubview:labelLineDown];
        labelLineDown.backgroundColor = [UIColor grayColor];
        labelLineDown.alpha = 0.3;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

//提现接口
- (void)liftUpMoneyGetData
{
    NSDictionary *dealDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
    NSLog(@"=====%@", dealDic);
    NSLog(@"zzzzzzzzz%@", [DES3Util decrypt:[dealDic objectForKey:@"dealSecret"]]);

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *parmeter = @{@"fmoney":_textField.text, @"payPwd":[DES3Util decrypt:[dealDic objectForKey:@"dealSecret"]], @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/putOff" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"eeeeeeeee提现接口:%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            BindingBankCardLiftUpMoney *binding = [[BindingBankCardLiftUpMoney alloc] init];
            [self.navigationController pushViewController:binding animated:YES];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)textFieldLiftUpMoney:(UITextField *)textField
{
    _textField = (UITextField *)[self.view viewWithTag:111111];
    
    if (_textField.text.length > 0) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//下一步按钮
- (void)buttonNextOneStep:(UIButton *)button
{
    _textField = (UITextField *)[self.view viewWithTag:111111];
    
    if (_textField.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入提现金额"];
        
    } else if (_textField.text.length > 0) {
        
        [self liftUpMoneyGetData];
    }
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
