//
//  TWOAddressAlreadySetViewController.m
//  DSLC
//
//  Created by ios on 16/6/2.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAddressAlreadySetViewController.h"
#import "TWOAddressManageViewController.h"

@interface TWOAddressAlreadySetViewController ()

@end

@implementation TWOAddressAlreadySetViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBlue = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 312) backgroundColor:[UIColor profitColor]];
    [self.view addSubview:viewBlue];
    
//    返回按钮
    UIButton *butReturn = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(15, 37, 20, 20) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewBlue addSubview:butReturn];
    [butReturn setBackgroundImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateNormal];
    [butReturn setBackgroundImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateHighlighted];
    [butReturn addTarget:self action:@selector(buttonReturnFrontClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    页面标题
    UILabel *labelAbout = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 45, 33, 90, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"地址设置"];
    [viewBlue addSubview:labelAbout];
    
    UIImageView *imageViewSet = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 181/2.1/2, 75, 181/2.1, 279/2.1) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"setAddress"]];
    [viewBlue addSubview:imageViewSet];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(10, 75 + 140 + 14, WIDTH_CONTROLLER_DEFAULT - 20, 0.5) backgroundColor:[UIColor whiteColor]];
    [viewBlue addSubview:viewLine];
    
//    展示地址的label
    UILabel *labelAddress = [CreatView creatWithLabelFrame:CGRectMake(0, 75 + 140 + 14 + 33, WIDTH_CONTROLLER_DEFAULT, 18) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:self.addressString];
    [viewBlue addSubview:labelAddress];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, viewBlue.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 47.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"您的所有活动奖品都将寄到这个地址哦"];
    [self.view addSubview:labelAlert];
    
    UIButton *buttonChange = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, viewBlue.frame.size.height + labelAlert.frame.size.height, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"更换地址"];
    [self.view addSubview:buttonChange];
    buttonChange.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonChange.layer.cornerRadius = 5;
    buttonChange.layer.masksToBounds = YES;
    [buttonChange addTarget:self action:@selector(buttonChangeAddress:) forControlEvents:UIControlEventTouchUpInside];
}

//更换地址按钮
- (void)buttonChangeAddress:(UIButton *)button
{
    TWOAddressManageViewController *addressManager = [[TWOAddressManageViewController alloc] init];
    pushVC(addressManager);
}

//导航返回按钮
- (void)buttonReturnFrontClicked:(UIButton *)button
{
    if (self.numberNo == 0) {
        NSArray *viewControllerArray = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[viewControllerArray objectAtIndex:1] animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
