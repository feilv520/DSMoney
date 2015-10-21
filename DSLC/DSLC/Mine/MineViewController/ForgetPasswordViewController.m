//
//  ForgetPasswordViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sendCode;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setQRButton];
    
    self.sendCode.layer.masksToBounds = YES;
    self.sendCode.layer.cornerRadius = 4.0f;
    
    self.sendCode.layer.borderWidth = 1.0f;
    self.sendCode.layer.borderColor = Color_Red.CGColor;
    
}

- (void)setQRButton{
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 260, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [payButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:payButton];
}

- (void)sureButtonAction:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}
- (IBAction)sendCodeButtonAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发送成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
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
