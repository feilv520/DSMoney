//
//  AppDelegate.m
//  DSLC
//
//  Created by 马成铭 on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectionViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import "MyHandViewController.h"
#import "FileOfManage.h"
#import "ThreeViewController.h"
#import "define.h"
#import "LoginViewController.h"


@interface AppDelegate ()
{
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
}
@property (nonatomic, strong) NSDictionary *flagDic;
@property (nonatomic, strong) NSDictionary *flagLogin;
@property (nonatomic, strong) NSDictionary *flagUserInfo;
@end

@implementation AppDelegate

// 手势标识文件
- (NSDictionary *)flagDic{
    if (_flagDic == nil) {

        if (![FileOfManage ExistOfFile:@"Flag.plist"]) {
            [FileOfManage createWithFile:@"Flag.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"FlagWithVC",@"YES",@"FristOpen",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"Flag.plist"] atomically:YES];
        }
        
        NSDictionary *dics = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Flag.plist"]];
        _flagDic = dics;
    }
    return _flagDic;
}

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self exitNetwork];
    
    [UMSocialData setAppKey:@"56447cbc67e58efd78001914"];
    
    [UMSocialWechatHandler setWXAppId:@"wx66e42cb8f7320c64" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    
    [UMSocialQQHandler setQQWithAppId:@"1104923253" appKey:@"MNbKfU7inKrzxAvU" url:@"http://www.umeng.com/social"];
    
    NSDictionary *dic = self.flagDic;
    
    NSString *flag = [dic objectForKey:@"FlagWithVC"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([flag isEqualToString:@"NO"]) {
        SelectionViewController *selectionVC = [[SelectionViewController alloc] init];
        UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:selectionVC];
        
        ThreeViewController *threeVC = [[ThreeViewController alloc] init];
        UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:threeVC];
        
//        MineViewController *mineVC = [[MineViewController alloc] init];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        MoreViewController *moreVC = [[MoreViewController alloc] init];
        UINavigationController *navigation4 = [[UINavigationController alloc] initWithRootViewController:moreVC];
        
        self.viewControllerArr = @[navigation1, navigation2, navigation3, navigation4];
        
//        if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:loginVC];
//            NSMutableArray *muTabButtonArray = [NSMutableArray arrayWithArray:self.viewControllerArr];
//            [muTabButtonArray replaceObjectAtIndex:2 withObject:navigation3];
//            self.viewControllerArr = [muTabButtonArray copy];
//        } else {
//            NSDictionary *parameter = @{@"phone":[self.flagUserInfo objectForKey:@"userPhone"],@"password":[self.flagUserInfo objectForKey:@"password"]};
//            [[MyAfHTTPClient sharedClient] postWithURLString:@"app/login" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
//                
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"%@",error);
//            }];
//
//        }
        
        butGrayArr = @[@"shouyeqiepian7500_25", @"shouyeqiepian750_28", @"shouyeqiepian750_30", @"shouyeqiepian750_32"];
        butColorArr = @[@"shouyeqiepian750_25_highlight", @"shouyeqiepian7500_28highlight", @"shouyeqiepian7500_30highlight", @"shouyeqiepian7500_32highlight"];
        
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
        [self.tabBarVC setControllerArray:self.viewControllerArr];
        //    存放tabBar上的按钮
        [self.tabBarVC setTabButtonArray:buttonArr];
        //    设置tabBar的高度 默认为50
        [self.tabBarVC setTabBarHeight:40];
        //    设置是否可以手势滑动切换模块 默认为YES
        [self.tabBarVC setSuppurtGestureTransition:YES];
        //    设置点击按钮有无翻页效果 默认有
        [self.tabBarVC setTransitionAnimated:NO];
        
        self.window.rootViewController = self.tabBarVC;
    } else {
        MyHandViewController *myHandVC = [[MyHandViewController alloc] init];
        self.window.rootViewController = myHandVC;
    }
    
    
    return YES;
}

- (void)exitNetwork{
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    __block   BOOL network =  network ;  //
    __block   BOOL change =  change ;  //
    change = NO;
    network = NO;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         switch (status) {
             case AFNetworkReachabilityStatusNotReachable:
             {
                 NSLog(@"无网络");
                 [ProgressHUD showMessage:@"无网络" Width:100 High:20];
                 network = NO;
                 change = YES;
                 break;
             }
                 
             case AFNetworkReachabilityStatusReachableViaWiFi:
             {
                 NSLog(@"WiFi网络");
                 [ProgressHUD showMessage:@"WiFi网络" Width:100 High:20];
                 network = YES;
                 change = YES;
                 break;
             }
                 
             case AFNetworkReachabilityStatusReachableViaWWAN:
             {
                 NSLog(@"无线网络");
                 [ProgressHUD showMessage:@"无线网络" Width:100 High:20];
                 network = YES;
                 change = YES;
                 break;
             }
                 
             default:
                 break;
         }
     }];
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

@end
