//
//  BaseViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BaseViewController.h"
#import "ProgressHUD.h"

@interface BaseViewController ()

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
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}

- (void)setTitleString:(NSString *)titleString
{
    self.navigationItem.title = titleString;
}

- (void)showTanKuangWithMode:(MBProgressHUDMode)mode Text:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = mode;
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:12];
    hud.minSize = CGSizeMake(0, 55);
    hud.margin = 10;
    hud.yOffset = -50;
    hud.cornerRadius = 5.0f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.8];
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
    
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviagationShow];
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
