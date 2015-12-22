//
//  AddBankViewController.m
//  DSLC
//
//  Created by ios on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AddBankViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "AddBankCell.h"
#import "VerifyViewController.h"
#import "MendDeal2Cell.h"
#import "ChooseOpenAnAccountBank.h"
#import "City.h"
#import "BankName.h"

@interface AddBankViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *textFieldArr;
    UIImageView *imageViewRight;
    UIImageView *imageRight;
    UIImageView *imageRightView;
    UILabel *labelChoose;
    UIButton *buttonGet;
    UIButton *buttonNext;
    
    UITextField *textFieldZero;
    UITextField *textFieldOne;
    UITextField *textFieldTwo;
    UITextField *textFieldThree;
    UITextField *textFieldFour;
    UITextField *textFieldFive;
    UITextField *textFieldSix;
    UITextField *textFieldSeven;
    
    NSInteger seconds;
    NSTimer *timer;
    
    NSDictionary *dicRealName;
    
    City *city;
    City *cityS;
    BankName *bankName;
    
    //第三方返回的字段
    NSString *ownerOrder;
}

@property (nonatomic) LLPaySdk *sdk;
@property (nonatomic) NSMutableDictionary *orderDic;

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    seconds = 60;
    dicRealName = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"绑定银行卡"];
    [self showViewControllerContent];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnBankName:) name:@"bank" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnCityWithPName:) name:@"cityP" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnCityWithSName:) name:@"cityS" object:nil];
}

- (void)buttonReturn:(UIBarButtonItem *)bar{
    NSArray *viewController = [self.navigationController viewControllers];
    
    NSLog(@"viewController = %@",viewController);
    
    if (self.realNameStatus == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        [self.navigationController popToViewController:[viewController objectAtIndex:2] animated:YES];
        
    }
}

- (void)returnBankName:(NSNotification *)notice
{
    bankName = [notice object];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldTwo.text = bankName.bankName;
    [_tableView reloadData];
}

- (void)returnCityWithPName:(NSNotification *)notice {
    city = [notice object];
    textFieldThree = (UITextField *)[self.view viewWithTag:403];
    textFieldThree.text = city.cityName;
}

- (void)returnCityWithSName:(NSNotification *)notice {
    cityS = [notice object];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFour.text = cityS.cityName;
}

//视图内容
- (void)showViewControllerContent
{
    titleArr = @[@"持卡人", @"银行卡号", @"开户行", @"开户行省",@"开户行市", @"开户行支行",  @"支付金额", @"手机号"];
    textFieldArr = @[[dicRealName objectForKey:@"realName"], @"请输入本人银行卡号", @"请选择开户银行", @"请选择开户所在的省", @"请选择开户所在的市", @"请输入开户行支行", @"0.01元", @"请输入预留在银行的手机号"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 95) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (90.0 / 667.0))];
    _tableView.tableFooterView = view;
    _tableView.backgroundColor = [UIColor huibai];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AddBankCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    imageViewRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    imageRightView = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0))/2, HEIGHT_CONTROLLER_DEFAULT * (47.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (43.0 / 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [view addSubview:buttonNext];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonGet = [UIButton buttonWithType:UIButtonTypeCustom];
}

//下一步按钮
- (void)nextButton:(UIButton *)button
{
    textFieldZero = (UITextField *)[self.view viewWithTag:400];
    textFieldOne = (UITextField *)[self.view viewWithTag:401];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldThree = (UITextField *)[self.view viewWithTag:403];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFive = (UITextField *)[self.view viewWithTag:405];
    textFieldSix = (UITextField *)[self.view viewWithTag:406];
    textFieldSeven = (UITextField *)[self.view viewWithTag:407];
    
    if (textFieldZero.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入持卡人姓名"];
        
    } else if (textFieldTwo.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请选择开户银行"];
        
    } else if (textFieldOne.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入本人银行卡号"];
        
    } else if (![NSString checkCardNo:textFieldOne.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"银行卡号格式错误"];
        
    } else if (textFieldTwo.text.length == 0 || textFieldThree.text.length == 0 || textFieldFour.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请选择开户行,省,市(缺一不可)"];
        
    } else if (textFieldSeven.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (textFieldSeven.text.length != 11) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else {
        self.orderDic = [self createOrder];
        [self pay:nil];
//        [self getBankCard];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 401) {

        if (range.location < 19) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else if (textField.tag == 407) {
        
        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    }
//    else if (textField.tag == 405) {
//        
//        if (range.location == 6) {
//            
//            return NO;
//            
//        } else {
//            
//            return YES;
//        }
//    }
    else {
        
        return YES;
    }
}

- (void)textFieldPress:(UITextField *)textField
{
    textFieldZero = (UITextField *)[self.view viewWithTag:400];
    textFieldOne = (UITextField *)[self.view viewWithTag:401];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldThree = (UITextField *)[self.view viewWithTag:403];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFive = (UITextField *)[self.view viewWithTag:405];
    textFieldSix = (UITextField *)[self.view viewWithTag:406];
    textFieldSeven = (UITextField *)[self.view viewWithTag:407];
    
    if (textFieldZero.text.length > 0 && textFieldOne.text.length > 0 && textFieldThree.text.length > 0 && textFieldFour.text.length > 0 && textFieldTwo.text.length > 0 && textFieldSeven.text.length == 11) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        if (textField.tag == 402) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 404) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 405) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    
                _tableView.contentOffset = CGPointMake(0, 150);
                
            } completion:^(BOOL finished) {
                
            }];
        } else if (textField.tag == 407) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 150);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    } else {
        if (textField.tag == 407) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 150);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (bankName == nil) {
            return 5;
        } else if ([bankName.bankName isEqualToString:@"工商银行"] || [bankName.bankName isEqualToString:@"农业银行"] || [bankName.bankName isEqualToString:@"中国银行"] || [bankName.bankName isEqualToString:@"招商银行"] ||[bankName.bankName isEqualToString:@"光大银行"]) {
            return 5;
        } else {
            return 6;
        }
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10.0;
    }
    return 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
    
    cell.textField.font = [UIFont systemFontOfSize:14];
    cell.textField.tintColor = [UIColor yuanColor];
    cell.textField.delegate = self;
    
    if (indexPath.section == 1)
        cell.textField.tag = indexPath.row + 406;
    else
        cell.textField.tag = indexPath.row + 400;
    
    if (indexPath.section == 0) {
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.textField.text = [textFieldArr objectAtIndex:indexPath.row];
        } else {
            cell.textField.placeholder = [textFieldArr objectAtIndex:indexPath.row];
        }
    } else {
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row + 6];
        if (indexPath.row == 0) {
            cell.textField.text = @"0.01元";
        } else {
            cell.textField.placeholder = [textFieldArr objectAtIndex:indexPath.row + 6];
        }
    }
    
    if (cell.textField.tag == 405) {
        cell.textField.text = @"";
        cell.textField.placeholder = @"请输入开户行支行";
        cell.textField.userInteractionEnabled = YES;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
    }
    
    [cell.textField addTarget:self action:@selector(textFieldPress:) forControlEvents:UIControlEventEditingChanged];
    
    if (indexPath.row == 1 || indexPath.row == 4) {
            
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textField.userInteractionEnabled = NO;
        } else {
            cell.textField.text = @"";
            cell.textField.userInteractionEnabled = YES;
        }
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    } else {
    
        if (indexPath.row == 3) {
                
            [cell addSubview:imageViewRight];
            cell.textField.enabled = NO;
        }
        
        if (indexPath.row == 2) {
            
            [cell addSubview:imageRight];
            cell.textField.enabled = NO;
        }
        
        if (indexPath.row == 4) {
            [cell addSubview:imageRightView];
            cell.textField.enabled = NO;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2 || indexPath.row == 3 ) {
        
        ChooseOpenAnAccountBank *chooseBank = [[ChooseOpenAnAccountBank alloc] init];
        if (indexPath.row == 2) {
            chooseBank.flagSelect = @"2";
        } else if (indexPath.row == 3) {
            chooseBank.flagSelect = @"3";
        }
        [self.navigationController pushViewController:chooseBank animated:YES];
    } else if (indexPath.row == 4) {
        if (city == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请先选择开户行省"];
            return;
        }
        ChooseOpenAnAccountBank *chooseBank = [[ChooseOpenAnAccountBank alloc] init];
        chooseBank.flagSelect = @"4";
        chooseBank.cityCode = city.cityCode;
        
        [self.navigationController pushViewController:chooseBank animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 100) {
        
        [self.view endEditing:YES];
    }
}

//绑定银行卡
- (void)getBankCard
{
    textFieldZero = (UITextField *)[self.view viewWithTag:400];
    textFieldOne = (UITextField *)[self.view viewWithTag:401];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldThree = (UITextField *)[self.view viewWithTag:403];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFive = (UITextField *)[self.view viewWithTag:405];
    textFieldSix = (UITextField *)[self.view viewWithTag:406];
    textFieldSeven = (UITextField *)[self.view viewWithTag:407];
    
    NSLog(@"textFieldFive = %@",textFieldFive.text);
    
    NSDictionary *parmeter;
    if (textFieldFive == nil) {
        parmeter = @{@"userId":[dicRealName objectForKey:@"id"], @"cardName":textFieldTwo.text, @"cardAccount":textFieldOne.text, @"proviceCode":city.cityCode, @"cityCode":cityS.cityCode, @"bankCode":bankName.bankCode, @"phone":textFieldSeven.text, @"bankBranch":@"", @"checkKey":@"ckAixn8sFNhwmmCvkRgjuA=="};
    } else {
        parmeter = @{@"userId":[dicRealName objectForKey:@"id"], @"cardName":textFieldTwo.text, @"cardAccount":textFieldOne.text, @"proviceCode":city.cityCode, @"cityCode":cityS.cityCode, @"bankCode":bankName.bankCode, @"phone":textFieldSeven.text, @"bankBranch":textFieldFive.text, @"checkKey":@"ckAixn8sFNhwmmCvkRgjuA=="};
    }
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/addBankCard" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"7777777绑定银行卡:%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSArray *viewController = [self.navigationController viewControllers];
            
            if (self.realNameStatus == YES) {
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                [self.navigationController popToViewController:[viewController objectAtIndex:2] animated:YES];
                
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushBK" object:nil];
            
        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
                ownerOrder = dic[@"no_order"];
                [self getBankCard];
                
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
    
    NSString *user_id = [dicRealName objectForKey:@"id"]; //
    // user_id，一个user_id标示一个用户
    // user_id为必传项，需要关联商户里的用户编号，一个user_id下的所有支付银行卡，身份证必须相同
    // demo中需要开发测试自己填入user_id, 可以先用自己的手机号作为标示，正式上线请使用商户内的用户编号
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    
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
                           
                           
//                           @"risk_item":@{@"user_info_bind_phone":@"13354288036"},
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                           @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130"}],
                           
                           @"user_id": user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           
                           
                           //                           @"flag_modify":@"1",
                           //修改标记 flag_modify 否 String 0-可以修改，默认为0, 1-不允许修改 与id_type,id_no,acct_name配合使用，如果该用户在商户系统已经实名认证过了，则在绑定银行卡的输入信息不能修改，否则可以修改
                           
                           @"card_no":textFieldOne.text,
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
        NSLog(@"======身份证号:%@", [dicRealName objectForKey:@"cardNumber"]);
    }
    
    
    
    
    param[@"oid_partner"] = kLLOidPartner;
    
    
    return param;
}

- (void)buttonPressOK:(UIButton *)button
{
    NSLog(@"获取验证码");
    [self.view endEditing:YES];
    
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    
    if (textFieldFour.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:textFieldFour.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入手机格式有误"];
        
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        
        NSDictionary *parameters = @{@"phone":textFieldFour.text,@"msgType":@"4"};
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

}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:909090];
    
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
