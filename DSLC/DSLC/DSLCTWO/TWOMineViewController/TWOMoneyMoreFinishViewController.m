//
//  TWOMoneyMoreFinishViewController.m
//  DSLC
//
//  Created by ios on 16/5/23.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMoneyMoreFinishViewController.h"
#import "TWOUsableMoneyViewController.h"

@interface TWOMoneyMoreFinishViewController ()

@end

@implementation TWOMoneyMoreFinishViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    
    [self viewContentShow];
}

- (void)viewContentShow
{
    UIView *viewBlue = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 215.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor profitColor]];
    [self.view addSubview:viewBlue];
    
    UILabel *labelMore = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 30, 30, 60, 20) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"充值"];
    [viewBlue addSubview:labelMore];
    
    UIButton *butFinish = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 35 - 5, 30, 35, 20) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"完成"];
    [viewBlue addSubview:butFinish];
    butFinish.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butFinish addTarget:self action:@selector(haveMoreMoneyFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageFinish = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 65, 30 + labelMore.frame.size.height + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 130, viewBlue.frame.size.height - 10 - (30 + labelMore.frame.size.height + 27.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"充值成功～"]];
    [viewBlue addSubview:imageFinish];
    
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, viewBlue.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, viewBlue.frame.size.height + viewWhite.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UILabel *labelThisTime = [CreatView creatWithLabelFrame:CGRectMake(9, 10, (WIDTH_CONTROLLER_DEFAULT - 18)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"本次充值"];
    [viewWhite addSubview:labelThisTime];
    
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - (WIDTH_CONTROLLER_DEFAULT - 18)/2, 10, (WIDTH_CONTROLLER_DEFAULT - 18)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[NSString stringWithFormat:@"%@元", @"10000"]];
    [viewWhite addSubview:labelMoney];
    
    UIButton *butGoMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, viewBlue.frame.size.height + viewWhite.frame.size.height + 15, WIDTH_CONTROLLER_DEFAULT - 18, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"去理财啦"];
    [self.view addSubview:butGoMoney];
    butGoMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butGoMoney.layer.cornerRadius = 5;
    butGoMoney.layer.masksToBounds = YES;
    [butGoMoney addTarget:self action:@selector(goToHaveMoreMoney:) forControlEvents:UIControlEventTouchUpInside];
}

//完成按钮
- (void)haveMoreMoneyFinishButton:(UIButton *)button
{
    TWOUsableMoneyViewController *usableVC = [[TWOUsableMoneyViewController alloc] init];
    usableVC.whichOne = NO;
    [self.navigationController pushViewController:usableVC animated:YES];
}

//去理财啦
- (void)goToHaveMoreMoney:(UIButton *)button
{
    NSLog(@"去理财啦");
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
