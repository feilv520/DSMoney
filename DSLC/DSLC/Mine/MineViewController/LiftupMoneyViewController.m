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
#import "SetDealSecret.h"
#import "TTTTXianTableViewCell.h"
#import "FindDealViewController.h"
#import "RealNameViewController.h"
#import "AddBankViewController.h"
#import "RSA.h"
#import "ZFPassword.h"

@interface LiftupMoneyViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>

{
    UITableView *_tabelView;
    NSArray *everyArr;
    UILabel *labelLineDown;
    UIButton *buttonNext;
    UITextField *_textField;
    UITextField *textDeal;
    
    NSDictionary *bankDic;
    
    NSString *ownerOrder;
    
    UITextField *textFieldPassword;
    
    NSDictionary *dealDic;
    NSInteger click;
    
    UIView *viewGray;
    
    ZFPassword *ZFPView;
}

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *orderDic;
@property (nonatomic, strong) LLPaySdk *sdk;

@end

@implementation LiftupMoneyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    viewGray.hidden = NO;
    ZFPView.hidden = NO;
}

- (void)viewDidWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    viewGray.hidden = YES;
    ZFPView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"提现"];
    
    viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor]];
    viewGray.alpha = 0.3;

//    viewGray.hidden = YES;
    
    click = 0;
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
    [_tabelView registerNib:[UINib nibWithNibName:@"TTTTXianTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    
    UIView *viewWite = [CreatView creatViewWithFrame:CGRectMake(0, 8, WIDTH_CONTROLLER_DEFAULT, 195) backgroundColor:[UIColor whiteColor]];
    [viewFoot addSubview:viewWite];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(10, 15, WIDTH_CONTROLLER_DEFAULT - 20, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"温馨提示"];
    [viewWite addSubview:labelAlert];
    
    everyArr = @[@"1.您投资本金金额≥100元时,方可进行提现;", @"2.您每日只可提现三次;", @"3.您每日可获取三次免手续费的提现机会;", @"4.账户余额低于100元时,须一次性提完;",@"5.提现后您的账户低于100元时,须一次性提完。"];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *labelEvery = [CreatView creatWithLabelFrame:CGRectMake(10, 45 + 29 * i, WIDTH_CONTROLLER_DEFAULT - 20, 29) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[everyArr objectAtIndex:i]];
        [viewWite addSubview:labelEvery];
    }
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 194.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewWite addSubview:labelLine];
    labelLine.alpha = 0.3;
    
    UILabel *labelTop = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewWite addSubview:labelTop];
    labelTop.backgroundColor = [UIColor grayColor];
    labelTop.alpha = 0.3;
    
    labelLineDown = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 236, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [viewFoot addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(buttonNextOneStep:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 245, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"由中国银行保障您的账户资金安全"];
//    [viewFoot addSubview:buttonSafe];
//    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
//    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
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
        
        cell.imageBank.image = [UIImage imageNamed:[[self.dataDic objectForKey:@"BankCard"] objectForKey:@"bankName"]];
        
        cell.labelBank.text = [[self.dataDic objectForKey:@"BankCard"] objectForKey:@"bankName"];
        cell.labelBank.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelNum.text = [NSString stringWithFormat:@"尾号%@",[[self.dataDic objectForKey:@"BankCard"] objectForKey:@"bankAcc"]];
        cell.labelNum.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelNum.textAlignment = NSTextAlignmentRight;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.labelTitle.text = @"提现金额(元)";
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.textField.placeholder = [NSString stringWithFormat:@"本次最多可提现%@元",[DES3Util decrypt:[self.flagDic objectForKey:@"accBalance"]]];
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor yuanColor];
        cell.textField.tag = 111111;
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [cell.textField addTarget:self action:@selector(textFieldLiftUpMoney:) forControlEvents:UIControlEventEditingChanged];
        
        _textField = cell.textField;
        
        if ([self.moneyString floatValue] < 100.0 && [self.moneyString floatValue] != 0) {
            cell.textField.text = self.moneyString;
            [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
            [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        }
        
//        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(cell.textField.frame.size.width - 20, 0, 15, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor yuanColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"元"];
//        [cell.textField addSubview:label];
        
        [cell addSubview:labelLineDown];
        labelLineDown.backgroundColor = [UIColor grayColor];
        labelLineDown.alpha = 0.3;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

//设置交易密码
- (void)setDealSecret:(UIButton *)button
{
    SetDealSecret *deal = [[SetDealSecret alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenWithCell:) name:@"hiddenWithCell" object:nil];
    [self.navigationController pushViewController:deal animated:YES];
}

- (void)hiddenWithCell:(NSNotification *)not{
    UIButton *forgetB = (UIButton *)[self.view viewWithTag:9873];
    UIButton *setPWord = (UIButton *)[self.view viewWithTag:9871];
    textFieldPassword = (UITextField *)[self.view viewWithTag:9898];
    
    forgetB.hidden = NO;
    setPWord.hidden = YES;
    textFieldPassword.hidden = NO;
    
    [_tabelView reloadData];
}

//忘记密码?按钮
- (void)ForgetSecretButton:(UIButton *)button
{
    FindDealViewController *findSecretVC = [[FindDealViewController alloc] init];
    findSecretVC.whichOne = NO;
    [self.navigationController pushViewController:findSecretVC animated:YES];
}

//提现接口
- (void)liftUpMoneyGetData
{
    NSLog(@"=====%@", dealDic);
    NSLog(@"zzzzzzzzz%@", [DES3Util decrypt:[dealDic objectForKey:@"dealSecret"]]);
    
    textFieldPassword = (UITextField *)[self.view viewWithTag:9898];
    
    if ([self.moneyString floatValue] < 100) {
        if ([self.moneyString floatValue] > [_textField.text floatValue]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"余额小于100,只能一次全部提出"];
            return;
        }
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"bankCardId":[bankDic objectForKey:@"id"], @"fmoney":_textField.text, @"payPwd":textFieldPassword.text, @"token":[dic objectForKey:@"token"], @"clientType":@"iOS"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/putOff" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self submitLoadingWithHidden:YES];
        NSLog(@"eeeeeeeee提现接口:%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            
//            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
            [UIView animateWithDuration:1.0f animations:^{
               [ZFPView setFrame:CGRectMake((self.view.frame.size.width - 300) / 2.0, 200, 300, 150)];
                ZFPView.sureButton.hidden = YES;
                ZFPView.moneyLabel.text = [responseObject objectForKey:@"resultMsg"];
                ZFPView.moneyLabel.numberOfLines = 0;
                ZFPView.moneyLabel.font = [UIFont systemFontOfSize:12];
                ZFPView.closeButton.hidden = YES;
                ZFPView.moneyTF.hidden = YES;
                ZFPView.worrySureButton.hidden = NO;
                ZFPView.forgetButton.hidden = YES;
                ZFPView.titleLabel.text = @"提示";
            } completion:^(BOOL finished) {
                NSLog(@"123");
            }];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self submitLoadingWithHidden:YES];
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"网络超时,请再次提交"];
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)textFieldLiftUpMoney:(UITextField *)textField
{
    _textField = (UITextField *)[self.view viewWithTag:111111];
    textDeal = (UITextField *)[self.view viewWithTag:9898];
//    && [textFieldPassword.text isEqualToString:[DES3Util decrypt:[dealDic objectForKey:@"dealSecret"]]]
    if ([_textField.text floatValue] == 0.00) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == textFieldPassword) {
        
        if (range.location > 9) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else {
        
        if (range.location > 19) {
            
            return NO;
            
        } else {
            
            return YES;
        }

    }
    
}

//下一步按钮
- (void)buttonNextOneStep:(UIButton *)button
{
    [self.view endEditing:YES];
    
    _textField = (UITextField *)[self.view viewWithTag:111111];
    
    if ([_textField.text floatValue] == 0.00) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"不可以提现0元"];
    } else if ([_textField.text floatValue] > [[[DES3Util decrypt:[self.flagDic objectForKey:@"accBalance"]] stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"余额不足"];
    } else {
        
        viewGray.hidden = NO;
        
        [self.view addSubview:viewGray];
        
        NSBundle *rootBundle = [NSBundle mainBundle];
        
        ZFPView = [[rootBundle loadNibNamed:@"ZFPassword" owner:nil options:nil] lastObject];
        
        [ZFPView setFrame:CGRectMake((self.view.frame.size.width - 300) / 2.0, 200, 300, 200)];
        
        [self.view addSubview:ZFPView];
        
        ZFPView.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_textField.text];
        
        ZFPView.moneyTF.tag = 9898;
        ZFPView.moneyTF.delegate = self;
        
        [ZFPView.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [ZFPView.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [ZFPView.setDealButton addTarget:self action:@selector(setDealSecret:) forControlEvents:UIControlEventTouchUpInside];
        [ZFPView.forgetButton addTarget:self action:@selector(ForgetSecretButton:) forControlEvents:UIControlEventTouchUpInside];
        [ZFPView.worrySureButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[self.dataDic objectForKey:@"setPayPwd"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
            ZFPView.setDealButton.hidden = YES;
            ZFPView.forgetButton.hidden = NO;
            ZFPView.moneyTF.hidden = NO;
            ZFPView.moneyTF.delegate = self;
        }
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        [self.view endEditing:YES];
    }
}

- (void)sureAction:(id)sender{

    textDeal = (UITextField *)[self.view viewWithTag:9898];
    
    if (textDeal.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"支付密码不能为空"];
    } else {
        click ++;
        if (click == 1) {
            [self submitLoadingWithView:self.view loadingFlag:NO height:0];
            
        } else {
            
            [self submitLoadingWithHidden:NO];
        }
        
        if ([_textField.text floatValue] == 0) {
            [self submitLoadingWithHidden:YES];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"提现金额不能为0元"];
            return;
        }
        
        [self liftUpMoneyGetData];
    }
}

- (void)closeAction:(id)sender{
    [self.view endEditing:YES];
    viewGray.hidden = YES;
    ZFPView.hidden = YES;
    
}

#pragma mark 网络请求获得我的绑定的银行卡号
#pragma mark --------------------------------

- (void)getData
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
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
        } else {
            
            self.dataDic = [NSDictionary dictionary];
            self.dataDic = [responseObject objectForKey:@"User"];
            
            bankDic = [self.dataDic objectForKey:@"BankCard"];
            
            if (![[self.dataDic objectForKey:@"realNameStatus"] isEqualToNumber:[NSNumber numberWithInt:2]]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"为了您的账号安全,请先实名认证和绑卡" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"去完善",nil];
                // optional - add more buttons:
                alert.tag = 9201;
                [alert show];
                
            } else if (bankDic.count == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先绑定银行卡,再充值" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"去绑卡",nil];
                // optional - add more buttons:
                alert.tag = 9202;
                [alert show];
                
            } else {
                [self tabelViewShow];
                
            }
            
            [_tabelView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 9201) {
        if (buttonIndex == 1) {
            RealNameViewController *realNameVC = [[RealNameViewController alloc] init];
            pushVC(realNameVC);
        } else {
            popVC;
        }
        
    } else if (alertView.tag == 9202){
        if (buttonIndex == 1) {
            AddBankViewController *addBVC = [[AddBankViewController alloc] init];
            addBVC.realNameStatus = YES;
            pushVC(addBVC);
        } else {
            popVC;
        }
        
    }
}

//textField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 375) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            ZFPView.frame = CGRectMake((self.view.frame.size.width - 300) / 2.0, 64, 300, 200);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            ZFPView.frame = CGRectMake((self.view.frame.size.width - 300) / 2.0, 64, 300, 200);
            
        } completion:^(BOOL finished) {
            
        }];
    } else {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            ZFPView.frame = CGRectMake((self.view.frame.size.width - 300) / 2.0, 5, 300, 200);
            
        } completion:^(BOOL finished) {
            
        }];
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
