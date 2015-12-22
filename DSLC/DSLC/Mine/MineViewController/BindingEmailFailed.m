//
//  BindingEmailFailed.m
//  DSLC
//
//  Created by ios on 15/12/22.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BindingEmailFailed.h"
#import "EmailViewController.h"

@interface BindingEmailFailed ()

@end

@implementation BindingEmailFailed

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"绑定邮箱"];
    
    [self contentSHow];
}

- (void)contentSHow
{
    UIButton *buttEmail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"邮箱绑定失败"];
    [self.view addSubview:buttEmail];
    buttEmail.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttEmail setImage:[UIImage imageNamed:@"失败"] forState:UIControlStateNormal];
    
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(0, 95, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"验证链接已失效"];
    [self.view addSubview:label];
    
    UIButton *button = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 175, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"重新绑定"];
    [self.view addSubview:button];
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [button addTarget:self action:@selector(buttonBinding:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonBinding:(UIButton *)button
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
