//
//  GiveMoneyVerifyBinding.m
//  DSLC
//
//  Created by ios on 15/11/6.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "GiveMoneyVerifyBinding.h"
#import "MendDeal2Cell.h"
#import "GiveMoneyFinish.h"

@interface GiveMoneyVerifyBinding () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    UITextField *_textField;
    UIButton *butGive;
    
    UITextField *textFieldCode;
    
    NSInteger seconds;
    NSTimer *timer;
}

@property (nonatomic, strong) NSMutableDictionary *orderDic;
@property (nonatomic, strong) LLPaySdk *sdk;

@end

@implementation GiveMoneyVerifyBinding

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.orderDic = [self createOrder];
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"付款验证"];
    seconds = 60;
    
    [self contentShow];
}

- (void)contentShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 80)];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor whiteColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MendDeal2Cell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    butGive = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 190, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"充值"];
    [self.view addSubview:butGive];
    butGive.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butGive addTarget:self action:@selector(giveMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelPhone = [CreatView creatWithLabelFrame:CGRectMake(15, 20, WIDTH_CONTROLLER_DEFAULT - 30, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewHead addSubview:labelPhone];
    NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc] initWithString:@"本次交易需要短信确认,校验码已发送至您的手机\n159****2599"];
    NSRange range = NSMakeRange([[phoneStr string] length] - 11, 11);
    [phoneStr addAttribute:NSForegroundColorAttributeName value:[UIColor chongzhiColor] range:range];
    [labelPhone setAttributedText:phoneStr];
    labelPhone.numberOfLines = 2;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        labelPhone.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    }
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 79.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5)];
    [viewHead addSubview:labelLine];
    labelLine.backgroundColor = [UIColor grayColor];
    labelLine.alpha = 0.5;
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
    MendDeal2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = @"验证码";
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = @"请输入验证码";
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.textField.tag = 308;
    cell.textField.delegate = self;
    [cell.textField addTarget:self action:@selector(bindingBankTextField:) forControlEvents:UIControlEventEditingChanged];
    
    [cell.buttonGet setTitle:@"获取验证码" forState:UIControlStateNormal];
    [cell.buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
    cell.buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.buttonGet.layer.cornerRadius = 3;
    cell.buttonGet.layer.masksToBounds = YES;
    cell.buttonGet.tag = 777777;
    cell.buttonGet.layer.borderColor = [[UIColor daohanglan] CGColor];
    cell.buttonGet.layer.borderWidth = 0.5;
    [cell.buttonGet addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//充值按钮
- (void)giveMoney:(UIButton *)button
{
    textFieldCode = (UITextField *)[self.view viewWithTag:308];
    
    if (textFieldCode.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入验证码"];
        
    } else if (textFieldCode.text.length != 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"验证码错误"];
        
    } else {
        
        [self pay:nil];
        
    }
    
}

- (void)bindingBankTextField:(UITextField *)textField
{
    if (textField.text.length == 6) {
        
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 6) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

//获取验证码
- (void)getCode:(UIButton *)button
{
    [self.view endEditing:YES];
    
    textFieldCode = (UITextField *)[self.view viewWithTag:1000];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    NSDictionary *parameters = @{@"phone":[DES3Util decrypt:[dic objectForKey:@"userPhone"]],@"msgType":@"3"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getSmsCode" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:777777];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor daohanglan].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        [button setTitle:@"获取验证码" forState: UIControlStateNormal];
        [button setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        [button setEnabled:YES];
    }else{
        seconds--;
        NSString *title = [NSString stringWithFormat:@"重新发送(%lds)",(long)seconds];
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor zitihui].CGColor;
        button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setEnabled:NO];
    }
}

- (void)releaseTImer {
    if (timer) {
        if ([timer respondsToSelector:@selector(isValid)]) {
            if ([timer isValid]) {
                [timer invalidate];
                seconds = 60;
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
                [self putOn];
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
    
    [[[UIAlertView alloc] initWithTitle:@"结果"
                                message:showMsg
                               delegate:nil
                      cancelButtonTitle:@"确认"
                      otherButtonTitles:nil] show];
}

- (NSMutableDictionary *)createOrder{
    
    NSString *partnerPrefix = @"GCCT"; // TODO: 修改成自己公司前缀
    
    NSString *signType = @"MD5";    // MD5 || RSA || HMAC
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSString *user_id = [dic objectForKey:@"id"]; //
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
                           @"sign_type":signType,
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
                           @"busi_partner":@"101001",
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
                           @"dt_order":simOrder,
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           //                           @"money_order":@"0.10",
                           //交易金额	money_order	是	Number(8,2)	该笔订单的资金总额，单位为RMB-元。大于0的数字，精确到小数点后两位。 如：49.65
                           @"money_order" : @"0.01",
                           
                           @"no_order":[NSString stringWithFormat:@"%@%@",partnerPrefix,  simOrder],
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
                           @"name_goods":@"订单名",
                           //商品名称	name_goods	否	String(40)
                           @"info_order":simOrder,
                           //订单附加信息	info_order	否	String(255)	商户订单的备注信息
                           @"valid_order":@"10080",
                           //分钟为单位，默认为10080分钟（7天），从创建时间开始，过了此订单有效时间此笔订单就会被设置为失败状态不能再重新进行支付。
                           //                           @"shareing_data":@"201412030000035903^101001^10^分账说明1|201310102000003524^101001^11^分账说明2|201307232000003510^109001^12^分账说明3"
                           // 分账信息数据 shareing_data  否 变(1024)
                           
                           @"notify_url":@"http://www.baidu.com",
                           //服务器异步通知地址	notify_url	是	String(64)	连连钱包支付平台在用户支付成功后通知商户服务端的地址，如：http://payhttp.xiaofubao.com/back.shtml
                           
                           
                           @"risk_item":@{@"user_info_bind_phone":@"13354288036"},
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                           @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130"}],
                           
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
                                          
                                          @"id_no":@"220204199204180655",
                                          //证件号码 id_no 否 String
                                          @"acct_name":@"马成铭",
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
    
    textFieldCode = (UITextField *)[self.view viewWithTag:308];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    // 注意要修改
    NSDictionary *parameter = @{@"fmoney":self.money,@"bankCardId":@"",@"smsCode":textFieldCode.text,@"payPwd":@"",@"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/putOn" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            GiveMoneyFinish *giveMoney = [[GiveMoneyFinish alloc] init];
            [self.navigationController pushViewController:giveMoney animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
