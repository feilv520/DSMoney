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
#import "GiveMoneyFinish.h"
#import "RealNameViewController.h"
#import "ChongZhiZZZZView.h"
#import "ChongZhiViewController.h"
#import "BannerViewController.h"

@interface RechargeAlreadyBinding () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

{
    UITableView *_tabelView;
    UIButton *buttonNext;
    
    NSInteger seconds;
    NSTimer *timer;
    
    NSDictionary *bankDic;
    
    NSString *ownerOrder;
    
    NSString *tranId;
    NSString *tranCode;
    
    NSString *bankCardId;
    UITextField *_textField;
}

@property (nonatomic, strong) UITextField *textFieldTag;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *orderDic;
@property (nonatomic, strong) LLPaySdk *sdk;

@end

@implementation RechargeAlreadyBinding

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"充值"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrush:) name:@"refrushBK" object:nil];

}

- (void)refrush:(NSNotification *)not{
    [self getData];
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
    
//    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 210, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"由中国银行保障您的账户资金安全"];
//    [self.view addSubview:buttonSafe];
//    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
//    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    ChongZhiZZZZView *chongZV = (ChongZhiZZZZView *)[[rootBundle loadNibNamed:@"ChongZhiZZZZView" owner:nil options:nil] lastObject];
    
    chongZV.frame = CGRectMake(0, 250, WIDTH_CVIEW_DEFAULT, 140);
    
    [self.view addSubview:chongZV];
    
    [chongZV.buttonCZ addTarget:self action:@selector(buttonChongZhi) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonChongZhi{
    ChongZhiViewController *czVC = [[ChongZhiViewController alloc] init];
    pushVC(czVC);
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
        
        cell.labelTitle.text = @"充值金额";
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.textField.placeholder = @"充值金额最小为100元";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor yuanColor];
        cell.textField.tag = 188;
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [cell.textField addTarget:self action:@selector(textAlreadyBinding:) forControlEvents:UIControlEventEditingChanged];
        
        self.textFieldTag = cell.textField;
        self.textFieldTag.delegate = self;
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(cell.textField.frame.size.width - 20, 0, 15, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor yuanColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"元"];
        [cell.textField addSubview:label];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 9) {
        return NO;
    } else {
        return YES;
    }
}

//下一步按钮
- (void)alreadyBindingButton:(UIButton *)button
{
    [self.view endEditing:YES];
    CGFloat shuRu = self.textFieldTag.text.intValue;
//    [self putOn];
    NSLog(@"shuRu = %.2lf",shuRu);
    NSLog(@"textFieldTag.text = %@",self.textFieldTag.text);
    if (self.textFieldTag.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入充值金额,充值金额最小为100元"];
        
    } else if (shuRu >= 100){
//        GiveMoneyVerifyBinding *giveMVB = [[GiveMoneyVerifyBinding alloc] init];
//        giveMVB.money = textFieldTag.text;
//        [self.navigationController pushViewController:giveMVB animated:YES];
        [self putOn];
        
    } else if ([self.textFieldTag.text isEqualToString:@"0"]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"最小金额为100元"];
        
    } else {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"充值金额最小为100元"];
        
    }
}

- (void)textAlreadyBinding:(UITextField *)textField
{
    NSLog(@"%@",self.textFieldTag.text);
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
            
            bankCardId = [bankDic objectForKey:@"id"];
            
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
                [self contentShow];
                
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
            [self.navigationController pushViewController:addBVC animated:YES];
        } else {
            popVC;
        }
        
    }
}

#pragma mark 连连支付按钮
#pragma mark --------------------------------

#pragma mark - 订单支付
- (void)pay:(id)sender{
    
    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    // 进行签名
    NSDictionary *signedOrder = [payUtil signedOrderDic:self.orderDic
                                             andSignKey:kLLPartnerKey];
    
    
    //    [LLPaySdk sharedSdk].sdkDelegate = self;
    
    // TODO: 根据需要使用特定支付方式
    
    // 快捷支付
    //        [[LLPaySdk sharedSdk] presentQuickPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 认证支付
    //    [[LLPaySdk sharedSdk] presentVerifyPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 预授权
    //  [self.sdk presentPreAuthPaySdkInViewController:self withTraderInfo:signedOrder];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    self.sdk = [[LLPaySdk alloc] init];
    self.sdk.sdkDelegate = self;
    [self.sdk presentVerifyPaySdkInViewController:app.tabBarVC withTraderInfo:signedOrder];
    
}

#pragma -mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
// TODO: 开发人员需要根据实际业务调整逻辑
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            msg = @"支付成功";
            
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"])
            {
                //
                //NSString *payBackAgreeNo = dic[@"agreementno"];
                // TODO: 协议号
                //[self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"putOn");
                
                GiveMoneyFinish *giveMoney = [[GiveMoneyFinish alloc] init];
                giveMoney.moneyString = self.textFieldTag.text;
                giveMoney.bankAccount = [[self.dataDic objectForKey:@"BankCard"] objectForKey:@"bankAcc"];
                [self.navigationController pushViewController:giveMoney animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
                
            }
            else if ([result_pay isEqualToString:@"PROCESSING"])
            {
                msg = @"支付单处理中";
            }
            else if ([result_pay isEqualToString:@"FAILURE"])
            {
                msg = @"支付单失败";
            }
            else if ([result_pay isEqualToString:@"REFUND"])
            {
                msg = @"支付单已退款";
            }
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            msg = dic[@"ret_msg"];
        }
            break;
        default:
            break;
    }
    
    NSString *showMsg = [msg stringByAppendingString:[LLPayUtil jsonStringOfObj:dic]];
    
//    [[[UIAlertView alloc] initWithTitle:@"结果"
//                                message:showMsg
//                               delegate:nil
//                      cancelButtonTitle:@"确认"
//                      otherButtonTitles:nil] show];
}

- (NSMutableDictionary *)createOrder{
    
    NSDictionary *dicRealName = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSString *partnerPrefix = @"GCCT"; // TODO: 修改成自己公司前缀
    
    NSString *signType = @"MD5";    // MD5 || RSA || HMAC
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSString *user_id = [dicRealName objectForKey:@"id"]; //
    // user_id，一个user_id标示一个用户
    // user_id为必传项，需要关联商户里的用户编号，一个user_id下的所有支付银行卡，身份证必须相同
    // demo中需要开发测试自己填入user_id, 可以先用自己的手机号作为标示，正式上线请使用商户内的用户编号
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    
    NSString *risk_item = [NSString stringWithFormat:@"{\"frms_ware_category\":\"2009\",\"user_info_mercht_userno\":\"%@\",\"user_info_bind_phone\":\"%@\",\"user_info_dt_register\":\"%@\",\"user_info_full_name\":\"%@\",\"user_info_id_type\":\"0\",\"user_info_id_no\":\"%@\",\"user_info_identify_state\":\"1\",\"user_info_identify_type\":\"4\"}",
                           [dicRealName objectForKey:@"id"],
                           [DES3Util decrypt:[dicRealName objectForKey:@"userPhone"]],
                           [dicRealName objectForKey:@"registerTime"],
                           [dicRealName objectForKey:@"realName"],
                           [dicRealName objectForKey:@"cardNumber"]];
    
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    [param setDictionary:@{
                           @"sign_type":signType,
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
                           @"busi_partner":@"101001",
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
                           @"dt_order":simOrder,
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           //                           @"money_order":@"0.10",
                           //交易金额	money_order	是	Number(8,2)	该笔订单的资金总额，单位为RMB-元。大于0的数字，精确到小数点后两位。 如：49.65
                           @"money_order" : self.textFieldTag.text,
//                           @"money_order" : @"0.01",
                           
                           @"no_order":tranCode,
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
                           @"name_goods":@"订单名",
                           //商品名称	name_goods	否	String(40)
                           @"info_order":simOrder,
                           //订单附加信息	info_order	否	String(255)	商户订单的备注信息
                           @"valid_order":@"10080",
                           //分钟为单位，默认为10080分钟（7天），从创建时间开始，过了此订单有效时间此笔订单就会被设置为失败状态不能再重新进行支付。
                           //                           @"shareing_data":@"201412030000035903^101001^10^分账说明1|201310102000003524^101001^11^分账说明2|201307232000003510^109001^12^分账说明3"
                           // 分账信息数据 shareing_data  否 变(1024)
                           
                           @"notify_url":[NSString stringWithFormat:@"http://www.dslc.cn/payReturn.do?tranId=%@&userId=%@&bankCardId=%@",tranId,user_id,bankCardId],
                           //服务器异步通知地址	notify_url	是	String(64)	连连钱包支付平台在用户支付成功后通知商户服务端的地址，如：http://payhttp.xiaofubao.com/back.shtml
                           
                           //                           @"risk_item":@"{\"user_info_bind_phone\":\"13958069593\",\"user_info_dt_register\":\"20131030122130\"}",
                           @"risk_item":risk_item,
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                           //                           @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130"}],
                           
                           @"user_id": user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           
                           
                           //                           @"flag_modify":@"1",
                           //修改标记 flag_modify 否 String 0-可以修改，默认为0, 1-不允许修改 与id_type,id_no,acct_name配合使用，如果该用户在商户系统已经实名认证过了，则在绑定银行卡的输入信息不能修改，否则可以修改
                           
                           //                           @"card_no":@"6227000783011133646",
                           //银行卡号 card_no 否 银行卡号前置，卡号可以在商户的页面输入
                           
                           //                           @"no_agree":@"2014070900123076",
                           //签约协议号 否 String(16) 已经记录快捷银行卡的用户，商户在调用的时候可以与pay_type一块配合使用
                           }];
    
    BOOL isIsVerifyPay = YES;
    
    if (isIsVerifyPay) {
        
        [param addEntriesFromDictionary:@{
                                          
                                          @"id_no":[dicRealName objectForKey:@"cardNumber"],
                                          //证件号码 id_no 否 String
                                          @"acct_name":[dicRealName objectForKey:@"realName"],
                                          //银行账号姓名 acct_name 否 String
                                          
                                          //                                          @"id_no":@"140621199212052213",
                                          //                                          //证件号码 id_no 否 String
                                          //                                          @"acct_name":@"杨磊磊",
                                          //                                          //银行账号姓名 acct_name 否 String
                                          }];
    }
    
    param[@"oid_partner"] = kLLOidPartner;
    
    return param;
}

#pragma mark 充值接口网络请求
#pragma mark --------------------------------

- (void)putOn{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    // 注意要修改
    NSDictionary *parameter = @{@"fmoney":self.textFieldTag.text,@"token":[dic objectForKey:@"token"],@"bankCardId":bankCardId,@"clientType":@"iOS"};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/putOn" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"putOn = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
            tranId = [responseObject objectForKey:@"tranId"];
            tranCode = [responseObject objectForKey:@"tranCode"];
            
            self.orderDic = [self createOrder];
            [self pay:nil];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
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
