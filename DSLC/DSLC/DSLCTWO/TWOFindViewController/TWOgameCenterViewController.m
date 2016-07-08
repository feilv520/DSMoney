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
#import "TWOGameListModel.h"
#import "TWOLoginAPPViewController.h"
#import "TWOGameCenterExplainViewController.h"

@interface TWOgameCenterViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UIButton *butStrategy;
    UIButton *butScore;
    NSMutableArray *gameListArray;
}

@end

@implementation TWOgameCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"游戏中心"];
    gameListArray = [NSMutableArray array];
    
    [self getDataList];
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
    CGFloat butHeight = butStrategy.frame.size.height;
    
    UIButton *butGongLue1 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, butHeight/2 - 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [butStrategy addSubview:butGongLue1];
    [butGongLue1 setBackgroundImage:[UIImage imageNamed:@"gameStrategy"] forState:UIControlStateNormal];
    [butGongLue1 setBackgroundImage:[UIImage imageNamed:@"gameStrategy"] forState:UIControlStateHighlighted];
    [butGongLue1 addTarget:self action:@selector(buttonStrategy:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butGongLue2 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(52, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 20, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"游戏中心攻略"];
    [butStrategy addSubview:butGongLue2];
    butGongLue2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
//    butGongLue2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    butGongLue2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [butGongLue2 addTarget:self action:@selector(buttonStrategy:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butGongLue3 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(52, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 20, 13) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"游戏大圣就看今朝"];
    [butStrategy addSubview:butGongLue3];
    butGongLue3.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butGongLue3 addTarget:self action:@selector(buttonStrategy:) forControlEvents:UIControlEventTouchUpInside];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        butGongLue2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        butGongLue3.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        
        butGongLue2.frame = CGRectMake(50, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 5, 16);
        butGongLue3.frame = CGRectMake(50, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 5.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 10, 11);
    }
    
    CGFloat heightBut = butScore.frame.size.height;
    UIButton *butScore1 = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, heightBut/2 - 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
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
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        butScore2.frame = CGRectMake(50, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 5, 16);
        butScore3.frame = CGRectMake(50, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 5.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butStrategy.frame.size.width - 7 - 36 - 10 - 10, 11);
        
        butScore2.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        butScore3.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:10];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return gameListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOGameCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    TWOGameListModel *gameModel = [gameListArray objectAtIndex:indexPath.row];
    
    cell.imagePic.yy_imageURL = [NSURL URLWithString:[gameModel logo]];
    cell.imagePic.layer.cornerRadius = 4;
    cell.imagePic.layer.masksToBounds = YES;
    
    cell.labelGameName.text = [gameModel name];
    cell.labelGameName.textColor = [UIColor ZiTiColor];
    cell.labelGameName.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    cell.labelContent.text = [gameModel slogan];
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
    TWOGameCenterExplainViewController *gameCenterVC = [[TWOGameCenterExplainViewController alloc] init];
    pushVC(gameCenterVC);
}

//游戏积分按钮
- (void)buttonScoreClicked:(UIButton *)button
{
    NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
    //登录态判断
    if ([[dicLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
        [self loginCome];
    } else {
        TWOMyGameScoreViewController *gameScoreVC = [[TWOMyGameScoreViewController alloc] init];
        pushVC(gameScoreVC);
    }
}

//进入按钮
- (void)buttonGointoGame:(UIButton *)button
{
    NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
    if ([[dicLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
        [self loginCome];
    } else {
        NSLog(@"进入");
    }
}

//弹出登录页面
- (void)loginCome
{
    TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
    UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:loginVC];
    [nvc setNavigationBarHidden:YES animated:YES];
    
    [self presentViewController:nvc animated:YES completion:^{
        
    }];
    return;
}

#pragma mark dataList~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)getDataList
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"game/getGameList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"游戏列表================%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"Games"];
            for (NSDictionary *dataDic in dataArray) {
                TWOGameListModel *gameModel = [[TWOGameListModel alloc] init];
                [gameModel setValuesForKeysWithDictionary:dataDic];
                [gameListArray addObject:gameModel];
            }
            
            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
