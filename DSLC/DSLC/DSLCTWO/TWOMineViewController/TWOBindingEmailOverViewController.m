//
//  TWOBindingEmailOverViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOBindingEmailOverViewController.h"

@interface TWOBindingEmailOverViewController ()

{
    UIButton *butFinish;
}

@end

@implementation TWOBindingEmailOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"邮箱绑定"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBlue = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 215) backgroundColor:[UIColor profitColor]];
    [self.view addSubview:viewBlue];
    
    UIImageView *imagePicture = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 50, 10, 100, 120) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"恭喜您"]];
    [viewBlue addSubview:imagePicture];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(9, 10 + imagePicture.frame.size.height + 10, WIDTH_CONTROLLER_DEFAULT - 18, 0.5) backgroundColor:[UIColor whiteColor]];
    [viewBlue addSubview:viewLine];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 10 + imagePicture.frame.size.height + 10 + 18, WIDTH_CONTROLLER_DEFAULT, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"邮箱绑定邮件已发送,请登录您的邮箱验证\n本邮件30分钟以内有效"];
    [viewBlue addSubview:labelAlert];
    labelAlert.numberOfLines = 2;
    
    butFinish = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 30, 15, 30, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"完成"];
    [self.navigationController.navigationBar addSubview:butFinish];
    butFinish.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butFinish addTarget:self action:@selector(navigationBarButtonFinish:) forControlEvents:UIControlEventTouchUpInside];
}

//完成按钮
- (void)navigationBarButtonFinish:(UIButton *)button
{
    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllers objectAtIndex:1] animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    butFinish.hidden = YES;
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