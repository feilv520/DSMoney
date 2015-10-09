//
//  AppDelegate.m
//  DSLC
//
//  Created by 马成铭 on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AppDelegate.h"
#import "SelectionViewController.h"
#import "FinancingViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"

@interface AppDelegate ()
{
    NSArray *viewControllerArr;
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    SelectionViewController *selectionVC = [[SelectionViewController alloc] init];
    UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:selectionVC];
    
    FinancingViewController *financingVC = [[FinancingViewController alloc] init];
    UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:financingVC];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    UINavigationController *navigation4 = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
    viewControllerArr = @[navigation1, navigation2, navigation3, navigation4];
    
    butGrayArr = @[@"shouyeqiepian750_25", @"首页qiepian_28", @"首页qiepian_30", @"首页qiepian_32"];
    butColorArr = @[@"首页qiepian_25", @"shouyeqiepian750_28", @"shouyeqiepian750_30", @"shouyeqiepian750_32"];
    
    buttonArr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        button的frame值在第三方中已设置好,默认为50,如有设置需求,需手动改
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butGrayArr objectAtIndex:i]]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butColorArr objectAtIndex:i]]] forState:UIControlStateSelected];
        //        点击保持高亮状态,没有闪动的效果
        [button setShowsTouchWhenHighlighted:YES];
        [buttonArr addObject:button];
    }
    
    self.tabBarVC = [[KKTabBarViewController alloc] init];
    //    存放试图控制器
    [self.tabBarVC setControllerArray:viewControllerArr];
    //    存放tabBar上的按钮
    [self.tabBarVC setTabButtonArray:buttonArr];
    //    设置tabBar的高度 默认为50
    [self.tabBarVC setTabBarHeight:51];
    //    设置是否可以手势滑动切换模块 默认为YES
    [self.tabBarVC setSuppurtGestureTransition:YES];
    //    设置点击按钮有无翻页效果 默认有
    [self.tabBarVC setTransitionAnimated:NO];
    
    self.window.rootViewController = self.tabBarVC;
    
    return YES;
}

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

@end
