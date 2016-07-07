//
//  BaseViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "ProgressHUD.h"
#import "TWOLoginAPPViewController.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (NSDictionary *)flagDic{
    if (_flagDic == nil) {
        
        if (![FileOfManage ExistOfFile:@"Member.plist"]) {
            [FileOfManage createWithFile:@"Member.plist"];
        }
        NSDictionary *dics = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        _flagDic = dics;
    }
    return _flagDic;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self naviagationShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fortyWithLogin:) name:@"fortyWithLogin" object:nil];
}

- (void)setTitleString:(NSString *)titleString
{
    self.navigationItem.title = titleString;
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
//    1.0
//    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
//    2.0
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;  // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];  // 设置手势代理，拦截手势触发
//    pan.delegate = self;  // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];  // 禁止使用系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(-100, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"导航返回"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [self.imageReturn addGestureRecognizer:tap];
    
}// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。// 作用：拦截手势触发

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{  // 注意：只有非根控制器才有滑动返回功能，根控制器没有。  // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {    // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
//}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic{
    
}

- (void)fortyWithLogin:(NSNotification *)not{
    TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [nvc setNavigationBarHidden:YES animated:YES];
    
    [self presentViewController:nvc animated:YES completion:^{
        
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
