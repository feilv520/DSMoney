//
//  TWOAddBankCardViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAddBankCardViewController.h"

@interface TWOAddBankCardViewController ()

@end

@implementation TWOAddBankCardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"银行卡"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *butAddCard = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 9, WIDTH_CONTROLLER_DEFAULT - 18, 150.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor qianhuise] textColor:nil titleText:nil];
    [self.view addSubview:butAddCard];
    [butAddCard setBackgroundImage:[UIImage imageNamed:@"addBankCard"] forState:UIControlStateNormal];
    [butAddCard setBackgroundImage:[UIImage imageNamed:@"addBankCard"] forState:UIControlStateHighlighted];
    [butAddCard addTarget:self action:@selector(addBankCardButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonBank = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, butAddCard.frame.size.height - 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butAddCard.frame.size.width, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] titleText:@"添加银行卡"];
    [butAddCard addSubview:buttonBank];
    buttonBank.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonBank addTarget:self action:@selector(addBankCardButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBankCardButton:(UIButton *)button
{
    NSLog(@"add");
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
