//
//  BigMoneyViewController.m
//  DSLC
//
//  Created by ios on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BigMoneyViewController.h"
#import "BaseViewController.h"

@interface BigMoneyViewController ()

@end

@implementation BigMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setTitleString:@"大额充值申请"];
    
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
