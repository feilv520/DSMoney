//
//  MoreViewController.m
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MoreViewController.h"
#import "CreatView.h"
#import "define.h"
#import "UIColor+AddColor.h"

@interface MoreViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self naviagationShow];
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    self.navigationItem.title = @"更多";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
