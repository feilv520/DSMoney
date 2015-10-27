//
//  MyHandViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyHandViewController.h"
#import "SelectionViewController.h"
#import "FinancingViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import "KKTabBarViewController.h"
#import "MyHandButton.h"
#import "define.h"
#import "AppDelegate.h"

@interface MyHandViewController () <MyHandButtonDelegate>{
    NSArray *viewControllerArr;
    NSArray *butGrayArr;
    NSArray *butColorArr;
    NSMutableArray *buttonArr;
}
@property (nonatomic) KKTabBarViewController *tabBarVC;

@property (weak, nonatomic) IBOutlet MyHandButton *myHandBtn;

@end

@implementation MyHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myHandBtn.frame = CGRectMake(8, 162, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    
    self.myHandBtn.delegate = self;
}

- (void)lockView:(MyHandButton *)lockView didFinishPath:(NSString *)path{
    if ([path isEqualToString:@"012"]) {
        SelectionViewController *selectionVC = [[SelectionViewController alloc] init];
        
        FinancingViewController *financingVC = [[FinancingViewController alloc] init];
        UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:financingVC];
        
        MineViewController *mineVC = [[MineViewController alloc] init];
        UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:mineVC];
        
        MoreViewController *moreVC = [[MoreViewController alloc] init];
        UINavigationController *navigation4 = [[UINavigationController alloc] initWithRootViewController:moreVC];
        
        viewControllerArr = @[selectionVC, navigation2, navigation3, navigation4];
        
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
        [self.tabBarVC setControllerArray:viewControllerArr];
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
        NSLog(@"%@",app.window.rootViewController.class);
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
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
