//
//  TWOLiftMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/19.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOLiftMoneyViewController.h"
#import "TWOProductHuiFuViewController.h"

@interface TWOLiftMoneyViewController () <UITextFieldDelegate>
{
    UITextField *textFieldLift;
    UIButton *buttonNext;
    UIButton *buttBlack;
    UIView *viewThirdOpen;
    UIButton *butLiftAlert;
}
@end

@implementation TWOLiftMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"提现"];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self liftMoneyData];
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 51) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 51, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UILabel *labelLift = [CreatView creatWithLabelFrame:CGRectMake(9, 10, 60, 31) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"提现金额"];
    [viewBottom addSubview:labelLift];
    
    textFieldLift = [CreatView creatWithfFrame:CGRectMake(90, 10, WIDTH_CONTROLLER_DEFAULT - 90 - 10, 31) setPlaceholder:[NSString stringWithFormat:@"可提现%@元", self.moneyString] setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldLift];
    textFieldLift.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldLift.textColor = [UIColor findZiTiColor];
    textFieldLift.delegate = self;
    textFieldLift.keyboardType = UIKeyboardTypeDecimalPad; //带小数点的数字键盘
    [textFieldLift addTarget:self action:@selector(textFieldLiftMoney:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 66, WIDTH_CONTROLLER_DEFAULT - 18, 40) backgroundColor:[UIColor findZiTiColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonNext.layer.cornerRadius = 5;
    buttonNext.layer.masksToBounds = YES;
    [buttonNext addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    butLiftAlert = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 66 + 45, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor orangecolor] titleText:@"你还未投资,需要收取0.3%的手续费,最低每笔2元"];
    [self.view addSubview:butLiftAlert];
    butLiftAlert.hidden = YES;
    butLiftAlert.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butLiftAlert setImage:[UIImage imageNamed:@"充值未投资提现"] forState:UIControlStateNormal];
    [butLiftAlert setImage:[UIImage imageNamed:@"充值未投资提现"] forState:UIControlStateHighlighted];
    
    [self alertContentShow];
}

//按钮背景色
- (void)textFieldLiftMoney:(UITextField *)textField
{
    if (textFieldLift.text.length == 0) {
        buttonNext.backgroundColor = [UIColor findZiTiColor];
        buttonNext.enabled = NO;
    } else {
        buttonNext.backgroundColor = [UIColor profitColor];
        buttonNext.enabled = YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 7) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)alertContentShow
{
    UIView *viewAlert = [CreatView creatViewWithFrame:CGRectMake(9, 66 + 40 + 100, WIDTH_CONTROLLER_DEFAULT - 18, 170) backgroundColor:[UIColor backColor]];
    [self.view addSubview:viewAlert];
    viewAlert.layer.cornerRadius = 5;
    viewAlert.layer.masksToBounds = YES;
    
    if (WIDTH_CONTROLLER_DEFAULT == 414) {
        viewAlert.frame = CGRectMake(9, 66 + 40 + 160, WIDTH_CONTROLLER_DEFAULT - 18, 150);
    }
    
    CGFloat viewWidth = viewAlert.frame.size.width;

    UILabel *labelKindlyReminder  = [CreatView creatWithLabelFrame:CGRectMake(12, 0, viewWidth - 24, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor friendAlert] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"温馨提示:"];
    labelKindlyReminder.alpha = 1.0;
    [viewAlert addSubview:labelKindlyReminder];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        NSArray *contenArray = @[@"1.您每月拥有三次免费提现的机会,超过三次收取2元/笔;", @"2.免费提现次数不累计到下月;", @"3.账户余额(或提现后)低于100元时,须一次性提完;", @"4.首次充值未投资用户,如需直接提现您所充值的金额,需", @"   承担提现金额0.3%的手续费,最低每笔2元(新手专享标", @"   不算投资记录)"];
        
        for (int i = 0; i < 6; i++) {
            UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(12, 40 + i * 20, viewAlert.frame.size.width - 24, 20) backgroundColor:[UIColor backColor] textColor:[UIColor alertColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:11] text:[contenArray objectAtIndex:i]];
            [viewAlert addSubview:labelAlert];
        }
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
        
        NSArray *contenArray = @[@"1.您每月拥有三次免费提现的机会,超过三次收取2元/笔;", @"2.免费提现次数不累计到下月;", @"3.账户余额(或提现后)低于100元时,须一次性提完;", @"4.首次充值未投资用户,如需直接提现您所充值的金额,需", @"   承担提现金额0.3%的手续费,最低每笔2元(新手专享标", @"   不算投资记录)"];
        
        for (int i = 0; i < 6; i++) {
            UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(12, 40 + i * 20, viewAlert.frame.size.width - 24, 20) backgroundColor:[UIColor backColor] textColor:[UIColor alertColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[contenArray objectAtIndex:i]];
            [viewAlert addSubview:labelAlert];
        }
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
        
        NSArray *contenArray = @[@"1.您每月拥有三次免费提现的机会,超过三次收取2元/笔;", @"2.免费提现次数不累计到下月;", @"3.账户余额(或提现后)低于100元时,须一次性提完;", @"4.首次充值未投资用户,如需直接提现您所充值的金额,需承担提现", @"   金额0.3%的手续费,最低每笔2元(新手专享标不算投资记录)。"];
        
        for (int i = 0; i < 5; i++) {
            UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(12, 40 + i * 20, viewAlert.frame.size.width - 24, 20) backgroundColor:[UIColor backColor] textColor:[UIColor alertColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[contenArray objectAtIndex:i]];
            [viewAlert addSubview:labelAlert];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)nextAction:(id)sender
{
    NSString *moneyYu = [self.moneyString stringByReplacingOccurrencesOfString:@"," withString:@""]; //余额
    CGFloat yuEValue = [moneyYu floatValue] - [textFieldLift.text floatValue]; //余额减掉输入金额
    NSLog(@"-------%@", moneyYu);
    
    if (![NSString isPureFloat:textFieldLift.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"你输入的是非法数字"];
        return;
    }
    
    if (textFieldLift.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入提现金额"];
    } else if ([textFieldLift.text floatValue] == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"提现金额不能为0"];
    } else if ([textFieldLift.text floatValue] > [moneyYu floatValue]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"余额不足，请重新输入"];
    } else if ([moneyYu floatValue] < 100.0 && [textFieldLift.text floatValue] < [moneyYu floatValue]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"您的余额低于100元，须一次性提完"];
    } else if (yuEValue < 100.0 && yuEValue != 0.0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"您提现后余额低于100元，须一次性提完"];
    } else {
        
        if ([[self.flagDic objectForKey:@"chinaPnrAcc"] isEqualToString:@""]) {
            [self.view endEditing:YES];
            [self registThirdShow];
            return;
        }
        
        TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
        productHuiFuVC.fuctionName = @"cash";
        productHuiFuVC.moneyString = textFieldLift.text;
        pushVC(productHuiFuVC);
    }
}

//开通托管账户弹框
- (void)registThirdShow
{
    AppDelegate *app  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    buttBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttBlack];
    buttBlack.alpha = 0.5;
    [buttBlack addTarget:self action:@selector(buttonViewDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewThirdOpen = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 310/2, HEIGHT_CONTROLLER_DEFAULT/3, 310, 228) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewThirdOpen];
    viewThirdOpen.layer.cornerRadius = 4;
    viewThirdOpen.layer.masksToBounds = YES;
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewThirdOpen.frame.size.width, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"您还未开通托管账户"];
    [viewThirdOpen addSubview:labelAlert];
    
    UIImageView *imageImg = [CreatView creatImageViewWithFrame:CGRectMake(viewThirdOpen.frame.size.width/2 - 314/2/2, 45, 314/2, 234/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"thirdimg"]];
    [viewThirdOpen addSubview:imageImg];
    
    UIButton *buttonok = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 45 + imageImg.frame.size.height + 15, viewThirdOpen.frame.size.width - 24, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [viewThirdOpen addSubview:buttonok];
    buttonok.layer.cornerRadius = 4;
    buttonok.layer.masksToBounds = YES;
    buttonok.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonok addTarget:self action:@selector(buttonOpenThirdOK:) forControlEvents:UIControlEventTouchUpInside];
}

//开通三方确定按钮
- (void)buttonOpenThirdOK:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
    
    TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
    productHuiFuVC.fuctionName = @"userReg";
    pushVC(productHuiFuVC);
    
}

//开通三方弹框点击消失
- (void)buttonViewDisappear:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
}

#pragma mark liftMoney|||||||||||||||||||||||||||||||||||||||||||
- (void)liftMoneyData
{
    NSDictionary *parmaeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"check/checkCash" parameters:parmaeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"充值未投资就提现%@", responseObject);
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            butLiftAlert.hidden = YES;
        } else {
            butLiftAlert.hidden = NO;
//            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
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
