//
//  ChengGongViewController.m
//  DSLC
//
//  Created by ios on 16/1/12.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "ChengGongViewController.h"

@interface ChengGongViewController ()

@end

@implementation ChengGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"绑卡成功"];
    [self contentShow];
}

- (void)contentShow
{
    UIButton *butCheng = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 40, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"绑卡成功"];
    [self.view addSubview:butCheng];
    butCheng.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    [butCheng setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
    
    UIButton *button = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 120, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"完成"];
    [self.view addSubview:button];
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(UIButton *)button
{
    NSArray *viewController = [self.navigationController viewControllers];
    
    if (self.realNameString == YES) {
        [self.navigationController popToViewController:[viewController objectAtIndex:2] animated:YES];
        
    } else {
        [self.navigationController popToViewController:[viewController objectAtIndex:3] animated:YES];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushBK" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
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
