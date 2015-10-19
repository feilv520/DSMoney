//
//  CheckViewController.m
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CheckViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "CreatView.h"

@interface CheckViewController ()

@end

@implementation CheckViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self naviagationShow];
    [self labelShow];
}

//label自适应
- (void)labelShow
{
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 100) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为1,0000元由大圣理财提供,期限3天,到期后兑付3天收益。"];
    [self.view addSubview:label];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 999999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    label.numberOfLines = 0;
    label.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height + 13);
    NSLog(@"%f", rect.size.height);
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"查看协议";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
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
