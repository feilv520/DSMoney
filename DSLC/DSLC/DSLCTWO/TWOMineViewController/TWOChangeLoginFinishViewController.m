//
//  TWOChangeLoginFinishViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOChangeLoginFinishViewController.h"
#import "TWOLoginAPPViewController.h"

@interface TWOChangeLoginFinishViewController ()
{
    UIButton *indexButton;
}
@end

@implementation TWOChangeLoginFinishViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageReturn.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.state == YES) {
        [self.navigationItem setTitle:@"设置成功"];
    } else {
        [self.navigationItem setTitle:@"修改成功"];
    }
    
    [self contentShow];
}

- (void)contentShow
{
    UIImageView *imageSetFinish = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 75, 20, 150, 150)];
    [self.view addSubview:imageSetFinish];
    imageSetFinish.backgroundColor = [UIColor whiteColor];
    if (self.state == YES) {
        imageSetFinish.image = [UIImage imageNamed:@"setFinish"];
    } else {
        imageSetFinish.image = [UIImage imageNamed:@"登录密码修改成功"];
    }
    
    UIButton *butLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 150 + 50, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"请重新登录账号"];
    [self.view addSubview:butLogin];
    butLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butLogin.layer.cornerRadius = 5;
    butLogin.layer.masksToBounds = YES;
    [butLogin addTarget:self action:@selector(buttonLogin:) forControlEvents:UIControlEventTouchUpInside];
}

//重新登录按钮
- (void)buttonLogin:(UIButton *)button
{
//    TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
//
//    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [nvc setNavigationBarHidden:YES animated:YES];
//
//    [self presentViewController:nvc animated:YES completion:^{
//
//    }];
    [self logoutFuction];
}

- (void)logoutFuction{
    NSDictionary *parmeter = @{@"userId":[self.flagDic objectForKey:@"phone"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"logout" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"register = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@200]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
//            [self.navigationController popToRootViewControllerAnimated:YES];
            
            if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                [FileOfManage createWithFile:@"Member.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     @"1",@"phone",
                                     @"",@"key",
                                     @"",@"id",
                                     @"",@"userNickname",
                                     @"",@"avatarImg",
                                     @"",@"userAccount",
                                     @"",@"userPhone",
                                     @"",@"token",
                                     @"",@"registerTime",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     @"1",@"phone",
                                     @"",@"key",
                                     @"",@"id",
                                     @"",@"userNickname",
                                     @"",@"avatarImg",
                                     @"",@"userAccount",
                                     @"",@"userPhone",
                                     @"",@"token",
                                     @"",@"registerTime",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                NSLog(@"%@",[responseObject objectForKey:@"token"]);
            }
            
            if (![FileOfManage ExistOfFile:@"handOpen.plist"]) {
                [FileOfManage createWithFile:@"handOpen.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"handFlag",@"YES",@"ifSetHandFlag",@"",@"handString",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"handFlag",@"YES",@"ifSetHandFlag",@"",@"handString",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
            }
            
            // 判断是否存在isLogin.plist文件
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            
            [app.tabBarVC setSuppurtGestureTransition:NO];
            [app.tabBarVC setTabbarViewHidden:NO];
            [app.tabBarVC setLabelLineHidden:NO];
            
            indexButton = app.tabBarVC.tabButtonArray[0];
            
            for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
                
                if (indexButton.tag != tempButton.tag) {
                    NSLog(@"%ld",(long)tempButton.tag);
                    [tempButton setSelected:NO];
                }
            }
            
            [indexButton setSelected:YES];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
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
