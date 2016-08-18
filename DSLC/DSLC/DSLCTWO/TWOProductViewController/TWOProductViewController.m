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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    navigationView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    navigationView.hidden = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
}

- (void)showNavigationBar
{
//    self.navigationItem.title = @"理财产品";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];

    navigationView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 180) * 0.5, 25, 180, 30)];
    navigationView.backgroundColor = [UIColor profitColor];
    [self.navigationController.view addSubview:navigationView];
    navigationView.layer.cornerRadius = 15;
    navigationView.layer.masksToBounds = YES;
    navigationView.layer.borderWidth = 1;
    navigationView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOne.frame = CGRectMake(0, 0, navigationView.frame.size.width/2, 30);
    [buttonOne setTitle:@"火爆专区" forState:UIControlStateNormal];
    [buttonOne setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonOne.layer.cornerRadius = 15;
    buttonOne.layer.masksToBounds = YES;
    buttonOne.backgroundColor = [UIColor whiteColor];
    [buttonOne addTarget:self action:@selector(goToOneView:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:buttonOne];
    
    buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTwo.frame = CGRectMake(navigationView.frame.size.width/2, 0, navigationView.frame.size.width/2, 30);
    [buttonTwo setTitle:@"固收理财" forState:UIControlStateNormal];
    buttonTwo.backgroundColor = [UIColor clearColor];
    buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonTwo.layer.cornerRadius = 15;
    buttonTwo.layer.masksToBounds = YES;
    [buttonTwo addTarget:self action:@selector(goToTwoView:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:buttonTwo];
}

// 创建滚动试图
- (void)setMyScrollView{
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)];
    
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
    if (scrollView.contentOffset.x == WIDTH_CONTROLLER_DEFAULT) {
        [MobClick event:@"hotZone"];
        [self goToTwoView:nil];
        NSLog(@"123");
    } else if (scrollView.contentOffset.x == 0) {
        [MobClick event:@"regularZone"];
        [self goToOneView:nil];
        NSLog(@"321");
    }
}

#pragma mark 导航栏按钮的方法
#pragma mark --------------------------------

// 转换成火爆专区
- (void)goToOneView:(id)sender
{
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonTwo.backgroundColor = [UIColor clearColor];
    [buttonOne setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    buttonOne.backgroundColor = [UIColor whiteColor];
    [myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

// 转换成固收理财
- (void)goToTwoView:(id)sender
{
    [buttonTwo setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    buttonTwo.backgroundColor = [UIColor whiteColor];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonOne.backgroundColor = [UIColor clearColor];
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
