//
//  TWOProductViewController.m
//  DSLC
//
//  Created by ios on 16/5/5.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMessageCenterViewController.h"
#import "define.h"
#import "TWOGMessageViewController.h"
#import "TWOMMessageViewController.h"

@interface TWOMessageCenterViewController () <UIScrollViewDelegate> {
    
    UIButton *buttonOne;
    UIButton *buttonTwo;
    UIScrollView *myScrollView;
    
    UIView *navigationView;
}

@end

@implementation TWOMessageCenterViewController

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
    navigationView = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 180) * 0.5, 25, 180, 30)];
    navigationView.backgroundColor = [UIColor profitColor];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.window addSubview:navigationView];
    navigationView.layer.cornerRadius = 15;
    navigationView.layer.masksToBounds = YES;
    navigationView.layer.borderColor = [[UIColor whiteColor] CGColor];
    navigationView.layer.borderWidth = 1;
    
    buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOne.frame = CGRectMake(0, 0, navigationView.frame.size.width/2, 30);
    [buttonOne setTitle:@"公告" forState:UIControlStateNormal];
    [buttonOne setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    buttonOne.backgroundColor = [UIColor whiteColor];
    buttonOne.layer.cornerRadius = 15;
    buttonOne.layer.masksToBounds = YES;
    buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOne addTarget:self action:@selector(goToOneView:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:buttonOne];
    
    buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTwo.frame = CGRectMake(navigationView.frame.size.width/2, 0, navigationView.frame.size.width/2, 30);
    [buttonTwo setTitle:@"消息" forState:UIControlStateNormal];
    buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonTwo.backgroundColor = [UIColor clearColor];
    buttonTwo.layer.cornerRadius = 15;
    buttonTwo.layer.masksToBounds = YES;
    [buttonTwo addTarget:self action:@selector(goToTwoView:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:buttonTwo];
}

// 创建滚动试图
- (void)setMyScrollView{
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    
    myScrollView.backgroundColor = [UIColor huibai];
    myScrollView.delegate = self;
    myScrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 2, 1);
    myScrollView.pagingEnabled = YES;
    myScrollView.bounces = NO;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    
    TWOGMessageViewController *newbieVC = [[TWOGMessageViewController alloc] init];
    [self addChildViewController:newbieVC];
    [myScrollView addSubview:newbieVC.view];
    
    TWOMMessageViewController *billVC = [[TWOMMessageViewController alloc] init];
    [self addChildViewController:billVC];
    [myScrollView addSubview:billVC.view];
    billVC.view.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, myScrollView.frame.size.width, myScrollView.frame.size.height);
    
}

#pragma mark scrollView Delegate
#pragma mark --------------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    if (scrollView.contentOffset.x == WIDTH_CONTROLLER_DEFAULT) {
        [self goToTwoView:nil];
        NSLog(@"123");
    } else if (scrollView.contentOffset.x == 0) {
        [self goToOneView:nil];
        NSLog(@"321");
    }
}

#pragma mark 导航栏按钮的方法
#pragma mark --------------------------------

// 转换成公告
- (void)goToOneView:(id)sender
{
    [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonTwo.backgroundColor = [UIColor clearColor];
    [buttonOne setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    buttonOne.backgroundColor = [UIColor whiteColor];
    [myScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

// 转换成消息
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
