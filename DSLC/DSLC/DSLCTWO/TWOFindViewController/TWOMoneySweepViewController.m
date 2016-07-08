//
//  TWOMoneySweepViewController.m
//  DSLC
//
//  Created by ios on 16/5/27.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMoneySweepViewController.h"
#import "TWOMoneySweepCell.h"
#import "TWOSweepModel.h"
#import "MJRefreshBackGifFooter.h"

@interface TWOMoneySweepViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *bigSweepArray;
    NSMutableArray *DSLCTalkArray;
    NSInteger pageNumber;
    BOOL flagStste;
    MJRefreshBackGifFooter *refreshFooter;
}

@end

@implementation TWOMoneySweepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    bigSweepArray = [NSMutableArray array];
    DSLCTalkArray = [NSMutableArray array];
    pageNumber = 1;
    flagStste = NO;
    
    if ([self.kindState isEqualToString:@"1"]) {
        
        [self.navigationItem setTitle:@"大圣侃经"];
        [self getKanJingData];
        
    } else if ([self.kindState isEqualToString:@"2"]) {
        
        [self.navigationItem setTitle:@"投资大扫描"];
        [self getBigSweepData];
    }
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

//无数据显示
- (void)nodataImageShow
{
    UIImageView *imageNoData = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, (HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2 - 260/2/2, 260/2, 260/2) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageNoData];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMoneySweepCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self addTableViewWithFooter:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.kindState isEqualToString:@"1"]) {
        return DSLCTalkArray.count;
    } else {
        return bigSweepArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMoneySweepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if ([self.kindState isEqualToString:@"1"]) {
        //大圣侃经
        TWOSweepModel *sweepModel = [DSLCTalkArray objectAtIndex:indexPath.row];
        NSLog(@"大圣侃经");
        cell.viewBottom.layer.cornerRadius = 3;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.imageBackGround.yy_imageURL = [NSURL URLWithString:[sweepModel imImg]];
        
        cell.labelAlpha.backgroundColor = [UIColor blackColor];
        cell.labelAlpha.alpha = 0.6;
        
        cell.labelContent.text = [sweepModel imTitle];
        cell.labelContent.textColor = [UIColor whiteColor];
        cell.labelContent.backgroundColor = [UIColor clearColor];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        [cell.buttonSee setTitle:[NSString stringWithFormat:@" %@", [sweepModel imBrowseNum]] forState:UIControlStateNormal];
        [cell.buttonSee setImage:[UIImage imageNamed:@"seewhite"] forState:UIControlStateNormal];
        cell.buttonSee.backgroundColor = [UIColor clearColor];
        
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
        cell.buttonPlay.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    } else {
        //投资大扫描
        TWOSweepModel *sweepModel = [bigSweepArray objectAtIndex:indexPath.row];
        
        cell.viewBottom.layer.cornerRadius = 3;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.imageBackGround.yy_imageURL = [NSURL URLWithString:[sweepModel imImg]];
        
        cell.labelAlpha.backgroundColor = [UIColor blackColor];
        cell.labelAlpha.alpha = 0.6;
        
        cell.labelContent.text = [sweepModel imTitle];
        cell.labelContent.textColor = [UIColor whiteColor];
        cell.labelContent.backgroundColor = [UIColor clearColor];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        [cell.buttonSee setTitle:[NSString stringWithFormat:@" %@", [sweepModel imBrowseNum]] forState:UIControlStateNormal];
        [cell.buttonSee setImage:[UIImage imageNamed:@"seewhite"] forState:UIControlStateNormal];
        cell.buttonSee.backgroundColor = [UIColor clearColor];
        
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
        cell.buttonPlay.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
}

#pragma mark 侃经---------------------------------
- (void)getKanJingData
{
    NSDictionary *parmeter = @{@"type":@7, @"curPage":@1};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"index/getInfoManageList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"大圣侃经-------------%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *tempArray = [responseObject objectForKey:@"InfoManage"];
            for (NSDictionary *tempDic in tempArray) {
                TWOSweepModel *sweepTalkModel = [[TWOSweepModel alloc] init];
                [sweepTalkModel setValuesForKeysWithDictionary:tempDic];
                [DSLCTalkArray addObject:sweepTalkModel];
            }
            
            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                flagStste = YES;
            }
            [refreshFooter endRefreshing];
            
            //判断有无数据的显示
            if (pageNumber == 1) {
                if (DSLCTalkArray.count == 0) {
                    [self nodataImageShow];
                } else {
                    [self tableViewShow];
                }
            } else {
                [_tableView reloadData];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark 大扫描----------------------------------
- (void)getBigSweepData
{
    NSLog(@"大扫描");
    NSDictionary *parmeter = @{@"type":@6, @"curPage":@1};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"index/getInfoManageList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"大扫描-----------------%@", responseObject);
        
        NSMutableArray *dataArray = [responseObject objectForKey:@"InfoManage"];
        for (NSDictionary *dataDic in dataArray) {
            TWOSweepModel *sweepModel = [[TWOSweepModel alloc] init];
            [sweepModel setValuesForKeysWithDictionary:dataDic];
            [bigSweepArray addObject:sweepModel];
        }
        
        //判断是否到达最后的页数
        if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
            flagStste = YES;
        }
        [refreshFooter endRefreshing];
        
        //判断有无数据的显示
        if (pageNumber == 1) {
            if (bigSweepArray.count == 0) {
                [self nodataImageShow];
            } else {
                [self tableViewShow];
            }
        } else {
            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer
{
    refreshFooter = footer;
    if (flagStste) {
        [refreshFooter endRefreshing];
    } else {
        pageNumber++;
        [self getBigSweepData];
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
