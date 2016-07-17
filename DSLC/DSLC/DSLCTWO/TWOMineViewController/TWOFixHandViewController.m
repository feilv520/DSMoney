//
//  TWOFixHandViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOFixHandViewController.h"
#import "MyHandButton.h"
#import "define.h"
#import "AppDelegate.h"


@interface TWOFixHandViewController () <MyHandButtonDelegate>{
    NSString *newString;
}

@property (weak, nonatomic) IBOutlet MyHandButton *handButton;
@property (weak, nonatomic) IBOutlet MyHandButton *firstHandButton;
@property (weak, nonatomic) IBOutlet MyHandButton *secondHandButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *passButton;

@end

@implementation TWOFixHandViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.handButton.frame = CGRectMake(8, 162, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    self.firstHandButton.frame = CGRectMake(8, 162, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    self.firstHandButton.hidden = YES;
    self.secondHandButton.frame = CGRectMake(8, 162, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    self.secondHandButton.hidden = YES;
    self.handButton.delegate = self;
    self.firstHandButton.delegate = self;
    self.secondHandButton.delegate = self;
    
    self.titleLabel.text = @"请输入原手势密码";
    
    [self.passButton addTarget:self action:@selector(passAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)lockView:(MyHandButton *)lockView didFinishPath:(NSString *)path{
    
    NSDictionary *userDetailDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
    
    NSDictionary *userDIC = [dic objectForKey:[userDetailDic objectForKey:@"phone"]];
    
    NSString *handString = [userDIC objectForKey:@"handString"];
    
    if (lockView == self.handButton) {
        if ([path isEqualToString:handString]) {

            self.titleLabel.text = @"请输入新手势密码";
            self.handButton.hidden = YES;
            
            self.firstHandButton.hidden = NO;
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手势密码错误"];
        }
    } else if (lockView == self.firstHandButton) {
        
        self.titleLabel.text = @"请再次输入新手势密码";
        
        newString = path;
        
        NSLog(@"%@",newString);
        
        self.firstHandButton.hidden = YES;
        
        self.secondHandButton.hidden = NO;
        
    } else if (lockView == self.secondHandButton) {
        
        NSLog(@"%@--%@",path,newString);
        
        if ([path isEqualToString:newString]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手势密码设置成功"];
            
            [userDIC setValue:path forKey:@"handString"];
            
            [dic setValue:userDIC forKey:[userDetailDic objectForKey:@"phone"]];
            
            [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
            popVC;
        }
        
    }
    
}

- (void)passAction:(id)sender{
    
    popVC;
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
