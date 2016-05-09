//
//  TWOProductViewController.m
//  DSLC
//
//  Created by ios on 16/5/5.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductViewController.h"
#import "define.h"
#import "TWOBillViewController.h"
#import "TWONewViewController.h"

@interface TWOProductViewController () <UIScrollViewDelegate> {
    
    UIButton *buttonOne;
    UIButton *buttonTwo;
    UIScrollView *myScrollView;
    
    UIView *navigationView;
}

@end

@implementation TWOProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showNavigationBar];
    [self setMyScrollView];
}

- (void)showNavigationBar
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
//    self.navigationItem.title = @"理财产品";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    navigationView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 180) * 0.5, 20, 180, 40)];
    navigationView.backgroundColor = [UIColor clearColor];
    [self.navigationController.view addSubview:navigationView];
    
    buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOne.frame = CGRectMake(0, 10, 80, 20);
    [buttonOne setTitle:@"火爆专区" forState:UIControlStateNormal];
    buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    [buttonOne addTarget:self action:@selector(goToOneView:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:buttonOne];
    
    buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTwo.frame = CGRectMake(100, 10, 80, 20);
    [buttonTwo setTitle:@"固收理财" forState:UIControlStateNormal];
    buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [buttonTwo addTarget:self action:@selector(goToTwoView:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:buttonTwo];

}

// 创建滚动试图
- (void)setMyScrollView{
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)];

//    UIView *navigationView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
//    navigationView1.backgroundColor = [UIColor grayColor];
//    [myScrollView addSubview:navigationView1];
//    
//    UIView *navigationView2 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
//    navigationView2.backgroundColor = [UIColor greenColor];
//    [myScrollView addSubview:navigationView2];
    
    myScrollView.backgroundColor = [UIColor blackColor];
    myScrollView.delegate = self;
    myScrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 2, 1);
    myScrollView.pagingEnabled = YES;
    myScrollView.bounces = NO;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    
    TWONewViewController *newbieVC = [[TWONewViewController alloc] init];
    [self addChildViewController:newbieVC];
    [myScrollView addSubview:newbieVC.view];
    
    TWOBillViewController *billVC = [[TWOBillViewController alloc] init];
    [self addChildViewController:billVC];
    [myScrollView addSubview:billVC.view];
    billVC.view.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, myScrollView.frame.size.width, myScrollView.frame.size.height);
    
}



#pragma mark scrollView Delegate
#pragma mark --------------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    //    NSLog(@" scrollViewDidScroll");
//    NSLog(@"ContentOffset  x is  %f,yis %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    if (scrollView.contentOffset.x == 375.0) {
        [self goToTwoView:nil];
        NSLog(@"123");
    } else if (scrollView.contentOffset.x == 0) {
        [self goToOneView:nil];
        NSLog(@"321");
    }
}

#pragma mark 导航栏按钮的方法
#pragma mark --------------------------------

// 转换成火爆专区
- (void)goToOneView:(id)sender{
    buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

// 转换成固收理财
- (void)goToTwoView:(id)sender{
    buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    [myScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:YES];
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
