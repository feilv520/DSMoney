//
//  BillViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BillViewController.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "FinancingViewController.h"
#import "NewbieViewController.h"

@interface BillViewController ()

{
    UIScrollView *scrollView;
    UIButton *butThree;
    NSArray *butThrArr;
    UILabel *labelLine;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
    FinancingViewController *financingVC;
    NewbieViewController *newbieVC;
    
    NSInteger make;
}

@end

@implementation BillViewController

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
    butThrArr = @[@"新手专享", @"固收理财", @"票据投资"];
    
    scrollView = [CreatView creatWithScrollViewFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45) backgroundColor:[UIColor whiteColor] contentSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT/3, 0) contentOffSet:CGPointMake(0, 0)];
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 3; i++) {
        
        butThree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 * i, 0, WIDTH_CONTROLLER_DEFAULT/3, 45) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:[NSString stringWithFormat:@"%@", [butThrArr objectAtIndex:i]]];
        [scrollView addSubview:butThree];
        butThree.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        butThree.tag = 200 + i;
        [butThree addTarget:self action:@selector(buttonChooseWHichOne:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 1) {
            
            [butThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    labelLine = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/3, 43, WIDTH_CONTROLLER_DEFAULT/3, 2) backgroundColor:[UIColor daohanglan] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [self.view addSubview:labelLine];
}

- (void)buttonChooseWHichOne:(UIButton *)button
{
    button1 = (UIButton *)[self.view viewWithTag:200];
    button2 = (UIButton *)[self.view viewWithTag:201];
    button3 = (UIButton *)[self.view viewWithTag:202];
    
    if (butThree.tag == 202) {
        
        make = 0;
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            labelLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 * 2, 43, WIDTH_CONTROLLER_DEFAULT/3, 2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        financingVC = [[FinancingViewController alloc] init];
        [self addChildViewController:financingVC];
        [self.view addSubview:financingVC.view];
        
        financingVC.view.frame = CGRectMake(0, 45, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53);
        
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        
    } else if (butThree.tag == 201) {
        
        [financingVC.view removeFromSuperview];
        [financingVC removeFromParentViewController];
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            labelLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3, 43, WIDTH_CONTROLLER_DEFAULT/3, 2);
            
        } completion:^(BOOL finished) {
            
        }];
        
        BillViewController *billVC = [[BillViewController alloc] init];
        [self addChildViewController:billVC];
        [self.view addSubview:billVC.view];
        
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        
    } else {
        
        
    }
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
