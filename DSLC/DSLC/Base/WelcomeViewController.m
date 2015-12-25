//
//  WelcomeViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/12/25.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "WelcomeViewController.h"
#import "define.h"
#import "SelectionViewController.h"
#import "MoreViewController.h"
#import "KKTabBarViewController.h"
#import "AppDelegate.h"
#import "ThreeViewController.h"
#import "LoginViewController.h"

@interface WelcomeViewController (){
    
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
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
    
    UIImageView *imgOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    UIImageView *imgTwo = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    UIImageView *imgThree = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * 2, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    
    imgOne.image = [UIImage imageNamed:@"welcome_one"];
    imgTwo.image = [UIImage imageNamed:@"welcome_two"];
    imgThree.image = [UIImage imageNamed:@"welcome_three"];
    
    UIButton *startButton = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (102.0 / 375.0) + WIDTH_CONTROLLER_DEFAULT * 2, HEIGHT_CONTROLLER_DEFAULT * (560.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (170.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:Color_Black textColor:nil titleText:@"立即体验"];
    [startButton addTarget:self action:@selector(intoMySystem:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:startButton];
    
    [self.scrollView addSubview:imgOne];
    [self.scrollView addSubview:imgTwo];
    [self.scrollView addSubview:imgThree];
    
}

- (void)intoMySystem:(id)sender{
    NSLog(@"123321");
    NSDictionary *dics = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Flag.plist"]];
    
    [dics setValue:@"NO" forKey:@"FristOpen"];
    
    [dics writeToFile:[FileOfManage PathOfFile:@"Flag.plist"] atomically:YES];
    
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
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    app.tabBarVC = self.tabBarVC;
    app.window.rootViewController = self.tabBarVC;
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
