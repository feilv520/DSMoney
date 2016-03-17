//
//  ThreeViewController.m
//  DSLC
//
//  Created by ios on 15/10/30.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ThreeViewController.h"
#import "FinancingViewController.h"
#import "NewbieViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "BillViewController.h"

@interface ThreeViewController ()

{
    UIScrollView *scrollView;
    UIButton *butThree;
    NSArray *butThrArr;
    UILabel *labelLine;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
    NewbieViewController *newbieVC;
    FinancingViewController *financingVC;
    BillViewController *billVC;
}

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self showNavigationBar];
    [self threeScrollViewButton];
}

- (void)showNavigationBar
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"理财产品";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

//三个按钮
- (void)threeScrollViewButton
{
    scrollView = [CreatView creatWithScrollViewFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45) backgroundColor:[UIColor whiteColor] contentSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT/3, 0) contentOffSet:CGPointMake(0, 0)];
    [self.view addSubview:scrollView];
    
    button1 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT/2, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"火爆专区"];
    [scrollView addSubview:button1];
    button1.tag = 101;
    button1.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [button1 addTarget:self action:@selector(button1Press:) forControlEvents:UIControlEventTouchUpInside];
    
    button2 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 0, WIDTH_CONTROLLER_DEFAULT/2, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"固收理财"];
    [scrollView addSubview:button2];
    button2.tag = 201;
    button2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [button2 addTarget:self action:@selector(button2Press:) forControlEvents:UIControlEventTouchUpInside];
    
//    button3 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 * 2, 0, WIDTH_CONTROLLER_DEFAULT/3, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"银行票据"];
//    [scrollView addSubview:button3];
//    button3.tag = 301;
//    button3.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
//    [button3 addTarget:self action:@selector(button3Press:) forControlEvents:UIControlEventTouchUpInside];
    
    labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT/2, 2) backgroundColor:[UIColor daohanglan] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [self.view addSubview:labelLine];
    
    newbieVC = [[NewbieViewController alloc] init];
    
    [self addChildViewController:newbieVC];
    [self.view addSubview:newbieVC.view];
    newbieVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 45);
    
//    billVC = [[BillViewController alloc] init];
//    [self addChildViewController:billVC];
//    [self.view addSubview:billVC.view];
//    billVC.view.tag = 300;
//    billVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 45 - 20 - 53);
}

- (void)button1Press:(UIButton *)button
{
    NSLog(@"1");
    
    [MobClick event:@"hotZone"];
    
    [billVC removeFromParentViewController];
    [billVC.view removeFromSuperview];
    billVC = nil;
    
    [financingVC.view removeFromSuperview];
    [financingVC removeFromParentViewController];
    financingVC = nil;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        labelLine.frame = CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT/2, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
    newbieVC = [[NewbieViewController alloc] init];
    [self addChildViewController:newbieVC];
    [self.view addSubview:newbieVC.view];
    newbieVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 45);
    
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
}

- (void)button2Press:(UIButton *)button
{
    NSLog(@"2");
    
    [MobClick event:@"setZone"];
    
    [financingVC.view removeFromSuperview];
    [financingVC removeFromParentViewController];
    financingVC = nil;
    
    [newbieVC removeFromParentViewController];
    [newbieVC.view removeFromSuperview];
    newbieVC = nil;
    
    billVC = [[BillViewController alloc] init];
    [self addChildViewController:billVC];
    [self.view addSubview:billVC.view];
    billVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 45 - 20 - 53);
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        labelLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 43, WIDTH_CONTROLLER_DEFAULT/2, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
}

//- (void)button3Press:(UIButton *)button
//{
//    NSLog(@"3");
//    
//    [MobClick event:@"bankZone"];
//    
//    [newbieVC removeFromParentViewController];
//    [newbieVC.view removeFromSuperview];
//    newbieVC = nil;
//    
//    [billVC removeFromParentViewController];
//    [billVC.view removeFromSuperview];
//    billVC = nil;
//    
//    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        
//        labelLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 * 2, 43, WIDTH_CONTROLLER_DEFAULT/3, 2);
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    financingVC = [[FinancingViewController alloc] init];
//    [self addChildViewController:financingVC];
//    [self.view addSubview:financingVC.view];
//    financingVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53);
//    
//    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
//}

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
