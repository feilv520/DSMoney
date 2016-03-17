//
//  NewCastProductViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/3/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "NewCastProductViewController.h"
#import "myCastViewController.h"
#import "myHadCastViewController.h"

@interface NewCastProductViewController ()
{
    // 三个按钮的滚动view
    UIScrollView *scrollView;
    
    // 红色的线
    UILabel *labelLine;
    
    //切换按钮
    UIButton *button1;
    UIButton *button2;
    
    // 持有资产
    myCastViewController *myCastVC;
    // 已兑付资产
    myHadCastViewController *myHadCastVC;
}

@end

@implementation NewCastProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"我的资产"];
    
    [self twoScrollViewButton];
}

//三个按钮
- (void)twoScrollViewButton
{
    scrollView = [CreatView creatWithScrollViewFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45) backgroundColor:[UIColor whiteColor] contentSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT/3, 0) contentOffSet:CGPointMake(0, 0)];
    [self.view addSubview:scrollView];
    
    button1 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT/2, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"持有资产"];
    [scrollView addSubview:button1];
    button1.tag = 101;
    button1.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [button1 addTarget:self action:@selector(button1Press:) forControlEvents:UIControlEventTouchUpInside];
    
    button2 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 0, WIDTH_CONTROLLER_DEFAULT/2, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"已兑付"];
    [scrollView addSubview:button2];
    button2.tag = 201;
    button2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [button2 addTarget:self action:@selector(button2Press:) forControlEvents:UIControlEventTouchUpInside];
    
    labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT/2, 2) backgroundColor:[UIColor daohanglan] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [self.view addSubview:labelLine];
    
    myCastVC = [[myCastViewController alloc] init];
    
    myHadCastVC = [[myHadCastViewController alloc] init];
    
    [self addChildViewController:myCastVC];
    [self.view addSubview:myCastVC.view];
    myCastVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 45);
    
}

- (void)button1Press:(UIButton *)button
{
    
    [myHadCastVC.view removeFromSuperview];
    [myHadCastVC removeFromParentViewController];
    myHadCastVC = nil;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        labelLine.frame = CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT/2, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
    myCastVC = [[myCastViewController alloc] init];
    [self addChildViewController:myCastVC];
    [self.view addSubview:myCastVC.view];
    myCastVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 45);
    
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
}

- (void)button2Press:(UIButton *)button
{
    
    [myCastVC removeFromParentViewController];
    [myCastVC.view removeFromSuperview];
    myCastVC = nil;
    
    myHadCastVC = [[myHadCastViewController alloc] init];
    [self addChildViewController:myHadCastVC];
    [self.view addSubview:myHadCastVC.view];
    myHadCastVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 45);
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        labelLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 43, WIDTH_CONTROLLER_DEFAULT/2, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
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
