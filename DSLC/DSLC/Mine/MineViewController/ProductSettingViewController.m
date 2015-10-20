//
//  ProductSettingViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ProductSettingViewController.h"
#import "define.h"
#import "SettingTitleTableViewCell.h"
#import "SettingGetDetailTableViewCell.h"
#import "SettingGetMoneyTableViewCell.h"
#import "SettingPieTableViewCell.h"
#import "XYPieChart.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "CastProduceViewController.h"

@interface ProductSettingViewController () <UITableViewDataSource, UITableViewDelegate, XYPieChartDataSource, XYPieChartDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) XYPieChart *pieChartLeft;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

@end

@implementation ProductSettingViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChartLeft reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = TabelVie_Color_Gray;
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    
    self.mainTableView.backgroundColor = TabelVie_Color_Gray;
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"title"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingPieTableViewCell" bundle:nil] forCellReuseIdentifier:@"pie"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingGetDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"getDetail"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingGetMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"getMoney"];
    
    self.mainTableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.mainTableView];
    
    self.slices = [NSMutableArray arrayWithCapacity:10];
    
    for(int i = 0; i < 3; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%60+20];
        [_slices addObject:one];
    }
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],nil];
    
    self.pieChartLeft = [[XYPieChart alloc] initWithFrame:CGRectMake(175, 0, 200, 200)];
    
    [self.pieChartLeft setDelegate:self];
    [self.pieChartLeft setDataSource:self];
    [self.pieChartLeft setStartPieAngle:M_PI_2];
    [self.pieChartLeft setAnimationSpeed:1.0];
    [self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:15]];
    [self.pieChartLeft setLabelRadius:50];
    [self.pieChartLeft setShowPercentage:YES];
    [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChartLeft setPieCenter:CGPointMake(100, 100)];
    [self.pieChartLeft setUserInteractionEnabled:NO];
    [self.pieChartLeft setLabelShadowColor:[UIColor blackColor]];
    
    [self naviagationShow];
    
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"账户资产";
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


#pragma mark tableView delegate and dataSource
#pragma mark --------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SettingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            return cell;
        } else {
            SettingGetMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getMoney"];
            
            NSMutableAttributedString *redString = [[NSMutableAttributedString alloc] initWithString:@"13,234.56元"];
            NSRange redShuZi = NSMakeRange(0, [[redString string] rangeOfString:@"元"].location);
            [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:redShuZi];
            
            NSRange YUANString = NSMakeRange([[redString string] length] - 1, 1);
            [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:YUANString];
            [cell.yesterdayLabel setAttributedText:redString];
            cell.yesterdayLabel.textColor = [UIColor daohanglan];
            cell.yesterdayLabel.textAlignment = NSTextAlignmentCenter;
            
            NSMutableAttributedString *wanYuanStr = [[NSMutableAttributedString alloc] initWithString:@"23.05万元"];
            NSRange shuziStr = NSMakeRange(0, [[wanYuanStr string] rangeOfString:@"万"].location);
            [wanYuanStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:shuziStr];
            NSRange wanZiStr = NSMakeRange([[wanYuanStr string] length] - 2, 2);
            [wanYuanStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:wanZiStr];
            [cell.allDay setAttributedText:wanYuanStr];
            cell.allDay.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SettingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            cell.AllMoney.hidden = YES;
            return cell;
        } else {
            SettingPieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pie"];
            
            [cell addSubview:self.pieChartLeft];
            
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            SettingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            cell.AllMoney.hidden = YES;
            return cell;
        } else {
            SettingGetDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getDetail"];
            return cell;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 45;
        } else {
            return 88;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 45;
        } else {
            return 200;
        }
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 1) {
            
            CastProduceViewController *castPVC = [[CastProduceViewController alloc] init];
            [self.navigationController pushViewController:castPVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XYPieChart Data Source
#pragma mark --------------------------------

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
#pragma mark --------------------------------
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %ld",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %ld",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %ld",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %ld",(unsigned long)index);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}

@end
