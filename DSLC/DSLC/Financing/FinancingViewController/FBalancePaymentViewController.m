//
//  FBalancePaymentViewController.m
//  DSLC
//
//  Created by ios on 15/10/14.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FBalancePaymentViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "CashOtherFinViewController.h"
#import "ShareHaveRedBag.h"
#import "ForgetSecretViewController.h"
#import "FindDealViewController.h"
#import "LLPayUtil.h"


@interface FBalancePaymentViewController () <UITextFieldDelegate, LLPaySdkDelegate>

@property (nonatomic, retain) NSMutableDictionary *orderDic;

@property (nonatomic, strong) LLPaySdk *sdk;

@end

#pragma mark - 创建订单

/*
 正式环境 认证支付测试商户号  201408071000001543
 MD5 key  201408071000001543test_20140812
 
 正式环境 快捷支付测试商户号  201408071000001546
 MD5 key  201408071000001546_test_20140815
 */

// TODO: 修改两个参数成商户自己的配置
static NSString *kLLOidPartner = @"201408071000001543";   // 商户号
static NSString *kLLPartnerKey = @"201408071000001543test_20140812";   // 密钥

@implementation FBalancePaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.orderDic = [self createOrder];
    
    self.view.backgroundColor = [UIColor huibai];
    
    self.navigationItem.title = @"支付";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self showContent];
    [self showNavigationBarItem];
}

//导航栏返回按钮
- (void)showNavigationBarItem
{
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBackLeftButton:)];
    [imageReturn addGestureRecognizer:tap];
}

- (void)showContent
{
    self.labelMonth1.text = self.productName;
    self.labelMonth1.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    self.labelLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine1.alpha = 0.7;
    
    NSMutableAttributedString *qianshuStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 元",self.moneyString]];
    NSRange yuanStr = NSMakeRange(0, [[qianshuStr string] rangeOfString:@"元"].location);
    [qianshuStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:yuanStr];
    [qianshuStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:26] range:yuanStr];
    NSRange oneStr = NSMakeRange([[qianshuStr string] length] - 1, 1);
    [qianshuStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:oneStr];
    [self.lableThounand setAttributedText:qianshuStr];
    self.lableThounand.textAlignment = NSTextAlignmentCenter;
    
    self.textFieldSecret.placeholder = @"请输入交易密码";
    self.textFieldSecret.secureTextEntry = YES;
    self.textFieldSecret.font = [UIFont systemFontOfSize:14];
    self.textFieldSecret.tintColor = [UIColor grayColor];
    self.textFieldSecret.delegate = self;
    [self.textFieldSecret addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.butPayment setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [self.butPayment setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [self.butPayment setTitle:@"支付" forState:UIControlStateNormal];
    self.butPayment.titleLabel.font  = [UIFont systemFontOfSize:15];
    [self.butPayment addTarget:self action:@selector(cashMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
        
    self.labelSecret.text = @"支付密码";
    self.labelSecret.font = [UIFont systemFontOfSize:15];
    
    [self.butForget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.butForget setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.butForget.titleLabel.font = [UIFont systemFontOfSize:15];
    self.butForget.backgroundColor = [UIColor clearColor];
    [self.butForget addTarget:self action:@selector(ForgetSecretButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lableLine2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.lableLine2.alpha = 0.7;
    
    self.labelLine3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine3.alpha = 0.7;
    
    self.labelLine4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine4.alpha = 0.7;
}

//忘记密码?按钮
- (void)ForgetSecretButton:(UIButton *)button
{
    FindDealViewController *findSecretVC = [[FindDealViewController alloc] init];
    [self.navigationController pushViewController:findSecretVC animated:YES];
}

#pragma textFieldDalagate
#pragma --------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location == 20){

        return  NO;
        
    } else {
        
        return YES;
    }
}

//最终的支付按钮
- (void)cashMoneyButton:(UIButton *)button
{
    [self.textFieldSecret resignFirstResponder];
    
    if (self.textFieldSecret.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入支付密码"];
        
    } else {
//        [self pay:nil];
        [self buyProduct];
        //        支付有红包
        //        ShareHaveRedBag *shareHave = [[ShareHaveRedBag alloc] init];
        //        [self.navigationController pushViewController:shareHave animated:YES];
        
    }
}

//返回按钮
- (void)returnBackLeftButton:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 判断字符串长度
- (void)textLengthChange:(UITextField *)textField
{
    if ( self.textFieldSecret.text.length > 5 && self.textFieldSecret.text.length < 21) {
        
        [self.butPayment setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [self.butPayment setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [self.butPayment setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [self.butPayment setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)buyProduct{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter;
    
    if ([self.redbagModel rpID] == nil){
        parameter = @{@"productId":self.idString,@"packetId":@"",@"orderMoney":self.moneyString,@"payMoney":@0,@"payType":@1,@"payPwd":self.textFieldSecret.text,@"token":[dic objectForKey:@"token"]};
    } else {
        parameter = @{@"productId":self.idString,@"packetId":[self.redbagModel rpID],@"orderMoney":self.moneyString,@"payMoney":@0,@"payType":@1,@"payPwd":self.textFieldSecret.text,@"token":[dic objectForKey:@"token"]};
    }
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/buyProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"buyProduct = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
            if ([self.redbagModel rpID] == nil) {
//              支付没有红包
                CashOtherFinViewController *cashOther = [[CashOtherFinViewController alloc] init];
                cashOther.nHand = self.nHand;
                cashOther.moneyString = self.moneyString;
                cashOther.syString = self.syString;
                cashOther.endTimeString = self.endTimeString;
                cashOther.productName = self.productName;
                [self.navigationController pushViewController:cashOther animated:YES];
            } else {
//              支付有红包
                ShareHaveRedBag *shareHave = [[ShareHaveRedBag alloc] init];
                shareHave.nHand = self.nHand;
                shareHave.redbagModel = self.redbagModel;
                shareHave.moneyString = self.moneyString;
                shareHave.syString = self.syString;
                shareHave.endTimeString = self.endTimeString;
                shareHave.productName = self.productName;
                [self.navigationController pushViewController:shareHave animated:YES];
//                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"支付成功"];
            }
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
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

- (NSMutableDictionary*)createOrder{
    
    NSString *partnerPrefix = @"DSLC"; // TODO: 修改成自己公司前缀
    
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
                           
                           
                           //                           @"risk_item":@"{\"user_info_bind_phone\":\"13958069593\",\"user_info_dt_register\":\"20131030122130\"}",
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                           @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130"}],
                           
                           @"user_id": user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           
                           
                           //                           @"flag_modify":@"1",
                           //修改标记 flag_modify 否 String 0-可以修改，默认为0, 1-不允许修改 与id_type,id_no,acct_name配合使用，如果该用户在商户系统已经实名认证过了，则在绑定银行卡的输入信息不能修改，否则可以修改
                           
                           //                           @"card_no":@"6227001540670034271",
                           //银行卡号 card_no 否 银行卡号前置，卡号可以在商户的页面输入
                           
                           //                           @"no_agree":@"2014070900123076",
                           //签约协议号 否 String(16) 已经记录快捷银行卡的用户，商户在调用的时候可以与pay_type一块配合使用
                           }];
    
    BOOL isIsVerifyPay = YES;
    
    if (isIsVerifyPay) {
        
        [param addEntriesFromDictionary:@{
                                          @"id_no":@"140621199212052213",
                                          //证件号码 id_no 否 String
                                          @"acct_name":@"杨磊磊",
                                          //银行账号姓名 acct_name 否 String
                                          }];
    }
    
    
    
    
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
