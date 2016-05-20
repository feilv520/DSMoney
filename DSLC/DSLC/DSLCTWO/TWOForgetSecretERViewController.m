//
//  TWOForgetSecretERViewController.m
//  DSLC
//
//  Created by ios on 16/5/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOForgetSecretERViewController.h"
#import "AppDelegate.h"
#import "define.h"

@interface TWOForgetSecretERViewController ()

@end

@implementation TWOForgetSecretERViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self contentShow];
}

- (void)contentShow
{
    //    大背景
    UIImageView *imageBigPic = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"beijing"]];
    [self.view addSubview:imageBigPic];
    imageBigPic.userInteractionEnabled = YES;
    
    //    左上角返回按钮
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 30, 20, 20) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBigPic addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"750产品111"] forState:UIControlStateHighlighted];
    [butCancle addTarget:self action:@selector(buttonForgetCancleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 54, 30, 108, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"找回登录密码"];
    [self.view addSubview:labelTitle];

    UIImageView *imageTwo = [CreatView creatImageViewWithFrame:CGRectMake(30, self.view.frame.size.height/2 - 100, WIDTH_CONTROLLER_DEFAULT - 60, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"kuang"]];
    [imageBigPic addSubview:imageTwo];
    imageTwo.userInteractionEnabled = YES;
    
    //    手机图标
    UIImageView *imagePhone = [CreatView creatImageViewWithFrame:CGRectMake(22, 9, 22, 22) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"phoneNumber"]];
    [imageTwo addSubview:imagePhone];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(22 + 22 + 10, 8, 0.5, 24) backgroundColor:[UIColor whiteColor]];
    [imageTwo addSubview:viewLine];

}

//左上角x按钮
- (void)buttonForgetCancleClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
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
