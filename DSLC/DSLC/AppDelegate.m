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
#import "TWOProductViewController.h"
#import "TWOFindViewController.h"
#import "TWOLoginAPPViewController.h"
#import <AdSupport/AdSupport.h>
#import "TWONoticeDetailViewController.h"
#import "BannerViewController.h"

@interface AppDelegate ()
{
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
    
    NSNumber *result;
    
    //签到猴子需要的控件
    UIButton *buttonHei;
    UIView *viewDown;
    UILabel *labelMonkey;
    UIImageView *imageSign;
    
    UIButton *buttonWait;
    UIView *viewWait;
    UIImageView *imageWait;
    
    NSDictionary *userInformation;
    
    
}
@property (nonatomic, strong) NSDictionary *flagDic;
@property (nonatomic, strong) NSDictionary *flagLogin;
@property (nonatomic, strong) NSDictionary *flagUserInfo;
@property (nonatomic, strong) NSDictionary *handDic;
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

- (NSDictionary *)flagUserInfo{
    if (_flagUserInfo == nil) {
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
                                 @"",@"registerTime",
                                 @"",@"newHand",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
        }
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        self.flagUserInfo = dic;
    }
    return _flagUserInfo;
}

- (NSDictionary *)handDic{
    if (_handDic == nil) {
        if (![FileOfManage ExistOfFile:@"handOpen.plist"]) {
            [FileOfManage createWithFile:@"handOpen.plist"];
            NSMutableDictionary *usDic = [NSMutableDictionary dictionary];
            
            NSMutableDictionary *userDIC = [NSMutableDictionary dictionary];
            
            [userDIC setValue:@"NO" forKey:@"handFlag"];
            [userDIC setValue:@"" forKey:@"handString"];
            [userDIC setValue:@"YES" forKey:@"ifSetHandFlag"];
            
            [usDic setValue:userDIC forKey:@"1234567890"];
            
            [usDic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
            
            NSLog(@"usDic == %@",usDic);
        }
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
        self.handDic = dic;
    }
    return _handDic;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    application.applicationIconBadgeNumber = 0;
    
    [self exitNetwork];
    
    // 版本控制接口
    //    [self versionAlertView];
    
    // 推送消息判断后跳转页面
    if (launchOptions)
    {
        NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if (userInfo) {
            if ([[userInfo objectForKey:@"detailType"] isEqualToString:@"Notice"]) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"gongGaoWithNotice" object:userInfo];
                });
                
            } else if ([[userInfo objectForKey:@"detailType"] isEqualToString:@"H5"]) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"hFiveWithNotice" object:userInfo];
                });
            }
        }
    }
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    [defaultCenter addObserver:self selector:@selector(loginFuction) name:@"appUntoken" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monkeyWithSuccess:) name:@"showMonkey" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showWaitNsnotice:) name:@"waitMoment" object:nil];
    
    [UMSocialData setAppKey:@"5642ad7e67e58e8463006218"];
    
    [UMSocialWechatHandler setWXAppId:@"wxebb3d94fc5272ea8" appSecret:@"89f84525f50a31fc0acf6b551f9bcbc8" url:@"http://www.dslc.cn"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105107546" appKey:@"OgYvoCEzwr632bLP" url:@"http://www.dslc.cn"];
    
    [MobClick startWithAppkey:@"5642ad7e67e58e8463006218" reportPolicy:BATCH   channelId:@""];
    
    NSDictionary *userDIC = [self.handDic objectForKey:[self.flagUserInfo objectForKey:@"phone"]];
    
    NSLog(@"userDIC = %@",userDIC);
    
    NSString *handFlag;
    
    if (userDIC == nil) {
        handFlag = @"NO";
    } else {
        handFlag = [userDIC objectForKey:@"handFlag"];
    }
    
    NSString *loginFlag = [self.flagLogin objectForKey:@"loginFlag"];
    
    NSString *token = [self.flagUserInfo objectForKey:@"token"];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([[self.flagDic objectForKey:@"FristOpen"] isEqualToString:@"NO"] ) {
        if ([loginFlag isEqualToString:@"NO"] || [handFlag isEqualToString:@"NO"]) {
            
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
            //            TWOLoginAPPViewController *loginAPPVC = [[TWOLoginAPPViewController alloc] init];
            UINavigationController *navigationTwoMine = [[UINavigationController alloc] initWithRootViewController:twoMineVC];
            
            //        2.0
            self.viewControllerArr = @[twoNavigation1, twoNavigation, navigationFind, navigationTwoMine];
            
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
            
            self.window.rootViewController.view.alpha = 0.0;
            
            UIImageView *backgroundImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TWO_BackgroundView"]];
            backgroundImgView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.window.frame.size.height);
            [self.window addSubview:backgroundImgView];
            if (self.window.frame.size.height == 480) {
                backgroundImgView.image = [UIImage imageNamed:@"TWO_BackgroundView480"];
            }
            
            UIImageView *newImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TWO_NewBackground"]];
            newImageView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.window.frame.size.height - 117);
            newImageView.alpha = 0;
            [backgroundImgView addSubview:newImageView];
            
            [UIView animateWithDuration:1.0f animations:^{
                
                newImageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.0f animations:^{
                    
                    self.window.rootViewController.view.alpha = 1.0;
                } completion:^(BOOL finished) {
                    
                    [backgroundImgView removeFromSuperview];
                }];
                
                if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"YES"]){
                    [self loginFuction];
                }
                
            }];
            
        } else {
            //         手势
            MyHandViewController *myHandVC = [[MyHandViewController alloc] init];
            self.window.rootViewController = myHandVC;
            
            self.window.rootViewController.view.alpha = 0.0;
            
            UIImageView *backgroundImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TWO_BackgroundView"]];
            backgroundImgView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.window.frame.size.height);
            [self.window addSubview:backgroundImgView];
            
            UIImageView *newImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TWO_NewBackground"]];
            newImageView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.window.frame.size.height - 117);
            newImageView.alpha = 0;
            [backgroundImgView addSubview:newImageView];
            
            [UIView animateWithDuration:2.0f animations:^{
                newImageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:1.0f animations:^{
                    
                    self.window.rootViewController.view.alpha = 1.0;
                } completion:^(BOOL finished) {
                    
                    [backgroundImgView removeFromSuperview];
                }];
                
            }];
        }
        
    } else {
        
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

// 检测网络状况
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
                 //                 [ProgressHUD showMessage:@"无网络" Width:100 High:20];
                 network = NO;
                 change = YES;
                 break;
             }
                 
             case AFNetworkReachabilityStatusReachableViaWiFi:
             {
                 NSLog(@"WiFi网络");
                 //                 [ProgressHUD showMessage:@"WiFi网络" Width:100 High:20];
                 network = YES;
                 change = YES;
                 break;
             }
                 
             case AFNetworkReachabilityStatusReachableViaWWAN:
             {
                 NSLog(@"无线网络");
                 //                 [ProgressHUD showMessage:@"无线网络" Width:100 High:20];
                 network = YES;
                 change = YES;
                 break;
             }
                 
             default:
                 break;
         }
     }];
}

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
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    if ([[self.flagUserInfo objectForKey:@"password"] isEqualToString:@"1"]) {
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
}

// 版本提示框 200 开启 400 没开
- (void)versionAlertView{
    
    NSDictionary *parameters = @{@"appType":@"2"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/index/getAppVersion" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"----===%@",responseObject);
        result = [responseObject objectForKey:@"result"];
        
        if ([result isEqualToNumber:@200]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新版本请更新(已更新请忽略)" delegate:self cancelButtonTitle:nil otherButtonTitles:@"去更新", nil];
            alertView.delegate = self;
            alertView.tag = 9900;
            [alertView show];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 9900) {
        
        if (buttonIndex == 0) {
            NSString *url = @"https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    } else {
        if (buttonIndex == 1) {
            if ([[userInformation objectForKey:@"detailType"] isEqualToString:@"Notice"]) {
                
                NSLog(@"Notice");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"gongGaoWithNotice" object:userInformation];
            } else if ([[userInformation objectForKey:@"detailType"] isEqualToString:@"H5"]) {
                
                NSLog(@"H5");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hFiveWithNotice" object:userInformation];
            }
            NSLog(@"内部查看");
        }
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

#pragma mark 极光推送
#pragma mark --------------------------------

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    //    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    //    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    //    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    //    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    // 取得自定义字段内容，userInfo就是后台返回的JSON数据，是一个字典
    
    application.applicationIconBadgeNumber = 0;
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    //    [rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知::::%@", [self logDic:userInfo]);
    //    [rootViewController addNotificationCount];
    
    userInformation = userInfo;
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                         message:@"您有一条新的推送消息!"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"查看",nil];
        alert.tag = 9800;
        [alert show];
        
    } else {
        
        if ([[userInfo objectForKey:@"detailType"] isEqualToString:@"Notice"]) {
            
            NSLog(@"Notice");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gongGaoWithNotice" object:userInfo];
        } else if ([[userInfo objectForKey:@"detailType"] isEqualToString:@"H5"]) {
            
            NSLog(@"H5");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hFiveWithNotice" object:userInfo];
        }
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber  =  0;
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)loginFuction{
    
    NSDictionary *parmeter = @{@"phone":[self.flagUserInfo objectForKey:@"phone"],@"password":[DES3Util decrypt:[self.flagUserInfo objectForKey:@"password"]]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"login" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"register = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@200]) {
            //            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            
            if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                [FileOfManage createWithFile:@"Member.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [self.flagUserInfo objectForKey:@"password"],@"password",
                                     [self.flagUserInfo objectForKey:@"phone"],@"phone",
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
                                     [[responseObject objectForKey:@"User"] objectForKey:@"newHand"],@"newHand",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [self.flagUserInfo objectForKey:@"password"],@"password",
                                     [self.flagUserInfo objectForKey:@"phone"],@"phone",
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
                                     [[responseObject objectForKey:@"User"] objectForKey:@"newHand"],@"newHand",nil];
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
            
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self userSign];
            });
            
            [self getMyAccountInfoFuction];
            
            NSString *invitationMyCodeString = [[responseObject objectForKey:@"User"] objectForKey:@"invitationCode"];
            
            NSString *userLevelString = [[responseObject objectForKey:@"User"] objectForKey:@"userLevel"];
            
            if ([invitationMyCodeString isEqualToString:@""]) {
                
                NSString *aliasString = [NSString stringWithFormat:@"dslc_%@",userLevelString];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [JPUSHService setTags:nil alias:aliasString fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                        NSLog(@"iResCode = %d---- iAlias = %@---",iResCode,iAlias);
                        
                    }];
                });
            } else {
                
                NSString *firstCodeString = [invitationMyCodeString substringToIndex:1];
                
                if ([NSString pipeizimu:firstCodeString]) {
                    NSString *aliasString = [NSString stringWithFormat:@"dslc_%@",userLevelString];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [JPUSHService setTags:nil alias:aliasString fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                            NSLog(@"iResCode = %d---- iAlias = %@---",iResCode,iAlias);
                            
                        }];
                    });
                } else {
                    
                    NSString *aliasString = [NSString stringWithFormat:@"%@_%@",invitationMyCodeString,userLevelString];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [JPUSHService setTags:nil alias:aliasString fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                            NSLog(@"iResCode = %d---- iAlias = %@---",iResCode,iAlias);
                            
                        }];
                    });
                }
            }
            
        } else {
            
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

//猴子成功方法
- (void)monkeyWithSuccess:(NSNotification *)not
{
    NSString *monkeyString = [not object];
    [self signFinish:monkeyString];
}

//签到成功
- (void)signFinish:(NSString *)monkeyNum
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    buttonHei = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.window.frame.size.height) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttonHei];
    buttonHei.alpha = 0.6;
    [buttonHei addTarget:self action:@selector(clickedBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewDown = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 530/2/2, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 530/2, 397/2 + 30) backgroundColor:[UIColor clearColor]];
    [app.tabBarVC.view addSubview:viewDown];
    viewDown.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddClicked:)];
    [viewDown addGestureRecognizer:tapView];
    
    labelMonkey = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewDown.frame.size.width, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:27] text:[NSString stringWithFormat:@"+%@猴币", monkeyNum]];
    [viewDown addSubview:labelMonkey];
    
    imageSign = [CreatView creatImageViewWithFrame:CGRectMake(0, 30, viewDown.frame.size.width, viewDown.frame.size.height - 30) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"doSign"]];
    [viewDown addSubview:imageSign];
    imageSign.userInteractionEnabled = YES;
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [viewDown.layer addAnimation:animation forKey:nil];
}

//黑色遮罩层消失
- (void)clickedBlackDisappear:(UIButton *)button
{
    [buttonHei removeFromSuperview];
    [viewDown removeFromSuperview];
    [labelMonkey removeFromSuperview];
    [imageSign removeFromSuperview];
    
    buttonHei = nil;
    viewDown = nil;
    labelMonkey = nil;
    imageSign = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"huifuOpenAccount" object:nil];
}

//点击猴子
- (void)tapAddClicked:(UITapGestureRecognizer *)tap
{
    [buttonHei removeFromSuperview];
    [viewDown removeFromSuperview];
    [labelMonkey removeFromSuperview];
    [imageSign removeFromSuperview];
    
    buttonHei = nil;
    viewDown = nil;
    labelMonkey = nil;
    imageSign = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"huifuOpenAccount" object:nil];
    
}

//敬请期待
- (void)showWaitNsnotice:(NSNotification *)nsnotice
{
    [self waitContentShow];
}

//敬请期待
- (void)waitContentShow
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (buttonWait == nil) {
        buttonWait = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [app.tabBarVC.view addSubview:buttonWait];
    buttonWait.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    buttonWait.backgroundColor = [UIColor blackColor];
    buttonWait.alpha = 0.5;
    buttonWait.tag = 721;
    [buttonWait addTarget:self action:@selector(buttonBlackClickDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    if (viewWait == nil) {
        viewWait = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 530/2/2, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 530/2, 397/2 + 30)];
    }
    [app.tabBarVC.view addSubview:viewWait];
    viewWait.backgroundColor = [UIColor clearColor];
    
    if (imageWait == nil) {
        imageWait = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWait.frame.size.width, viewWait.frame.size.height)];
    }
    [viewWait addSubview:imageWait];
    imageWait.image = [UIImage imageNamed:@"敬请期待ing"];
    imageWait.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickedDisappear:)];
    [imageWait addGestureRecognizer:tap];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [viewWait.layer addAnimation:animation forKey:nil];
}

//敬请期待消失
- (void)buttonBlackClickDisappear:(UIButton *)button
{
    [buttonWait removeFromSuperview];
    buttonWait = nil;
    
    [viewWait removeFromSuperview];
    viewWait = nil;
    
    [imageWait removeFromSuperview];
    imageWait = nil;
}

//敬请期待消失
- (void)tapClickedDisappear:(UITapGestureRecognizer *)tap
{
    [buttonWait removeFromSuperview];
    buttonWait = nil;
    
    [viewWait removeFromSuperview];
    viewWait = nil;
    
    [imageWait removeFromSuperview];
    imageWait = nil;
}

// 获取邀请码方法
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

// 签到方法调用
- (void)userSign{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSMutableDictionary *memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":[memberDic objectForKey:@"token"],@"signDate":dateString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sign/userSign" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"userSign = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            if (![[responseObject objectForKey:@"signMonkeyNum"] isEqualToString:@"0"]){
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showMonkey" object:[responseObject objectForKey:@"signMonkeyNum"]];
            }
            
        } else {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"huifuOpenAccount" object:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的Extras附加字段，key是自己定义的
    
    NSLog(@"content = %@",content);
    NSLog(@"extras = %@",extras);
    NSLog(@"customizeField1 = %@",customizeField1);
    
}

@end
