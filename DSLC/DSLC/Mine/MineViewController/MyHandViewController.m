//
//  MyHandViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyHandViewController.h"
#import "MyHandButton.h"

@interface MyHandViewController () <MyHandButtonDelegate>
@property (weak, nonatomic) IBOutlet MyHandButton *myHandBtn;

@end

@implementation MyHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myHandBtn.delegate = self;
}

- (void)lockView:(MyHandButton *)lockView didFinishPath:(NSString *)path{
    NSLog(@"%@",path);
    if ([path isEqualToString:@"012345678"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
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
