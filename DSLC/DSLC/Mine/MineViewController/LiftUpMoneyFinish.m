//
//  LiftUpMoneyFinish.m
//  DSLC
//
//  Created by ios on 15/11/12.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "LiftUpMoneyFinish.h"

@interface LiftUpMoneyFinish ()

{
    NSArray *labelName;
}

@end

@implementation LiftUpMoneyFinish

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"提现"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishRight:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    UIButton *buttonFinish = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 25, WIDTH_CONTROLLER_DEFAULT, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@" 提现申请已提交"];
    [self.view addSubview:buttonFinish];
    buttonFinish.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonFinish setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 50, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"预计最快2个工作日内到账"];
    [self.view addSubview:labelAlert];
    
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(30, 100, WIDTH_CONTROLLER_DEFAULT - 60, 100) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    viewWhite.layer.cornerRadius = 5;
    viewWhite.layer.masksToBounds = YES;
    viewWhite.layer.borderWidth = 0.2;
    viewWhite.layer.borderColor = [[UIColor grayColor] CGColor];
    
    CGFloat viewWidth = viewWhite.frame.size.width;
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.8, viewWidth, 0.3)];
    [viewWhite addSubview:labelLine];
    labelLine.backgroundColor = [UIColor lightGrayColor];
    labelLine.alpha = 0.7;
    
    labelName = @[@"提现金额", @"银行卡"];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(10, 10 + 30 * i + 20 * i, (viewWidth - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[labelName objectAtIndex:i]];
        [viewWhite addSubview:labelTitle];
    }

    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake((viewWidth - 20)/2 + 10, 10, (viewWidth - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"$1"];
    [viewWhite addSubview:labelMoney];
    
    UILabel *labelTailNum = [CreatView creatWithLabelFrame:CGRectMake((viewWidth - 20)/2 + 10, 60, (viewWidth - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"工商银行9988"];
    [viewWhite addSubview:labelTailNum];
}

- (void)finishRight:(UIBarButtonItem *)bar
{
    NSArray *viewController = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
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
