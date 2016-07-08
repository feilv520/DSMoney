//
//  TWOLiftMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/19.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOLiftMoneyViewController.h"
#import "TWOProductHuiFuViewController.h"

@interface TWOLiftMoneyViewController ()
{
    UITextField *textFieldLift;
    
    UIButton *buttBlack;
    UIView *viewThirdOpen;
}
@end

@implementation TWOLiftMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"提现"];
    
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
    
    textFieldLift = [CreatView creatWithfFrame:CGRectMake(90, 10, WIDTH_CONTROLLER_DEFAULT - 90 - 10, 31) setPlaceholder:[NSString stringWithFormat:@"可提现%@元", @"100"] setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldLift];
    textFieldLift.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    textFieldLift.textColor = [UIColor findZiTiColor];
    textFieldLift.keyboardType = UIKeyboardTypeDecimalPad; //带小数点的数字键盘
    
    UIButton *buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 66, WIDTH_CONTROLLER_DEFAULT - 18, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonNext.layer.cornerRadius = 5;
    buttonNext.layer.masksToBounds = YES;
    [buttonNext addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self alertContentShow];
}

- (void)alertContentShow
{
    UIView *viewAlert = [CreatView creatViewWithFrame:CGRectMake(9, 66 + 40 + 100, WIDTH_CONTROLLER_DEFAULT - 18, 160) backgroundColor:[UIColor profitColor]];
    [self.view addSubview:viewAlert];
    viewAlert.layer.cornerRadius = 5;
    viewAlert.layer.masksToBounds = YES;
    
    CGFloat viewWidth = viewAlert.frame.size.width;

    UILabel *labelKindlyReminder  = [CreatView creatWithLabelFrame:CGRectMake(12, 0, viewWidth - 24, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor friendAlert] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"温馨提示"];
    labelKindlyReminder.alpha = 1.0;
    [viewAlert addSubview:labelKindlyReminder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)nextAction:(id)sender
{
    if ([[self.flagDic objectForKey:@"chinaPnrAcc"] isEqualToString:@""]) {
        
        [self registThirdShow];
        return;
    }
    
    TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
    productHuiFuVC.fuctionName = @"cash";
    productHuiFuVC.moneyString = textFieldLift.text;
    pushVC(productHuiFuVC);
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
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewThirdOpen.frame.size.width, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"你还未开通托管账户"];
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
