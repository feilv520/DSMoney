//
//  TWOSetLoginSecretViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOSetLoginSecretViewController.h"
#import "TWOChangeLoginFinishViewController.h"

@interface TWOSetLoginSecretViewController ()

@end

@implementation TWOSetLoginSecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"设置登录密码"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 56) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 56, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIImageView *imageSign = [CreatView creatImageViewWithFrame:CGRectMake(21, 17, 22, 22) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"yanzhenma"]];
    [viewBottom addSubview:imageSign];
    
    UITextField *textFieldEmail = [CreatView creatWithfFrame:CGRectMake(59, 10, WIDTH_CONTROLLER_DEFAULT - 59 - 40, 36) setPlaceholder:@"请输入登录密码" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldEmail];
    textFieldEmail.delegate = self;
    textFieldEmail.textColor = [UIColor ZiTiColor];
    textFieldEmail.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    UIButton *buttonEye = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 30, 17, 22, 22) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [viewBottom addSubview:buttonEye];
    [buttonEye setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateNormal];
    [buttonEye setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateHighlighted];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(20, 60, WIDTH_CONTROLLER_DEFAULT - 40, 30) backgroundColor:[UIColor qianhuise] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"登录密码由6-20位数字和字母组成,以字母开头"];
    [self.view addSubview:labelAlert];
    
    UIButton *buttonMake = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 60 + labelAlert.frame.size.height + 4, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:buttonMake];
    buttonMake.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonMake.layer.cornerRadius = 5;
    buttonMake.layer.masksToBounds = YES;
    [buttonMake addTarget:self action:@selector(buttonMakeLoginSecret:) forControlEvents:UIControlEventTouchUpInside];
}

//确定按钮
- (void)buttonMakeLoginSecret:(UIButton *)button
{
    TWOChangeLoginFinishViewController *loginFinish = [[TWOChangeLoginFinishViewController alloc] init];
    loginFinish.state = YES;
    pushVC(loginFinish);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
