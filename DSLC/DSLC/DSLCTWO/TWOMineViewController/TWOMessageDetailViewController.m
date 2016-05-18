//
//  TWOMessageDetailViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMessageDetailViewController.h"

@interface TWOMessageDetailViewController ()

@end

@implementation TWOMessageDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = @"喜大普奔,大圣理财APP2.0版本上线啦!";
    
    self.dateLabel.text = @"2016-09-09 8:30";
    
    self.valueLabel.text = @"经过小伙伴们两个月的努力,大圣理财2.0版本终于上线啦!大圣理财,专注银行信贷资产经过小伙伴们两个月的努力,大圣理财2.0版本终于上线啦!大圣理财,专注银行信贷资产经过小伙伴们两个月的努力,大圣理财2.0版本终于上线啦!大圣理财,专注银行信贷资产经过小伙伴们两个月的努力,大圣理财2.0版本终于上线啦!大圣理财,专注银行信贷资产经过小伙伴们两个月的努力,大圣理财2.0版本终于上线啦!大圣理财,专注银行信贷资产";
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
