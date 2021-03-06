//
//  WelcomeViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/12/25.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "WelcomeViewController.h"
#import "define.h"
#import "MoreViewController.h"
#import "KKTabBarViewController.h"
#import "AppDelegate.h"
#import "ThreeViewController.h"
#import "LoginViewController.h"
#import "TSelectionViewController.h"
#import "MineViewController.h"
#import "TWOSelectionViewController.h"
#import "TWOProductViewController.h"
#import "TWOFindViewController.h"
#import "TWOMineViewController.h"

@interface WelcomeViewController (){
    
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
    
    UIImageView *imgOne;
    UIImageView *imgTwo;
    UIImageView *imgThree;
    UIButton *startButton;
}
@property (nonatomic) KKTabBarViewController *tabBarVC;

@property (nonatomic, strong) NSArray *viewControllerArr;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 3, 0.5);
    
    [self.view addSubview:self.scrollView];
    
    imgOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    imgTwo = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    imgThree = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * 2, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    
    imgThree.alpha = 1.0;
    
    NSLog(@"%lf",HEIGHT_CVIEW_DEFAULT);
    
    if (HEIGHT_CVIEW_DEFAULT == 480.0) {
        
        imgOne.image = [UIImage imageNamed:@"TWOWelcomOne_480"];
        imgTwo.image = [UIImage imageNamed:@"TWOWelcomTwo_480"];
        imgThree.image = [UIImage imageNamed:@"TWOWelcomThree_480"];
    } else if (HEIGHT_CVIEW_DEFAULT == 568.0) {
        
        imgOne.image = [UIImage imageNamed:@"TWOWelcomOne_1136"];
        imgTwo.image = [UIImage imageNamed:@"TWOWelcomTwo_1136"];
        imgThree.image = [UIImage imageNamed:@"TWOWelcomThree_1136"];
    } else if (HEIGHT_CVIEW_DEFAULT == 667.0) {
        
        imgOne.image = [UIImage imageNamed:@"TWOWelcomOne_1334"];
        imgTwo.image = [UIImage imageNamed:@"TWOWelcomTwo_1334"];
        imgThree.image = [UIImage imageNamed:@"TWOWelcomThree_1334"];
    } else if (HEIGHT_CVIEW_DEFAULT == 736.0) {
        
        imgOne.image = [UIImage imageNamed:@"TWOWelcomOne_2208"];
        imgTwo.image = [UIImage imageNamed:@"TWOWelcomTwo_2208"];
        imgThree.image = [UIImage imageNamed:@"TWOWelcomThree_2208"];
    }
    
    startButton = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (102.0 / 375.0) + WIDTH_CONTROLLER_DEFAULT * 2, HEIGHT_CONTROLLER_DEFAULT * (560.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (170.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:Color_Clear textColor:nil titleText:@"立即体验"];
    [startButton addTarget:self action:@selector(intoMySystem:) forControlEvents:UIControlEventTouchUpInside];
    
    startButton.alpha = 1.0;
    
    [self.scrollView addSubview:startButton];
    
    [self.scrollView addSubview:imgOne];
    [self.scrollView addSubview:imgTwo];
    [self.scrollView addSubview:imgThree];
    
}

- (void)intoMySystem:(id)sender{
    
    [UIView animateWithDuration:1.0 animations:^{
        
        imgThree.alpha = 0.0;
        startButton.alpha = 0.0;
        
    } completion:^(BOOL finished) {
       
        NSDictionary *dics = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Flag.plist"]];
        
        [dics setValue:@"NO" forKey:@"FristOpen"];
        
        [dics writeToFile:[FileOfManage PathOfFile:@"Flag.plist"] atomically:YES];
        
        ////        1.0首页
        //        TSelectionViewController *selectionVC = [[TSelectionViewController alloc] init];
        //        UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:selectionVC];
        //
        ////        1.0产品
        //        ThreeViewController *threeVC = [[ThreeViewController alloc] init];
        //        UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:threeVC];
        //
        ////        1.0我的
        //        MineViewController *mineVC = [[MineViewController alloc] init];
        ////        LoginViewController *loginVC = [[LoginViewController alloc] init];
        //        UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:mineVC];
        
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
        self.viewControllerArr = @[twoNavigation1, twoNavigation, navigationFind, navigationTwoMine];
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
        [self.tabBarVC setControllerArray:self.viewControllerArr];
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
