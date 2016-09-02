//
//  MyHandViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyHandViewController.h"
#import "KKTabBarViewController.h"
#import "MyHandButton.h"
#import "define.h"
#import "AppDelegate.h"
#import "TWOSelectionViewController.h"
#import "TWOProductViewController.h"
#import "TWOFindViewController.h"
#import "TWOMineViewController.h"
#import "TWOForgetView.h"
#import "TWOLoginAPPViewController.h"

@interface MyHandViewController () <MyHandButtonDelegate>{
    NSArray *viewControllerArr;
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
    
    NSInteger failCount;
    
    UIButton *bView;
    
    TWOForgetView *forgetView;
    
    NSDictionary *userDic;
    
    //签到猴子需要的控件
    UIButton *buttonHei;
    UIView *viewDown;
    UILabel *labelMonkey;
    UIImageView *imageSign;
    
    NSString *tempPathString;
    
    BOOL handFlag;
    
    NSDictionary *userDIC2;
}
@property (nonatomic) KKTabBarViewController *tabBarVC;

@property (weak, nonatomic) IBOutlet MyHandButton *myHandBtn;
@property (weak, nonatomic) IBOutlet MyHandButton *myTwoHandBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *otherUserButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic, strong) NSDictionary *flagLogin;

@end

@implementation MyHandViewController

// 登录标识文件
- (NSDictionary *)flagLogin{
    if (_flagLogin == nil) {
        if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
            [FileOfManage createWithFile:@"isLogin.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
        }
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
        self.flagLogin = dic;
    }
    return _flagLogin;
}

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
    // Do any additional setup after loading the view from its nib.
    
    self.myHandBtn.frame = CGRectMake(8, 162, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    self.myTwoHandBtn.frame = CGRectMake(8, 162, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    
    self.myTwoHandBtn.hidden = YES;
    
    self.myHandBtn.delegate = self;
    self.myTwoHandBtn.delegate = self;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
    
    userDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    self.userPhone.text = [[userDic objectForKey:@"phone"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    userDIC2 = [dic objectForKey:[userDic objectForKey:@"phone"]];
    
    NSLog(@"userDIC2 = %@",userDIC2);
    
    failCount = 5;
    
    tempPathString = @"1";
    
    if (userDIC2 == nil) {
        
        handFlag = YES;
    } else {
        
        handFlag = [[userDIC2 objectForKey:@"ifSetHandFlag"] boolValue];
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"%d",handFlag?1:0]);
    
    if (handFlag) {
        
        self.titleLabel.text = @"请设置手势密码";
        self.cancelButton.hidden = NO;
        self.userPhone.hidden = YES;
    } else {
        
        // YES: 关闭手势密码  NO: 手势密码界面验证
        if (self.flagString != nil) {
            
            self.titleLabel.text = @"验证手势密码";
            self.userPhone.hidden = YES;
            self.otherUserButton.hidden = YES;
            self.forgetButton.hidden = YES;
            self.cancelButton.hidden = NO;
        } else {
            
            self.titleLabel.text = @"请输入解锁图案";
            self.otherUserButton.hidden = NO;
            self.forgetButton.hidden = NO;
            self.cancelButton.hidden = YES;
        }
    }
    
    [self.forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.otherUserButton addTarget:self action:@selector(otherUserWithAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)lockView:(MyHandButton *)lockView didFinishPath:(NSString *)path{
    
    if (handFlag) {
        
        self.titleLabel.text = @"请设置手势密码";
        self.userPhone.hidden = YES;
        
        if (lockView == self.myHandBtn) {
            
            if (path.length >= 4) {
                
                tempPathString = path;
                
                self.myTwoHandBtn.hidden = NO;
                
                self.myHandBtn.hidden = YES;
                
                NSLog(@"tempPathString%@",tempPathString);
                
                self.titleLabel.text = @"请再次确认手势密码";
            } else {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"为了你的账号安全,手势密码需要至少连线4个点."];
            }
        }  else if (lockView == self.myTwoHandBtn) {
            if ([tempPathString isEqualToString:path]) {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手势密码设置成功"];
                
                NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
                
                NSLog(@"phone1 = %@",[userDic objectForKey:@"phone"]);
                NSLog(@"userDIC1 = %@",userDIC2);
                
                NSMutableDictionary *handDic = [NSMutableDictionary dictionary];
                
                [handDic setValue:@"YES" forKey:@"handFlag"];
                [handDic setValue:path forKey:@"handString"];
                [handDic setValue:@"NO" forKey:@"ifSetHandFlag"];
                
                [dic setValue:handDic forKey:[userDic objectForKey:@"phone"]];
                
                [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
                
                [self getDataOpen];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"switchOpenButton" object:nil];
                popVC;
            } else {
                NSLog(@"%@",tempPathString);
                
                self.titleLabel.text = @"请再次设置手势密码";
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手势密码不一致,请再次输入"];
            }
        }
    } else {
        self.titleLabel.text = @"验证手势密码";
        if (self.flagString != nil) {
            
            self.otherUserButton.hidden = YES;
            self.forgetButton.hidden = YES;
            self.cancelButton.hidden = NO;
            
            NSString *handString = [userDIC2 objectForKey:@"handString"];
            if ([path isEqualToString:handString]) {
                NSDictionary *usDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
                
                NSDictionary *userDICT = [usDic objectForKey:[userDic objectForKey:@"phone"]];
                
                [userDICT setValue:@"NO" forKey:@"handFlag"];
                [userDICT setValue:@"" forKey:@"handString"];
                [userDICT setValue:@"YES" forKey:@"ifSetHandFlag"];
                
                [usDic setValue:userDICT forKey:[userDic objectForKey:@"phone"]];
                
                [usDic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手势密码成功关闭"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"switchButton" object:nil];
                popVC;
            } else {
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"您输入的手势密码错误，请重试"];
            }
        } else {
            
            --failCount;
            if (failCount == 0) {
                [self otherUserWithAction:nil];
            } else {
            
                NSString *handString = [userDIC2 objectForKey:@"handString"];
                NSLog(@"%@",handString);
                if ([path isEqualToString:handString]) {
                    
                    [UIView animateWithDuration:1.0f animations:^{
                        
                        self.view.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        
                        //        2.0首页
                        TWOSelectionViewController *twoSelectionVC = [[TWOSelectionViewController alloc] init];
                        UINavigationController *twoNavigation1 = [[UINavigationController alloc] initWithRootViewController:twoSelectionVC];
                        
                        //        2.0产品
                        TWOProductViewController *twoproductVC = [[TWOProductViewController alloc] init];
                        UINavigationController *twoNavigation = [[UINavigationController alloc] initWithRootViewController:twoproductVC];
                        
                        //        2.0发现
                        TWOFindViewController *findVC = [[TWOFindViewController alloc] init];
                        UINavigationController *navigationFind = [[UINavigationController alloc] initWithRootViewController:findVC];
                        
                        //        2.0我的
                        TWOMineViewController *twoMineVC = [[TWOMineViewController alloc] init];
                        //        TWOLoginAPPViewController *loginAPPVC = [[TWOLoginAPPViewController alloc] init];
                        UINavigationController *navigationTwoMine = [[UINavigationController alloc] initWithRootViewController:twoMineVC];
                        
                        //        2.0
                        viewControllerArr = @[twoNavigation1, twoNavigation, navigationFind, navigationTwoMine];
                        
                        ////        2.0
                        butGrayArr = @[@"selection_gray", @"production_gray", @"found_gray", @"mine_gray"];
                        butColorArr = @[@"selection", @"production", @"found", @"mine"];
                        
                        //        for循环4要改成3***********************************
                        buttonArr = [NSMutableArray array];
                        for (int i = 0; i < 4; i++) {
                            
                            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                            //       button的frame值在第三方中已设置好,默认为50,如有设置需求,需手动改
                            //        button.imageView.backgroundColor = [UIColor whiteColor];
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butGrayArr objectAtIndex:i]]] forState:UIControlStateNormal];
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butColorArr objectAtIndex:i]]] forState:UIControlStateSelected];
                            //       点击保持高亮状态,没有闪动的效果
                            [button setShowsTouchWhenHighlighted:YES];
                            [buttonArr addObject:button];
                        }
                        
                        self.tabBarVC = [[KKTabBarViewController alloc] init];
                        //    存放试图控制器
                        [self.tabBarVC setControllerArray:viewControllerArr];
                        //    存放tabBar上的按钮
                        [self.tabBarVC setTabButtonArray:buttonArr];
                        //    设置tabBar的高度 默认为50
                        [self.tabBarVC setTabBarHeight:35];
                        //    设置是否可以手势滑动切换模块 默认为YES
                        [self.tabBarVC setSuppurtGestureTransition:NO];
                        //    设置点击按钮有无翻页效果 默认有
                        [self.tabBarVC setTransitionAnimated:NO];
                        
                        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                        app.tabBarVC = self.tabBarVC;
                        app.window.rootViewController = self.tabBarVC;
                        
                        if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"YES"]){
                            [self loginFuction];
                        }
                    }];
                    
                } else {
                    [ProgressHUD showMessage:[NSString stringWithFormat:@"手势密码错误，请重新输入，您还有%ld次机会",(long)failCount] Width:100 High:20];
                }
            }
        }
        
    }
}

- (void)forgetAction:(id)sender{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    bView = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:Color_Black textColor:nil titleText:nil];
    
    bView.alpha = 0.3;
    
    [bView addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [app.window addSubview:bView];
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    forgetView = (TWOForgetView *)[[rootBundle loadNibNamed:@"TWOForgetView" owner:nil options:nil] lastObject];
    
    forgetView.layer.masksToBounds = YES;
    forgetView.layer.cornerRadius = 4.f;
    
    forgetView.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 330) * 0.5, (HEIGHT_CONTROLLER_DEFAULT - 200) * 0.5, 330, 200);
    
    [forgetView.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [forgetView.sureButton addTarget:self action:@selector(sureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [forgetView.layer addAnimation:animation forKey:nil];
    
    [app.window addSubview:forgetView];
}

//关闭按钮
- (void)closeButton:(UIButton *)but{
    
    [bView removeFromSuperview];
    [forgetView removeFromSuperview];
    
    bView = nil;
    forgetView = nil;
}

- (void)sureButton:(UIButton *)but{
    [self otherUserWithAction:but];
    
    [bView removeFromSuperview];
    [forgetView removeFromSuperview];
    
    bView = nil;
    forgetView = nil;
}

- (void)cancelAction:(id)sender{
    
    popVC;
    
}

- (void)otherUserWithAction:(id)sender{
    
    //        2.0首页
    TWOSelectionViewController *twoSelectionVC = [[TWOSelectionViewController alloc] init];
    UINavigationController *twoNavigation1 = [[UINavigationController alloc] initWithRootViewController:twoSelectionVC];
    
    //        2.0产品
    TWOProductViewController *twoproductVC = [[TWOProductViewController alloc] init];
    UINavigationController *twoNavigation = [[UINavigationController alloc] initWithRootViewController:twoproductVC];
    
    //        2.0发现
    TWOFindViewController *findVC = [[TWOFindViewController alloc] init];
    UINavigationController *navigationFind = [[UINavigationController alloc] initWithRootViewController:findVC];
    
    //        2.0我的
    TWOMineViewController *twoMineVC = [[TWOMineViewController alloc] init];
    //        TWOLoginAPPViewController *loginAPPVC = [[TWOLoginAPPViewController alloc] init];
    UINavigationController *navigationTwoMine = [[UINavigationController alloc] initWithRootViewController:twoMineVC];
    
    //        2.0
    viewControllerArr = @[twoNavigation1, twoNavigation, navigationFind, navigationTwoMine];
    
    ////        2.0
    butGrayArr = @[@"selection_gray", @"production_gray", @"found_gray", @"mine_gray"];
    butColorArr = @[@"selection", @"production", @"found", @"mine"];
    
    //        for循环4要改成3***********************************
    buttonArr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //       button的frame值在第三方中已设置好,默认为50,如有设置需求,需手动改
        //        button.imageView.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butGrayArr objectAtIndex:i]]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butColorArr objectAtIndex:i]]] forState:UIControlStateSelected];
        //       点击保持高亮状态,没有闪动的效果
        [button setShowsTouchWhenHighlighted:YES];
        [buttonArr addObject:button];
    }
    
    self.tabBarVC = [[KKTabBarViewController alloc] init];
    //    存放试图控制器
    [self.tabBarVC setControllerArray:viewControllerArr];
    //    存放tabBar上的按钮
    [self.tabBarVC setTabButtonArray:buttonArr];
    //    设置tabBar的高度 默认为50
    [self.tabBarVC setTabBarHeight:35];
    //    设置是否可以手势滑动切换模块 默认为YES
    [self.tabBarVC setSuppurtGestureTransition:NO];
    //    设置点击按钮有无翻页效果 默认有
    [self.tabBarVC setTransitionAnimated:NO];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.tabBarVC = self.tabBarVC;
    app.window.rootViewController = self.tabBarVC;
    
    TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
    
    UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:loginVC];
    [nvc setNavigationBarHidden:YES animated:YES];
    
    [app.tabBarVC presentViewController:nvc animated:YES completion:^{
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
                                 @"",@"accBalance",
                                 @"",@"realnameStatus",
                                 @"",@"realName",
                                 @"",@"chinaPnrAcc",
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
                                 @"",@"accBalance",
                                 @"",@"realnameStatus",
                                 @"",@"realName",
                                 @"",@"chinaPnrAcc",
                                 @"",@"token",
                                 @"",@"registerTime",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
        }
        
        if (![FileOfManage ExistOfFile:@"handOpen.plist"]) {
            [FileOfManage createWithFile:@"handOpen.plist"];
            NSDictionary *usDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
            
            NSDictionary *userDIC = [usDic objectForKey:[userDic objectForKey:@"phone"]];
            
            [userDIC setValue:@"NO" forKey:@"handFlag"];
            [userDIC setValue:@"" forKey:@"handString"];
            [userDIC setValue:@"YES" forKey:@"ifSetHandFlag"];
            
            [usDic setValue:userDIC forKey:[userDic objectForKey:@"phone"]];
            
            [usDic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
        } else {
            NSDictionary *usDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
            
            NSDictionary *userDIC = [usDic objectForKey:[userDic objectForKey:@"phone"]];
            
            [userDIC setValue:@"NO" forKey:@"handFlag"];
            [userDIC setValue:@"" forKey:@"handString"];
            [userDIC setValue:@"YES" forKey:@"ifSetHandFlag"];
            
            [usDic setValue:userDIC forKey:[userDic objectForKey:@"phone"]];
            
            [usDic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
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
    }];
}

#pragma mark 自动登录
#pragma mark --------------------------------

- (void)loginFuction{
    
    NSDictionary *parmeter = @{@"phone":[userDic objectForKey:@"phone"],@"password":[userDic objectForKey:@"password"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"login" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"register = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@200]) {
            //            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            
            if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                [FileOfManage createWithFile:@"Member.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [userDic objectForKey:@"password"],@"password",
                                     [userDic objectForKey:@"phone"],@"phone",
                                     [responseObject objectForKey:@"key"],@"key",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                     [responseObject objectForKey:@"token"],@"token",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",
                                     [responseObject objectForKey:@""],nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [userDic objectForKey:@"password"],@"password",
                                     [userDic objectForKey:@"phone"],@"phone",
                                     [responseObject objectForKey:@"key"],@"key",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"accBalance"],@"accBalance",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realnameStatus"],@"realnameStatus",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"realName"],@"realName",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"chinaPnrAcc"],@"chinaPnrAcc",
                                     [responseObject objectForKey:@"token"],@"token",
                                     [[responseObject objectForKey:@"User"] objectForKey:@"registerTime"],@"registerTime",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                NSLog(@"%@",[responseObject objectForKey:@"token"]);
            }

            
            // 判断是否存在isLogin.plist文件
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            
            [self getMyAccountInfoFuction];
            
            [self userSign];
    
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            
            // 判断是否存在isLogin.plist文件
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)getMyAccountInfoFuction{
    
    NSMutableDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":[memberDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getMyAccountInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [memberDic setObject:[responseObject objectForKey:@"invitationMyCode"] forKey:@"invitationMyCode"];
            
            [memberDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)userSign{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    NSMutableDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":[memberDic objectForKey:@"token"],@"signDate":dateString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sign/userSign" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"userSign = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            if (![[responseObject objectForKey:@"signMonkeyNum"] isEqualToString:@"0"]){
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showMonkey" object:[responseObject objectForKey:@"signMonkeyNum"]];
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
}

//获取系统菜单列表
- (void)getDataOpen
{
    NSDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"types":@"6",@"token":[memberDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"task/userFinishTask" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"&*&*&*&*&*&*%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            // 刷新任务中心列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"taskListFuction" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"wwwwwwwwwwwwwwwwwwwwwwwwww%@", error);
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
