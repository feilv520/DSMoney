//
//  TWOMyMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/9.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyMoneyViewController.h"

@interface TWOMyMoneyViewController ()

@end

@implementation TWOMyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"我的资产"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewUp = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 278.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewUp];
    
    UIView *viewUpLine = [CreatView creatViewWithFrame:CGRectMake(0, viewUp.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewUp addSubview:viewUpLine];
    viewUp.alpha = 0.3;
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, viewUp.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 266.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    UIView *viewDownLine1 = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewDown addSubview:viewDownLine1];
    viewDownLine1.alpha = 0.3;
    
    UIView *viewDownLine2 = [CreatView creatViewWithFrame:CGRectMake(0, viewDown.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewDown addSubview:viewDownLine2];
    viewDownLine2.alpha = 0.3;
    
    UILabel *labelZong = [CreatView creatWithLabelFrame:CGRectMake(23, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 65, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor moneyColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:20] text:@"总资产"];
    [viewDown addSubview:labelZong];
    
//    总资产的钱数
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(23 + labelZong.frame.size.width + 10, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - (23 + labelZong.frame.size.width + 10 + 23), 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor colorWithRed:253.0 / 225.0 green:135.0 / 225.0 blue:74.0 / 225.0 alpha:1.0] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
    [viewDown addSubview:labelMoney];
    NSMutableAttributedString *zongString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元" , @"230,373.41"]];
    NSRange shuziRange = NSMakeRange(0, [[zongString string] rangeOfString:@"元"].location);
    [zongString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:shuziRange];
    [labelMoney setAttributedText:zongString];
    
    NSArray *colorArray = @[[UIColor colorWithRed:63.0 / 225.0 green:166.0 / 225.0 blue:252.0 / 225.0 alpha:1.0], [UIColor colorWithRed:124.0 / 225.0 green:207.0 / 225.0 blue:253.0 / 225.0 alpha:1.0], [UIColor colorWithRed:93.0 / 225.0 green:203.0 / 225.0 blue:224.0 / 225.0 alpha:1.0], [UIColor colorWithRed:180.0 / 225.0 green:228.0 / 225.0 blue:254.0 / 225.0 alpha:1.0]];
    NSArray *kindsArray = @[@"账户余额", @"在投资金", @"未结算预期收益", @"提现中"];
    NSArray *moneyArray = @[@"1000.00元", @"10000.00元", @"500.00元", @"1000.00元"];
    
    for (int m = 0; m < 4; m++) {
        
//        色块
        UIView *viewColor = [CreatView creatViewWithFrame:CGRectMake(23, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelZong.frame.size.height + 36.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 19 * m + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) * m, 19, 19) backgroundColor:[colorArray objectAtIndex:m]];
        [viewDown addSubview:viewColor];
        viewColor.layer.cornerRadius = 3;
        viewColor.layer.masksToBounds = YES;
        
        UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(23 + 19 + 12, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelZong.frame.size.height + 36.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 19 * m + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) * m, 110, 19) backgroundColor:[UIColor whiteColor] textColor:[UIColor moneyColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[kindsArray objectAtIndex:m]];
        [viewDown addSubview:labelName];
        
        UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(23 + 19 + 110 + 5 + 12, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelZong.frame.size.height + 36.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 19 * m + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) * m, WIDTH_CONTROLLER_DEFAULT - 23 - (23 + 19 + 110 + 5 + 12), 19) backgroundColor:[UIColor whiteColor] textColor:[UIColor moneyColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[moneyArray objectAtIndex:m]];
        [viewDown addSubview:labelMoney];
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
