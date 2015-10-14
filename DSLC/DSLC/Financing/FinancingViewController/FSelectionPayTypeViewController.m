//
//  FSelectionPayTypeViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/14.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FSelectionPayTypeViewController.h"
#import "CreatView.h"

@interface FSelectionPayTypeViewController ()

@end

@implementation FSelectionPayTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"选择支付";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self showNavigationReturn];
}

//修改导航栏的默认返回按钮
- (void)showNavigationReturn
{
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"750产品111"]];
    imageReturn.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBack:)];
    [imageReturn addGestureRecognizer:tap];
}

//导航返回按钮
- (void)returnBack:(UIBarButtonItem *)bar
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
