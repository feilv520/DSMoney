//
//  RechargeAlreadyBinding.m
//  DSLC
//
//  Created by ios on 15/11/6.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RechargeAlreadyBinding.h"
#import "AddBankCell.h"
#import "BankWhichCell.h"
#import "GiveMoneyVerifyBinding.h"
#import "AddBankViewController.h"

@interface RechargeAlreadyBinding () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tabelView;
    UIButton *buttonNext;
    
    UITextField *textFieldTag;
    NSInteger seconds;
    NSTimer *timer;
    
    NSArray *bankArray;
}

@property (nonatomic, strong) NSDictionary *dataDic;

@end

@implementation RechargeAlreadyBinding

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    bankArray = [self.dataDic objectForKey:@"BankCard"];
    
    if (bankArray.count == 0) {
        AddBankViewController *addBVC = [[AddBankViewController alloc] init];
        pushVC(addBVC);
    }
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"充值"];
    
    [self contentShow];
}

- (void)contentShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.scrollEnabled = NO;
    
    [_tabelView registerNib:[UINib nibWithNibName:@"BankWhichCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tabelView registerNib:[UINib nibWithNibName:@"AddBankCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 160, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(alreadyBindingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 210, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"由中国银行保障您的账户资金安全"];
    [self.view addSubview:buttonSafe];
    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        BankWhichCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imageBank.image = [UIImage imageNamed:@"2013123115540975"];
        
        cell.labelBank.text = [[[self.dataDic objectForKey:@"BankCard"] objectAtIndex:0] objectForKey:@"bankName"];
        cell.labelBank.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelNum.text = [NSString stringWithFormat:@"尾号%@",[[[self.dataDic objectForKey:@"BankCard"] objectAtIndex:0] objectForKey:@"bankAcc"]];
        cell.labelNum.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelNum.textAlignment = NSTextAlignmentRight;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.labelTitle.text = @"充值金额";
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.textField.placeholder = @"充值金额最小为1元";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor yuanColor];
        cell.textField.tag = 188;
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textField addTarget:self action:@selector(textAlreadyBinding:) forControlEvents:UIControlEventEditingChanged];
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(cell.textField.frame.size.width - 20, 0, 15, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor yuanColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"元"];
        [cell.textField addSubview:label];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if ([[textField.text substringFromIndex:0] isEqualToString:@"0"]) {
//        textField.text = @"";
//        return YES;
//        
//    } else {
//        return YES;
//    }
//}

//下一步按钮
- (void)alreadyBindingButton:(UIButton *)button
{
    [self.view endEditing:YES];
    textFieldTag = (UITextField *)[self.view viewWithTag:188];
    CGFloat shuRu = textFieldTag.text.intValue;
    
    if (textFieldTag.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入充值金额,充值金额最小为1元"];
        
    } else if (shuRu > 0){
        GiveMoneyVerifyBinding *giveMVB = [[GiveMoneyVerifyBinding alloc] init];
        giveMVB.money = textFieldTag.text;
        [self.navigationController pushViewController:giveMVB animated:YES];
        
    } else if ([textFieldTag.text isEqualToString:@"0"]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"最小金额为1元"];
        
    }
}

- (void)textAlreadyBinding:(UITextField *)textField
{
    textFieldTag = (UITextField *)[self.view viewWithTag:188];
    CGFloat shuRu = textField.text.intValue;
    
    if (shuRu > 0) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 网络请求获得我的绑定的银行卡号
#pragma mark --------------------------------

- (void)getData
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            NSLog(@"134897189374987342987243789423");
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        }
        
        self.dataDic = [NSDictionary dictionary];
        self.dataDic = [responseObject objectForKey:@"User"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
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
