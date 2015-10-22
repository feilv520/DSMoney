//
//  MyBankViewController.m
//  DSLC
//
//  Created by ios on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyBankViewController.h"
#import "CreatView.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "AddBankViewController.h"

@interface MyBankViewController ()

@end

@implementation MyBankViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self navigationContent];
    [self showViewControllerContent];
}

//navigation
- (void)navigationContent
{
    self.navigationItem.title = @"我的银行卡";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
}

//视图内容
- (void)showViewControllerContent
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UILabel *lableLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (49.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, 1)];
    [viewBottom addSubview:lableLine1];
    [self setLabel:lableLine1];
    
    UIButton *buttonAdd = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (61.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"+添加银行卡"];
    [self.view addSubview:buttonAdd];
    buttonAdd.titleLabel.font = [UIFont systemFontOfSize:15];
//    设置button的标题左对齐 但是此方法紧紧靠近左边 不好看 需加上下面一行代码
    buttonAdd.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    就是要加上此行代码
    buttonAdd.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    UIImageView *imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (16.0 / 375.0) - WIDTH_CONTROLLER_DEFAULT * (10.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (18.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (16.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (16.0 / 375.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    [buttonAdd addSubview:imageRight];
    imageRight.userInteractionEnabled = YES;
    
    [buttonAdd addTarget:self action:@selector(buttonAddBankCard:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageBankLogo = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (10.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (15.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"icon_ICBC"]];
    [viewBottom addSubview:imageBankLogo];
    
    UILabel *labelLine2 = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1) backgroundColor:nil textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [buttonAdd addSubview:labelLine2];
    [self setLabel:labelLine2];
    
    UILabel *labelLine3 = [CreatView creatWithLabelFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (49.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, 1) backgroundColor:nil textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [buttonAdd addSubview:labelLine3];
    [self setLabel:labelLine3];
    
    UILabel *labelBankCard = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (35.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (12.0 / 667.0), 150, HEIGHT_CONTROLLER_DEFAULT * (26.0 / 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:15] text:@"中国工商银行(储蓄卡)"];
    [viewBottom addSubview:labelBankCard];
    
    UILabel *labelTailNum = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 83, 12, 70, 26) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight textFont:[UIFont systemFontOfSize:15] text:@"尾号8888"];
    [viewBottom addSubview:labelTailNum];
}

//labelLine
- (void)setLabel:(UILabel *)labelLine
{
    labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    labelLine.alpha = 0.9;
}

//添加银行卡按钮
- (void)buttonAddBankCard:(UIButton *)button
{
    AddBankViewController *addBankVC = [[AddBankViewController alloc] init];
    [self.navigationController pushViewController:addBankVC animated:YES];
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
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
