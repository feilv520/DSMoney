//
//  AppDelegate.m
//  DSLC
//
//  Created by 马成铭 on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AppDelegate.h"
#import "TSelectionViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import "MyHandViewController.h"
#import "FileOfManage.h"
#import "ThreeViewController.h"
#import "define.h"
#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import "TWOSelectionViewController.h"
#import "TWOMineViewController.h"
#import "TWOFindViewController.h"

@interface AppDelegate ()
{
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
    
    NSNumber *result;
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
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    [self exitNetwork];
    
    [self versionAlertView];
    
    [UMSocialData setAppKey:@"5642ad7e67e58e8463006218"];
    
    [UMSocialWechatHandler setWXAppId:@"wxebb3d94fc5272ea8" appSecret:@"89f84525f50a31fc0acf6b551f9bcbc8" url:@"http://www.dslc.cn"];
    
    [UMSocialQQHandler setQQWithAppId:@"1104927343" appKey:@"9RRogveZHZO6ZlWk" url:@"http://www.dslc.cn"];
    
    [MobClick startWithAppkey:@"5642ad7e67e58e8463006218" reportPolicy:BATCH   channelId:@""];
    
    NSDictionary *dic = self.flagDic;
    
    NSString *flag = [dic objectForKey:@"FristOpen"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([flag isEqualToString:@"NO"]) {
        
//        2.0首页
        TWOSelectionViewController *twoSelectionVC = [[TWOSelectionViewController alloc] init];
        UINavigationController *twoNavigation1 = [[UINavigationController alloc] initWithRootViewController:twoSelectionVC];
        
//        1.0首页
//        TSelectionViewController *selectionVC = [[TSelectionViewController alloc] init];
//        UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:selectionVC];
        
//        2.0产品
        TWOProductViewController *twoproductVC = [[TWOProductViewController alloc] init];
        UINavigationController *twoNavigation = [[UINavigationController alloc] initWithRootViewController:twoproductVC];
        
//        1.0产品
//        ThreeViewController *threeVC = [[ThreeViewController alloc] init];
//        UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:threeVC];
        
//        2.0发现
        TWOFindViewController *findVC = [[TWOFindViewController alloc] init];
        UINavigationController *navigationFind = [[UINavigationController alloc] initWithRootViewController:findVC];
        
//        2.0我的
        TWOMineViewController *twoMineVC = [[TWOMineViewController alloc] init];
        UINavigationController *navigationTwoMine = [[UINavigationController alloc] initWithRootViewController:twoMineVC];
        
//        1.0我的
//        MineViewController *mineVC = [[MineViewController alloc] init];
////        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:mineVC];

//        2.0
        self.viewControllerArr = @[twoNavigation1, navigation2, navigationFind, navigationTwoMine];
//        1.0
//        self.viewControllerArr = @[navigation1, navigation2, navigation3];
        
//        2.0
        butGrayArr = @[@"iconfont-jingxuan", @"shouyeqiepian750_28", @"faxian", @"iconfont-iconfuzhi"];
        butColorArr = @[@"iconfont-jingxuan-highlight", @"shouyeqiepian7500_28highlight", @"faxianclick", @"iconfont-iconfuzhi-highlight"];
        
//        1.0
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
        [self.tabBarVC setControllerArray:self.viewControllerArr];
        //    存放tabBar上的按钮
        [self.tabBarVC setTabButtonArray:buttonArr];
        //    设置tabBar的高度 默认为50
        [self.tabBarVC setTabBarHeight:35];
        //    设置是否可以手势滑动切换模块 默认为YES
        [self.tabBarVC setSuppurtGestureTransition:NO];
        //    设置点击按钮有无翻页效果 默认有
        [self.tabBarVC setTransitionAnimated:NO];
        
        self.window.rootViewController = self.tabBarVC;
        
    } else {
        // 手势
//        MyHandViewController *myHandVC = [[MyHandViewController alloc] init];
//        self.window.rootViewController = myHandVC;
        
        // 欢迎页
        WelcomeViewController *welcome = [[WelcomeViewController alloc] init];
        self.window.rootViewController = welcome;
    }
    
    
    return YES;
}

void UncaughtExceptionHandler(NSException *exception){
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSLog(@"symbols = %@",symbols);
    NSLog(@"reason = %@",reason);
    NSLog(@"name = %@",name);
    
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
    
//    if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
//        [FileOfManage createWithFile:@"isLogin.plist"];
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
//        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
//    } else {
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
//        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
//    }
//    
//    if (![FileOfManage ExistOfFile:@"sumbitWithFrg.plist"]) {
//        [FileOfManage createWithFile:@"sumbitWithFrg.plist"];
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"ifFrg",nil];
//        [dic writeToFile:[FileOfManage PathOfFile:@"sumbitWithFrg.plist"] atomically:YES];
//    } else {
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"ifFrg",nil];
//        [dic writeToFile:[FileOfManage PathOfFile:@"sumbitWithFrg.plist"] atomically:YES];
//    }
    
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
    
    // 判断是否存在isLogin.plist文件
    if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
        [FileOfManage createWithFile:@"isLogin.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    } else {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    }
    
    if (![FileOfManage ExistOfFile:@"sumbitWithFrg.plist"]) {
        [FileOfManage createWithFile:@"sumbitWithFrg.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"ifFrg",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"sumbitWithFrg.plist"] atomically:YES];
    } else {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"ifFrg",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"sumbitWithFrg.plist"] atomically:YES];
    }
    
}

// 版本提示框 200 开启 400 没开
- (void)versionAlertView{
    
    NSDictionary *parameters = @{@"appType":@"2"};
    
    NSLog(@"12");
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/index/getAppVersion" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"----===%@",responseObject);
        result = [responseObject objectForKey:@"result"];
        
        if ([result isEqualToNumber:@200]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新版本请更新(已更新请忽略)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
            alertView.delegate = self;
            [alertView show];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *url = @"https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
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
