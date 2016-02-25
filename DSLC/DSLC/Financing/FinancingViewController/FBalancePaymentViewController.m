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
#import "SetDealSecret.h"


@interface FBalancePaymentViewController () <UITextFieldDelegate>{
    NSInteger count;
}

@property (nonatomic, strong) UIButton *buttonSet;

@end

#pragma mark - 创建订单

@implementation FBalancePaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor huibai];
    
    count = 0;
    
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
    self.textFieldSecret.hidden = YES;
    self.textFieldSecret.font = [UIFont systemFontOfSize:14];
    self.textFieldSecret.tintColor = [UIColor grayColor];
    self.textFieldSecret.delegate = self;
    [self.textFieldSecret addTarget:self action:@selector(textLengthChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.buttonSet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(100, 12, 90, 21) backgroundColor:[UIColor clearColor] textColor:[UIColor chongzhiColor] titleText:@"设置交易密码"];
    self.buttonSet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    [self.buttonSet addTarget:self action:@selector(setDealSecret:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewDianDi addSubview:self.buttonSet];
    
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
    self.butForget.hidden = YES;
    [self.butForget addTarget:self action:@selector(ForgetSecretButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lableLine2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.lableLine2.alpha = 0.7;
    
    self.labelLine3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine3.alpha = 0.7;
    
    self.labelLine4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelLine4.alpha = 0.7;
    
    if (self.dealPanDuan.intValue == 0) {
        
        NSLog(@"%@", self.dealPanDuan);
        self.buttonSet.hidden = NO;
        
    } else {
        
        self.butForget.hidden = NO;
        self.textFieldSecret.hidden = NO;
        self.buttonSet.hidden = YES;
    }
}

//设置交易密码
- (void)setDealSecret:(UIButton *)button
{
    SetDealSecret *deal = [[SetDealSecret alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDealSecretNotice:) name:@"setDeal" object:nil];
    
    [self.navigationController pushViewController:deal animated:YES];
}

- (void)setDealSecretNotice:(NSNotification *)notice
{
    self.buttonSet.hidden = YES;
    self.butForget.hidden = NO;
    self.textFieldSecret.hidden = NO;
}

//忘记密码?按钮
- (void)ForgetSecretButton:(UIButton *)button
{
    FindDealViewController *findSecretVC = [[FindDealViewController alloc] init];
    findSecretVC.whichOne = NO;
    [self.navigationController pushViewController:findSecretVC animated:YES];
}

#pragma textFieldDalagate
#pragma -----------------

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
        if (++count == 1) {
            [self submitLoadingWithView:self.view loadingFlag:NO height:0];
        } else {
            [self submitLoadingWithHidden:NO];
        }
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
        parameter = @{@"productId":self.idString,@"packetId":@"",@"orderMoney":self.moneyString,@"payMoney":@0,@"payType":@1,@"payPwd":self.textFieldSecret.text,@"token":[dic objectForKey:@"token"],@"clientType":@"iOS"};
    } else {
        parameter = @{@"productId":self.idString,@"packetId":[self.redbagModel rpID],@"orderMoney":self.moneyString,@"payMoney":@0,@"payType":@1,@"payPwd":self.textFieldSecret.text,@"token":[dic objectForKey:@"token"],@"clientType":@"iOS"};
    }
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/buyProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"buyProduct = %@",responseObject);
        [self submitLoadingWithHidden:YES];
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
