//
//  ShareFailureViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ShareFailureViewController.h"

@interface ShareFailureViewController ()

@end

@implementation ShareFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"分享"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(buttonFinish:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *buttonFail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 52, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"分享失败"];
    [self.view addSubview:buttonFail];
    buttonFail.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonFail setImage:[UIImage imageNamed:@"分享失败"] forState:UIControlStateNormal];
    
    UILabel *labelTwo = [CreatView creatWithLabelFrame:CGRectMake(0, 80, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"有一个红包与你擦肩而过\n您可以继续分享或者去投资"];
    [self.view addSubview:labelTwo];
    labelTwo.numberOfLines = 2;
    
    UIButton *butGoOn = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 200, (WIDTH_CONTROLLER_DEFAULT - 90)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"继续投资"];
    [self.view addSubview:butGoOn];
    butGoOn.layer.cornerRadius = 3;
    butGoOn.layer.masksToBounds = YES;
    butGoOn.layer.borderColor = [[UIColor daohanglan] CGColor];
    butGoOn.layer.borderWidth = 0.5;
    
    UIButton *butShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 90)/2 + 50, 200, (WIDTH_CONTROLLER_DEFAULT - 90)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"分享拿红包"];
    [self.view addSubview:butShare];
    butShare.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butShare.layer.cornerRadius = 3;
    butShare.layer.masksToBounds = YES;
}

- (void)buttonFinish:(UIBarButtonItem *)bar
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
