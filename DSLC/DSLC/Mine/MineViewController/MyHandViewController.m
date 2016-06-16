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
    
    NSInteger count;
    
    UIButton *bView;
    
    TWOForgetView *forgetView;
}
@property (nonatomic) KKTabBarViewController *tabBarVC;

@property (weak, nonatomic) IBOutlet MyHandButton *myHandBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *otherUserButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation MyHandViewController

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
    
    self.myHandBtn.delegate = self;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
    
//    NSDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
//    self.userPhone.text = [[DES3Util decrypt:[userDic objectForKey:@"userPhone"]] stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
    self.userPhone.text = [@"13354288036" stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    BOOL handFlag = [[dic objectForKey:@"ifSetHandFlag"] boolValue];
    
    if (handFlag) {
        
        self.titleLabel.text = @"请设置手势密码";
        self.cancelButton.hidden = NO;
    } else {
        
        self.titleLabel.text = @"请输入解锁图案";
        self.otherUserButton.hidden = NO;
        self.forgetButton.hidden = NO;
        self.cancelButton.hidden = YES;
        
    }
    
    [self.forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    count = 5;
}

- (void)lockView:(MyHandButton *)lockView didFinishPath:(NSString *)path{
//    if ([path isEqualToString:@"012"]) {
//        
//        ////        1.0首页
//        //        TSelectionViewController *selectionVC = [[TSelectionViewController alloc] init];
//        //        UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:selectionVC];
//        //
//        ////        1.0产品
//        //        ThreeViewController *threeVC = [[ThreeViewController alloc] init];
//        //        UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:threeVC];
//        //
//        ////        1.0我的
//        //        MineViewController *mineVC = [[MineViewController alloc] init];
//        ////        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        //        UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:mineVC];
//        
//        //        2.0首页
//        TWOSelectionViewController *twoSelectionVC = [[TWOSelectionViewController alloc] init];
//        UINavigationController *twoNavigation1 = [[UINavigationController alloc] initWithRootViewController:twoSelectionVC];
//        
//        //        2.0产品
//        TWOProductViewController *twoproductVC = [[TWOProductViewController alloc] init];
//        UINavigationController *twoNavigation = [[UINavigationController alloc] initWithRootViewController:twoproductVC];
//        
//        //        2.0发现
//        TWOFindViewController *findVC = [[TWOFindViewController alloc] init];
//        UINavigationController *navigationFind = [[UINavigationController alloc] initWithRootViewController:findVC];
//        
//        //        2.0我的
//        TWOMineViewController *twoMineVC = [[TWOMineViewController alloc] init];
//        UINavigationController *navigationTwoMine = [[UINavigationController alloc] initWithRootViewController:twoMineVC];
//        
//        //        2.0
//        //        self.viewControllerArr = @[twoNavigation1, twoNavigation, navigationTwoMine];
//        viewControllerArr = @[twoNavigation1, twoNavigation, navigationFind, navigationTwoMine];
//        //        1.0
//        //        self.viewControllerArr = @[navigation1, navigation2, navigation3];
//        
//        //        2.0
//        butGrayArr = @[@"iconfont-jingxuan", @"shouyeqiepian750_28", @"faxian", @"iconfont-iconfuzhi"];
//        butColorArr = @[@"iconfont-jingxuan-highlight", @"shouyeqiepian7500_28highlight", @"faxianclick", @"iconfont-iconfuzhi-highlight"];
//        
//        ////        1.0
//        //        butGrayArr = @[@"iconfont-jingxuan", @"shouyeqiepian750_28", @"iconfont-iconfuzhi"];
//        //        butColorArr = @[@"iconfont-jingxuan-highlight", @"shouyeqiepian7500_28highlight", @"iconfont-iconfuzhi-highlight"];
//        
//        //        for循环4要改成3***********************************
//        buttonArr = [NSMutableArray array];
//        for (int i = 0; i < 4; i++) {
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            //       button的frame值在第三方中已设置好,默认为50,如有设置需求,需手动改
//            //        button.imageView.backgroundColor = [UIColor whiteColor];
//            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butGrayArr objectAtIndex:i]]] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butColorArr objectAtIndex:i]]] forState:UIControlStateSelected];
//            //       点击保持高亮状态,没有闪动的效果
//            [button setShowsTouchWhenHighlighted:YES];
//            [buttonArr addObject:button];
//        }
//        
//        self.tabBarVC = [[KKTabBarViewController alloc] init];
//        //    存放试图控制器
//        [self.tabBarVC setControllerArray:viewControllerArr];
//        //    存放tabBar上的按钮
//        [self.tabBarVC setTabButtonArray:buttonArr];
//        //    设置tabBar的高度 默认为50
//        [self.tabBarVC setTabBarHeight:35];
//        //    设置是否可以手势滑动切换模块 默认为YES
//        [self.tabBarVC setSuppurtGestureTransition:NO];
//        //    设置点击按钮有无翻页效果 默认有
//        [self.tabBarVC setTransitionAnimated:NO];
//        
//        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        app.tabBarVC = self.tabBarVC;
//        app.window.rootViewController = self.tabBarVC;
//        
//    } else {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController:alert animated:YES completion:^{
//            
//        }];
//    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
    
    BOOL handFlag = [[dic objectForKey:@"ifSetHandFlag"] boolValue];
    
    if (handFlag) {
        self.titleLabel.text = @"请设置手势密码";
        if (path.length >= 4) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手势密码设置成功"];
            [dic setValue:path forKey:@"handString"];
            [dic setValue:@"NO" forKey:@"ifSetHandFlag"];
            [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
            popVC;
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"为了你的账号安全,手势密码需要至少连线4个点."];
        }
    } else {
        self.titleLabel.text = @"请输入解锁图案";
        if (self.flagString != nil) {
            NSString *handString = [dic objectForKey:@"handString"];
            if ([path isEqualToString:handString]) {
                [dic setValue:@"YES" forKey:@"ifSetHandFlag"];
                [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手势密码成功关闭"];
                popVC;
            }
        } else {
            NSString *handString = [dic objectForKey:@"handString"];
            NSLog(@"%@",handString);
            if ([path isEqualToString:handString]) {
                
//                [UIView animateWithDuration:0.5 animations:^{
//                    
//                    self.backgroundImageView.alpha = 0.0;
//                    self.myHandBtn.alpha = 0.0;
//                    
//                } completion:^(BOOL finished) {
                
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
                    //        1.0
                    //        self.viewControllerArr = @[navigation1, navigation2, navigation3];
                    
                    ////        2.0
                    butGrayArr = @[@"selection_gray", @"production_gray", @"found_gray", @"mine_gray"];
                    butColorArr = @[@"selection", @"production", @"found", @"mine"];
                    
                    ////        1.0
                    //        butGrayArr = @[@"iconfont-jingxuan", @"shouyeqiepian750_28", @"iconfont-iconfuzhi"];
                    //        butColorArr = @[@"iconfont-jingxuan-highlight", @"shouyeqiepian7500_28highlight", @"iconfont-iconfuzhi-highlight"];
                    
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
                    
//                }];
            } else {
                
                [ProgressHUD showMessage:@"密码错误" Width:100 High:20];
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
    TWOLoginAPPViewController *loginAPPVC = [[TWOLoginAPPViewController alloc] init];
    [self presentViewController:loginAPPVC animated:YES completion:^{
        
    }];
    
    [bView removeFromSuperview];
    [forgetView removeFromSuperview];
    
    bView = nil;
    forgetView = nil;
}

- (void)cancelAction:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switchButton" object:nil];
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
