//
//  FSelectionPayTypeViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/14.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FSelectionPayTypeViewController.h"
#import "CreatView.h"
#import "FBalancePaymentViewController.h"
#import "FQuickPayViewController.h"

@interface FSelectionPayTypeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yueButton;
@property (weak, nonatomic) IBOutlet UIButton *quickButton;
@property (weak, nonatomic) IBOutlet UIButton *netButton;

@end

@implementation FSelectionPayTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationItem setTitle:@"选择支付"];
}

// 余额支付方法
- (IBAction)yueButtonAction:(id)sender {
    [self.yueButton setSelected:YES];
    [self.quickButton setSelected:NO];
    [self.netButton setSelected:NO];
}

// 快捷支付方法
- (IBAction)quickButtonAction:(id)sender {
    [self.yueButton setSelected:NO];
    [self.quickButton setSelected:YES];
    [self.netButton setSelected:NO];
}

// 网银支付方法
- (IBAction)netButtonAction:(id)sender {
    [self.yueButton setSelected:NO];
    [self.quickButton setSelected:NO];
    [self.netButton setSelected:YES];
}

// 下一步方法
- (IBAction)nextButtonAction:(id)sender {
    if (self.yueButton.selected) {
        FBalancePaymentViewController *balancePaymentVC = [[FBalancePaymentViewController alloc] init];
        [self.navigationController pushViewController:balancePaymentVC animated:YES];
    } else if(self.quickButton.selected) {
        FQuickPayViewController *quickpayVC = [[FQuickPayViewController alloc] init];
        [self.navigationController pushViewController:quickpayVC animated:YES];
    } else if(self.netButton.selected) {
        NSLog(@"%@",sender);
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
