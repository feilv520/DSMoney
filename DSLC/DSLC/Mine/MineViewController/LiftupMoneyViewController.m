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

@interface LiftupMoneyViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

{
    UITableView *_tabelView;
    NSArray *everyArr;
    UILabel *labelLineDown;
    UIButton *buttonNext;
    UITextField *_textField;
    
    NSDictionary *bankDic;
    
    NSString *ownerOrder;
    
    UITextField *textFieldPassword;
    
    NSDictionary *dealDic;
    NSInteger click;
}

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *orderDic;
@property (nonatomic, strong) LLPaySdk *sdk;

@end

@implementation LiftupMoneyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"提现"];
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
    
    UIView *viewWite = [CreatView creatViewWithFrame:CGRectMake(0, 8, WIDTH_CONTROLLER_DEFAULT, 166) backgroundColor:[UIColor whiteColor]];
    [viewFoot addSubview:viewWite];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(10, 15, WIDTH_CONTROLLER_DEFAULT - 20, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"温馨提示"];
    [viewWite addSubview:labelAlert];
    
    everyArr = @[@"1.您拥有每日3次的提现机会;", @"2.提现无限额;", @"3.提现手续费为0;", @"4.若体现后账户余额低于100元,则需一次提完．"];
    
    for (int i = 0; i < 4; i++) {
        
        UILabel *labelEvery = [CreatView creatWithLabelFrame:CGRectMake(10, 45 + 29 * i, WIDTH_CONTROLLER_DEFAULT - 20, 29) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[everyArr objectAtIndex:i]];
        [viewWite addSubview:labelEvery];
    }
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 165.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
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
    
//    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 245, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"由中国银行保障您的账户资金安全"];
//    [viewFoot addSubview:buttonSafe];
//    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
//    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        
    } else if (indexPath.row == 1){
        
        AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.labelTitle.text = @"提现金额";
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.textField.placeholder = @"请输入提现金额";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor yuanColor];
        cell.textField.tag = 111111;
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [cell.textField addTarget:self action:@selector(textFieldLiftUpMoney:) forControlEvents:UIControlEventEditingChanged];
        
        _textField = cell.textField;
        
        if ([self.moneyString floatValue] < 100.0) {
            cell.textField.text = self.moneyString;
        }
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(cell.textField.frame.size.width - 20, 0, 15, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor yuanColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"元"];
        [cell.textField addSubview:label];
        
        [cell addSubview:labelLineDown];
        labelLineDown.backgroundColor = [UIColor grayColor];
        labelLineDown.alpha = 0.3;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        TTTTXianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        
        NSLog(@"dealSecret = %@",[self.dataDic objectForKey:@"setPayPwd"]);
        
        if ([[self.dataDic objectForKey:@"setPayPwd"] isEqualToNumber:[NSNumber numberWithInt:1]]) {
            cell.setPassword.hidden = YES;
            cell.forget.hidden = NO;
            cell.password.hidden = NO;
        }
        
        textFieldPassword = cell.password;
        
        [cell.setPassword addTarget:self action:@selector(setDealSecret:) forControlEvents:UIControlEventTouchUpInside];
        [cell.forget addTarget:self action:@selector(ForgetSecretButton:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    if ([self.moneyString floatValue] < 100) {
        if ([self.moneyString floatValue] > [_textField.text floatValue]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"余额小于100,只能一次全部提出"];
            return;
        }
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"bankCardId":[bankDic objectForKey:@"id"], @"fmoney":_textField.text, @"payPwd":textFieldPassword.text, @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/putOff" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self submitLoadingWithHidden:YES];
        NSLog(@"eeeeeeeee提现接口:%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [self.navigationController popViewControllerAnimated:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
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
//    && [textFieldPassword.text isEqualToString:[DES3Util decrypt:[dealDic objectForKey:@"dealSecret"]]]
    if (_textField.text.length > 0 ) {
        
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
        
    }
//    else if ([textFieldPassword.text isEqualToString:[DES3Util decrypt:[dealDic objectForKey:@"dealSecret"]]]){
//        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"支付密码输入不正确"];
//    }
    else if (_textField.text.length > 0) {
        
        click ++;
        if (click == 1) {
            [self submitLoadingWithView:self.view loadingFlag:NO height:0];
            
        } else {
            
            [self submitLoadingWithHidden:NO];
        }

        [self liftUpMoneyGetData];
//        [self pay:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        [self.view endEditing:YES];
    }
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

#pragma mark 连连支付按钮
#pragma mark --------------------------------

#pragma mark - 订单支付
- (void)pay:(id)sender{
    
//    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    NSDictionary *parameters = [self createOrder];
    // 进行签名
//    NSDictionary *signedOrder = [payUtil signedOrderDic:parameters
//                                             andSignKey:@"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJPb6UtHkRtCmunLtxgWUUkqKVMqdMrvLxU4UzTRaNddI2tHUszyTSntfz+l1S3BjRBvjx1/yvrFRvneW7lmM9w+e5LPUnIhqnNrl2aeioOJWHz+Ba6qrRXz8kCf6kfsAMG4H2A2xMcb26ZiMPZxFKHinuKcW7bT+bXTFxrQsR/JAgMBAAECgYEAh2vK6F/LzyPZrngeYblPCavL3ZftEFCw1saXrrB9TYLIheD1PTBO7C/RdAH2lcnH4V3LvkDlL3iv4Pp/F/c7Vvvgs/LbpXwnPvYVtdkZ1x3AZRfS/5uSrSoAkiN0zEJnmb3Ywp7YlCYfVlke4u6dhQN+WxvqPl69VMBzNpagXWECQQDlBVUvIqQp6e0Gsp4oOj3HyQtCT+BsaRZkLtMNTq5pcz/83s1H0cIoU8dTT7LCZvRw+yjYgQ5YBY9D0CZBmwdfAkEApUbzmt2klNpf2apadyI+fYcbYBky3kb2q6YZ/xQuCU8eSJC4F2bPDDfxpsIqADj5A8KB74EnB6h1UT9rQONx1wJBAMXuFfDmv3p58aAYPxgFPd+soU5uOkd3iyKKVVzq41G/iU3CQSgQ4Px5a4tVFeltkVUTu/lhkEQCig7Rlj6c/YECQHwqUIrQ5nsZj5bDv1Du/glp/ev1Il0Q7PHJSJB0RZ2ivbqAVnzmNLgWM0o3ZjxikNj9QIaA/aRoLzLJtTa7aGMCQFEkTk/9gIYYKolMwMllO/SN+dO54W1Pc/Dx65ZsEwzgq+UEBb0BjbxbVebVRcaXam6OKIuCW2KwdQuMlY6AqeQ="];
    
    NSLog(@"signedOrder = %@",parameters);
    
    //    [LLPaySdk sharedSdk].sdkDelegate = self;
    
    // TODO: 根据需要使用特定支付方式
    
    // 快捷支付
    //        [[LLPaySdk sharedSdk] presentQuickPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 认证支付
    //    [[LLPaySdk sharedSdk] presentVerifyPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 预授权
    //  [self.sdk presentPreAuthPaySdkInViewController:self withTraderInfo:signedOrder];
    
//    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
//    self.sdk = [[LLPaySdk alloc] init];
//    self.sdk.sdkDelegate = self;
//    [self.sdk presentVerifyPaySdkInViewController:app.tabBarVC withTraderInfo:signedOrder];

    
    
    [[MyAfHTTPClient sharedClient] postWithURLStringP:nil parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

- (NSMutableDictionary *)createOrder{
    
//    NSDictionary *dicRealName = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSString *partnerPrefix = @"GCCT"; // TODO: 修改成自己公司前缀
    
    NSString *signType = @"RSA";    // MD5 || RSA || HMAC
    
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
//    NSString *user_id = [NSString stringWithFormat:@"gcctdslcandroid%@",[dicRealName objectForKey:@"id"]]; //
    // user_id，一个user_id标示一个用户
    // user_id为必传项，需要关联商户里的用户编号，一个user_id下的所有支付银行卡，身份证必须相同
    // demo中需要开发测试自己填入user_id, 可以先用自己的手机号作为标示，正式上线请使用商户内的用户编号
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    [param setDictionary:@{
                           @"flag_card":@"0",
                           @"sign_type":[NSString stringWithFormat:@"%@",signType],
                           @"sign":@"H7aw88qS+SBlOC9qxspmY/Nk79ea9zAjggWOWXblFxAgOYhNeVfeW/t8r47xoL8jd9bkYMAbldU5LV4ccWjm9sWlDrzhYDBSdp/PpxXXNAdXoBpMj9elBf0QgC/nfeWHUs7BMTwiy28mIHjyo5LZ2kiYWO53zW9Mo92s99YcFUI=",
                           
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
//                           @"card_no":[bankDic objectForKey:@"cardAccount"],
                           @"card_no":@"6214830219956587",
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
//                           @"dt_order":[NSString stringWithFormat:@"%@",simOrder],
                           @"dt_order":@"20151223010117",
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           @"money_order":@"0.01",
//                               _textField.text
                           //交易金额	money_order	是	Number(8,2)	该笔订单的资金总额，单位为RMB-元。大于0的数字，精确到小数点后两位。 如：49.65
//                           @"acct_name" : [self.flagDic objectForKey:@"realName"],
                           
                           @"acct_name":@"刘盼阳",
                           
//                           @"no_order":[NSString stringWithFormat:@"%@%@",partnerPrefix,  simOrder],
                           @"no_order":@"20151223010117",
                           
                           @"bank_code":@"03080000",
                           @"province_code":@"330000",
                           @"city_code":@"310000",
//                           @"brabank_name":@"中国工商银行杭州市文三路支行",
                           @"brabank_name":@"",
                           
                           
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
//                           @"name_goods":@"订单名",
                           //商品名称	name_goods	否	String(40)
//                           @"info_order":simOrder,
                           @"info_order":@"提现",
                           //订单附加信息	info_order	否	String(255)	商户订单的备注信息
//                           @"valid_order":@"10080",
                           //分钟为单位，默认为10080分钟（7天），从创建时间开始，过了此订单有效时间此笔订单就会被设置为失败状态不能再重新进行支付。
                           //                           @"shareing_data":@"201412030000035903^101001^10^分账说明1|201310102000003524^101001^11^分账说明2|201307232000003510^109001^12^分账说明3"
                           // 分账信息数据 shareing_data  否 变(1024)
                           
                           @"notify_url":@"http://localhost:8080/tongjiang/accountInfo/txBack&oid_partner=201512161000642725&province_code=310000&sign_type=RSA&user_id=9453",
                           //服务器异步通知地址	notify_url	是	String(64)	连连钱包支付平台在用户支付成功后通知商户服务端的地址，如：http://payhttp.xiaofubao.com/back.shtml
                           
                           @"api_version":@"1.2",
                           
                           //                           @"risk_item":@"{\"user_info_bind_phone\":\"13958069593\",\"user_info_dt_register\":\"20131030122130\"}",
//                           @"risk_item":[NSString stringWithFormat:@"{\"user_info_bind_phone\":\"%@\"}",[dic objectForKey:@"account"]],
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                           //                           @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130"}],
                           
//                           @"user_id": user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           
                           
                           //                           @"flag_modify":@"1",
                           //修改标记 flag_modify 否 String 0-可以修改，默认为0, 1-不允许修改 与id_type,id_no,acct_name配合使用，如果该用户在商户系统已经实名认证过了，则在绑定银行卡的输入信息不能修改，否则可以修改
                           
                           //                           @"card_no":@"6227000783011133646",
                           //银行卡号 card_no 否 银行卡号前置，卡号可以在商户的页面输入
                           
                           //                           @"no_agree":@"2014070900123076",
                           //签约协议号 否 String(16) 已经记录快捷银行卡的用户，商户在调用的时候可以与pay_type一块配合使用
                           }];
    
//    BOOL isIsVerifyPay = YES;
    
//    if (isIsVerifyPay) {
//        
//        [param addEntriesFromDictionary:@{
//                                          
//                                          @"id_no":[dicRealName objectForKey:@"cardNumber"],
//                                          //证件号码 id_no 否 String
//                                          @"acct_name":[dicRealName objectForKey:@"realName"],
//                                          //银行账号姓名 acct_name 否 String
//                                          
//                                          //                                          @"id_no":@"140621199212052213",
//                                          //                                          //证件号码 id_no 否 String
//                                          //                                          @"acct_name":@"杨磊磊",
//                                          //                                          //银行账号姓名 acct_name 否 String
//                                          }];
//    }
    
    param[@"oid_partner"] = kLLOidPartner;
    
    return param;
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
