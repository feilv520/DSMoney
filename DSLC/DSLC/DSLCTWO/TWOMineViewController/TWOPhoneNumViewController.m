//
//  TWOPhoneNumViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOPhoneNumViewController.h"
#import "TWOChooseChangeStyleViewController.h"

@interface TWOPhoneNumViewController ()

@end

@implementation TWOPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"手机号"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIImageView *imageBack = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 40, 15, 80, 105) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"手机号绑定"]];
    [self.view addSubview:imageBack];
    
    UILabel *labelState = [CreatView creatWithLabelFrame:CGRectMake(0, 15 + imageBack.frame.size.height + 15, WIDTH_CONTROLLER_DEFAULT, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"已绑定"];
    [self.view addSubview:labelState];
    
    UILabel *labelPhoneNum = [CreatView creatWithLabelFrame:CGRectMake(0, 15 + imageBack.frame.size.height + 15 + labelState.frame.size.height + 7, WIDTH_CONTROLLER_DEFAULT, 18) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:18] text:@"189****7777"];
    [self.view addSubview:labelPhoneNum];
    
    UIButton *butChange = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 15 + imageBack.frame.size.height + 15 + labelState.frame.size.height + 7 + 18 + 35, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"更换手机号"];
    [self.view addSubview:butChange];
    butChange.layer.cornerRadius = 5;
    butChange.layer.masksToBounds = YES;
    butChange.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butChange addTarget:self action:@selector(changePhoneNum:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changePhoneNum:(UIButton *)button
{
    TWOChooseChangeStyleViewController *chooseStyle = [[TWOChooseChangeStyleViewController alloc] init];
    pushVC(chooseStyle);
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