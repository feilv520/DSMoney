//
//  GetMoneyVerifyViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "GetMoneyVerifyViewController.h"
#import "define.h"
#import "ForgetPasswordViewController.h"

@interface GetMoneyVerifyViewController ()
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UIView *yueView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumber;

@end

@implementation GetMoneyVerifyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTXMoney:self.moneyString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"提现验证"];
    [self setQRButton];
}
- (IBAction)forgetButtonAction:(id)sender {
    ForgetPasswordViewController *forgetPVC = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPVC animated:YES];
}

- (void)setQRButton{
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 120, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [payButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:payButton];
}

- (void)sureButtonAction:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"确定"]){
        self.yueView.hidden = YES;
        self.passwordView.hidden = YES;
        self.successView.hidden = NO;
        [btn setTitle:@"去赚钱" forState:UIControlStateNormal];
    } else if ([btn.titleLabel.text isEqualToString:@"去赚钱"]){
        self.yueView.hidden = NO;
        self.passwordView.hidden = NO;
        self.successView.hidden = YES;
        [btn setTitle:@"确定" forState:UIControlStateNormal];
    }
}

- (void)setTXMoney:(NSString *)moneyNumber{
    self.moneyNumber.text = moneyNumber;
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
