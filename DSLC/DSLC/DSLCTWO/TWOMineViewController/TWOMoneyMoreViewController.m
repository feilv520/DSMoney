//
//  TWOLiftMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/19.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMoneyMoreViewController.h"
#import "TWOProductHuiFuViewController.h"

@interface TWOMoneyMoreViewController () <UITextFieldDelegate>
{
    UITextField *textFieldLift;
    
    UIButton *buttBlack;
    UIView *viewThirdOpen;
    UIButton *buttonNext;
}
@end

@implementation TWOMoneyMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"充值"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 51) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 51, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UILabel *labelLift = [CreatView creatWithLabelFrame:CGRectMake(9, 10, 60, 31) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"充值金额"];
    [viewBottom addSubview:labelLift];
    
    textFieldLift = [CreatView creatWithfFrame:CGRectMake(90, 10, WIDTH_CONTROLLER_DEFAULT - 90 - 10, 31) setPlaceholder:[NSString stringWithFormat:@"充值金额最少为100元"] setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldLift];
    textFieldLift.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldLift.textColor = [UIColor findZiTiColor];
    textFieldLift.delegate = self;
    textFieldLift.keyboardType = UIKeyboardTypeDecimalPad; //带小数点的数字键盘
    [textFieldLift addTarget:self action:@selector(textFieldEdit:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 66, WIDTH_CONTROLLER_DEFAULT - 18, 40) backgroundColor:[UIColor findZiTiColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonNext.layer.cornerRadius = 5;
    buttonNext.layer.masksToBounds = YES;
    [buttonNext addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self alertContentShow];
}

- (void)textFieldEdit:(UITextField *)textField
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
    if (range.location > 9) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)alertContentShow
{
    UIView *viewAlert = [CreatView creatViewWithFrame:CGRectMake(9, 66 + 40 + 100, WIDTH_CONTROLLER_DEFAULT - 18, 210) backgroundColor:[UIColor backColor]];
    [self.view addSubview:viewAlert];
    viewAlert.layer.cornerRadius = 5;
    viewAlert.layer.masksToBounds = YES;
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        viewAlert.frame = CGRectMake(9, 40 + 100, WIDTH_CONTROLLER_DEFAULT - 18, 230);
    } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
        viewAlert.frame = CGRectMake(9, 40 + 100, WIDTH_CONTROLLER_DEFAULT - 18, 190);
    }
    
    CGFloat viewWidth = viewAlert.frame.size.width;
    
    UILabel *labelKindlyReminder  = [CreatView creatWithLabelFrame:CGRectMake(12, 0, viewWidth - 24, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"温馨提示:"];
    labelKindlyReminder.alpha = 1.0;
    [viewAlert addSubview:labelKindlyReminder];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        NSArray *contenArray = @[@"1.用户充值不收取任何手续费;", @"2.最低充值金额应大于等于100元;", @"3.充值/提现必须为银行借记卡,不支持存折、信用卡充值;", @"4.严禁利用充值功能进行信用卡套现、转账、洗钱等行为,", @"   一经发现,将封停账号;", @"5.充值需开通银行卡网上支付功能;如有疑问请咨询开户", @"   行客服;", @"6.如需帮助,请拨打客服热线:400-816-2283。"];
        
        for (int i = 0; i < 8; i++) {
            UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(12, 40 + i * 20, viewAlert.frame.size.width - 24, 20) backgroundColor:[UIColor backColor] textColor:[UIColor alertColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:11] text:[contenArray objectAtIndex:i]];
            [viewAlert addSubview:labelAlert];
        }
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
        
        NSArray *contenArray = @[@"1.用户充值不收取任何手续费;", @"2.最低充值金额应大于等于100元;", @"3.充值/提现必须为银行借记卡,不支持存折、信用卡充值;", @"4.严禁利用充值功能进行信用卡套现、转账、洗钱等行为,", @"   一经发现,将封停账号;", @"5.充值需开通银行卡网上支付功能;如有疑问请咨询开户", @"   行客服;", @"6.如需帮助,请拨打客服热线:400-816-2283。"];
        
        for (int i = 0; i < 8; i++) {
            UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(12, 40 + i * 20, viewAlert.frame.size.width - 24, 20) backgroundColor:[UIColor backColor] textColor:[UIColor alertColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[contenArray objectAtIndex:i]];
            [viewAlert addSubview:labelAlert];
        }
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
        
        NSArray *contenArray = @[@"1.用户充值不收取任何手续费;", @"2.最低充值金额应大于等于100元;", @"3.充值/提现必须为银行借记卡,不支持存折、信用卡充值;", @"4.严禁利用充值功能进行信用卡套现、转账、洗钱等行为,一经发", @"   现,将封停账号;", @"5.充值需开通银行卡网上支付功能;如有疑问请咨询开户行客服;", @"6.如需帮助,请拨打客服热线:400-816-2283。"];
        
        for (int i = 0; i < 7; i++) {
            UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(12, 40 + i * 20, viewAlert.frame.size.width - 24, 20) backgroundColor:[UIColor backColor] textColor:[UIColor alertColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[contenArray objectAtIndex:i]];
            [viewAlert addSubview:labelAlert];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)nextAction:(id)sender{
    
    if (![NSString isPureFloat:textFieldLift.text]) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"你输入的是非法数字"];
        return;
    }
    
    if (textFieldLift.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入充值金额"];
    } else if ([textFieldLift.text integerValue] < 100) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"充值金额最少为100元"];
    } else {
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        
        if ([[dic objectForKey:@"chinaPnrAcc"] isEqualToString:@""]) {
            
            [self.view endEditing:YES];
            [self registThirdShow];
            return;
        }
        
        TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
        productHuiFuVC.fuctionName = @"netSave";
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
