//
//  TWOChangeLoginFinishViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOChangeLoginFinishViewController.h"

@interface TWOChangeLoginFinishViewController ()

@end

@implementation TWOChangeLoginFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.state == YES) {
        [self.navigationItem setTitle:@"设置成功"];
    } else {
        [self.navigationItem setTitle:@"修改成功"];
    }
    
    [self contentShow];
}

- (void)contentShow
{
    UIImageView *imageSetFinish = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 75, 20, 150, 150)];
    [self.view addSubview:imageSetFinish];
    imageSetFinish.backgroundColor = [UIColor whiteColor];
    if (self.state == YES) {
        imageSetFinish.image = [UIImage imageNamed:@"setFinish"];
    } else {
        imageSetFinish.image = [UIImage imageNamed:@"登录密码修改成功"];
    }
    
    UIButton *butLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 150 + 50, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"请重新登录账号"];
    [self.view addSubview:butLogin];
    butLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butLogin.layer.cornerRadius = 5;
    butLogin.layer.masksToBounds = YES;
    [butLogin addTarget:self action:@selector(buttonLogin:) forControlEvents:UIControlEventTouchUpInside];
}

//重新登录按钮
- (void)buttonLogin:(UIButton *)button
{
    NSLog(@"chongdeng");
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
