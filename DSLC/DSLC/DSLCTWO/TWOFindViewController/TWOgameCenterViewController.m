//
//  TWOgameCenterViewController.m
//  DSLC
//
//  Created by ios on 16/5/9.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOgameCenterViewController.h"
#import "TWOGameCenterCell.h"
#import "TWOMyGameScoreViewController.h"

@interface TWOgameCenterViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UIButton *butStrategy;
    UIButton *butScore;
}

@end

@implementation TWOgameCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"游戏中心"];
    
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0)];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 270.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [self tableViewHeadShow];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOGameCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (void)tableViewHeadShow
{
    UIImageView *imageViewBanner = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor greenColor] setImage:[UIImage imageNamed:@"gameBanner"]];
    [_tableView.tableHeaderView addSubview:imageViewBanner];
    
    CGFloat butWidth = (WIDTH_CONTROLLER_DEFAULT - 29)/2;
    
//    游戏攻略
    butStrategy = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, imageViewBanner.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butWidth, 72.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor colorWithRed:62.0 / 225.0 green:184.0 / 225.0 blue:240.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:nil];
    [_tableView.tableHeaderView addSubview:butStrategy];
    butStrategy.layer.cornerRadius = 3;
    butStrategy.layer.masksToBounds = YES;
    [butStrategy addTarget:self action:@selector(buttonStrategy:) forControlEvents:UIControlEventTouchUpInside];
    
//    游戏积分
    butScore = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10 + butWidth + 9, imageViewBanner.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butWidth, 72.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor colorWithRed:253.0 / 225.0 green:135.0 / 225.0 blue:74.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:nil];
    [_tableView.tableHeaderView addSubview:butScore];
    butScore.layer.cornerRadius = 3;
    butScore.layer.masksToBounds = YES;
    [butScore addTarget:self action:@selector(buttonScoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(10, _tableView.tableHeaderView.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5) backgroundColor:[UIColor zitihui]];
    [_tableView.tableHeaderView addSubview:viewLine];
    viewLine.alpha = 0.4;
    
    [self twoButtonContent];
}

//游戏攻略&游戏积分上的控件
- (void)twoButtonContent
{
    UIButton *butGongLue1 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [butStrategy addSubview:butGongLue1];
    [butGongLue1 setBackgroundImage:[UIImage imageNamed:@"gameStrategy"] forState:UIControlStateNormal];
    [butGongLue1 setBackgroundImage:[UIImage imageNamed:@"gameStrategy"] forState:UIControlStateHighlighted];
    [butGongLue1 addTarget:self action:@selector(buttonStrategy:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butGongLue2 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(52, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 20, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"游戏中心攻略"];
    [butStrategy addSubview:butGongLue2];
    butGongLue2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butGongLue2 addTarget:self action:@selector(buttonStrategy:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butGongLue3 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(52, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 20, 13) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"游戏大圣就看今朝"];
    [butStrategy addSubview:butGongLue3];
    butGongLue3.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butGongLue3 addTarget:self action:@selector(buttonStrategy:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butScore1 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [butScore addSubview:butScore1];
    [butScore1 setBackgroundImage:[UIImage imageNamed:@"gameScore"] forState:UIControlStateNormal];
    [butScore1 setBackgroundImage:[UIImage imageNamed:@"gameScore"] forState:UIControlStateHighlighted];
    [butScore1 addTarget:self action:@selector(buttonScoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butScore2 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(52, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 20, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"我的游戏积分"];
    [butScore addSubview:butScore2];
    butScore2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butScore2 addTarget:self action:@selector(buttonScoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butScore3 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(52, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 20, 13) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"游戏积分兑猴币啦"];
    [butScore addSubview:butScore3];
    butScore3.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butScore3 addTarget:self action:@selector(buttonScoreClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOGameCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *imageArray = @[@"大圣酷跑", @"大圣解密", @"拔鸡毛"];
    NSArray *nameArray = @[@"大圣酷跑", @"大圣解密", @"疯狂拔鸡毛"];
    
    cell.imagePic.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    cell.imagePic.layer.cornerRadius = 4;
    cell.imagePic.layer.masksToBounds = YES;
    
    cell.labelGameName.text = [nameArray objectAtIndex:indexPath.row];
    cell.labelGameName.textColor = [UIColor ZiTiColor];
    cell.labelGameName.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    cell.labelContent.text = @"勇闯酷跑赚不停";
    cell.labelContent.textColor = [UIColor findZiTiColor];
    cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:14];

    cell.butGoInto.layer.cornerRadius = 4;
    cell.butGoInto.layer.masksToBounds = YES;
    cell.butGoInto.layer.borderColor = [[UIColor colorWithRed:253.0 / 225.0 green:135.0 / 225.0 blue:74.0 / 225.0 alpha:1.0] CGColor];
    cell.butGoInto.layer.borderWidth = 1;
    [cell.butGoInto setTitle:@"进入" forState:UIControlStateNormal];
    [cell.butGoInto setTitleColor:[UIColor colorWithRed:253.0 / 225.0 green:135.0 / 225.0 blue:74.0 / 225.0 alpha:1.0] forState:UIControlStateNormal];
    cell.butGoInto.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [cell.butGoInto addTarget:self action:@selector(buttonGointoGame:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

//游戏攻略按钮
- (void)buttonStrategy:(UIButton *)button
{
    NSLog(@"游戏攻略");
}

//游戏积分按钮
- (void)buttonScoreClicked:(UIButton *)button
{
    TWOMyGameScoreViewController *gameScoreVC = [[TWOMyGameScoreViewController alloc] init];
    pushVC(gameScoreVC);
}

//进入按钮
- (void)buttonGointoGame:(UIButton *)button
{
    NSLog(@"进入");
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
