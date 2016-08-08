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
#import "TWOMessageModel.h"
#import "TWODSLCTalkDetailViewController.h"
#import "TWOBigSweepDetailViewController.h"

@interface TWOMoneySweepViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *bigSweepArray;
    NSMutableArray *DSLCTalkArray;
    NSInteger pageNumber;
    BOOL flagStste;
    MJRefreshBackGifFooter *refreshFooter;
    MJRefreshGifHeader *headerT;
    UIButton *buttonIndex;
    
    BOOL ifHaveTableView;
    
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
    ifHaveTableView = NO;
    
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
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
    
    ifHaveTableView = YES;
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
        TWOMessageModel *sweepModel = [DSLCTalkArray objectAtIndex:indexPath.row];
        cell.viewBottom.layer.cornerRadius = 4;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.imageBackGround.yy_imageURL = [NSURL URLWithString:[sweepModel cover]];
        
        cell.labelAlpha.backgroundColor = [UIColor blackColor];
        cell.labelAlpha.alpha = 0.6;
        
        cell.labelContent.text = [sweepModel title];
        cell.labelContent.textColor = [UIColor whiteColor];
        cell.labelContent.backgroundColor = [UIColor clearColor];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        [cell.buttonSee setTitle:[NSString stringWithFormat:@" %@", [sweepModel readNum]] forState:UIControlStateNormal];
        [cell.buttonSee setImage:[UIImage imageNamed:@"seewhite"] forState:UIControlStateNormal];
        cell.buttonSee.backgroundColor = [UIColor clearColor];
        
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
        cell.buttonPlay.backgroundColor = [UIColor clearColor];
        cell.buttonPlay.tag = indexPath.row;
        [cell.buttonPlay addTarget:self action:@selector(buttonPlayClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        //投资大扫描
        TWOMessageModel *sweepModel = [bigSweepArray objectAtIndex:indexPath.row];
        
        cell.viewBottom.layer.cornerRadius = 4;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.imageBackGround.yy_imageURL = [NSURL URLWithString:[sweepModel cover]];
        
        cell.labelAlpha.backgroundColor = [UIColor blackColor];
        cell.labelAlpha.alpha = 0.6;
        
        cell.labelContent.text = [sweepModel title];
        cell.labelContent.textColor = [UIColor whiteColor];
        cell.labelContent.backgroundColor = [UIColor clearColor];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        [cell.buttonSee setTitle:[NSString stringWithFormat:@" %@", [sweepModel readNum]] forState:UIControlStateNormal];
        [cell.buttonSee setImage:[UIImage imageNamed:@"seewhite"] forState:UIControlStateNormal];
        cell.buttonSee.backgroundColor = [UIColor clearColor];
        
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [cell.buttonPlay setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
        cell.buttonPlay.backgroundColor = [UIColor clearColor];
        cell.buttonPlay.tag = indexPath.row;
        [cell.buttonPlay addTarget:self action:@selector(buttonPlayClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"6666");
    if ([self.kindState isEqualToString:@"1"]) {
        
        TWOMessageModel *messageModel = [DSLCTalkArray objectAtIndex:indexPath.row];
        TWODSLCTalkDetailViewController *talkDetail = [[TWODSLCTalkDetailViewController alloc] init];
        talkDetail.talkID = [messageModel ID];
        pushVC(talkDetail);
        
    } else if ([self.kindState isEqualToString:@"2"]) {
        TWOMessageModel *messageModel = [bigSweepArray objectAtIndex:indexPath.row];
        TWOBigSweepDetailViewController *sweepDeatil = [[TWOBigSweepDetailViewController alloc] init];
        sweepDeatil.sweepID = [messageModel ID];
        pushVC(sweepDeatil);
    }
}

//tableView上的按钮与tabelView点击方法要同步
- (void)buttonPlayClicked:(UIButton *)button
{
    if ([self.kindState isEqualToString:@"1"]) {
        
        TWOMessageModel *messageModel = [DSLCTalkArray objectAtIndex:button.tag];
        TWODSLCTalkDetailViewController *talkDetail = [[TWODSLCTalkDetailViewController alloc] init];
        talkDetail.talkID = [messageModel ID];
        pushVC(talkDetail);
        
    } else if ([self.kindState isEqualToString:@"2"]) {
        TWOMessageModel *messageModel = [bigSweepArray objectAtIndex:button.tag];
        TWOBigSweepDetailViewController *sweepDeatil = [[TWOBigSweepDetailViewController alloc] init];
        sweepDeatil.sweepID = [messageModel ID];
        pushVC(sweepDeatil);
    }
}

#pragma mark 侃经---------------------------------
- (void)getKanJingData
{
    NSDictionary *parmeter = @{@"type":@3, @"curPage":[NSString stringWithFormat:@"%ld", (long)pageNumber], @"pageSize":@10};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"notice/getNoticeList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"大圣侃经-------------%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *tempArray = [responseObject objectForKey:@"noticeInfo"];
            for (NSDictionary *tempDic in tempArray) {
                TWOMessageModel *messageModel = [[TWOMessageModel alloc] init];
                [messageModel setValuesForKeysWithDictionary:tempDic];
                [DSLCTalkArray addObject:messageModel];
            }

            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                flagStste = YES;
            }
            
            [refreshFooter endRefreshing];
            [headerT endRefreshing];
            
            //判断有无数据的显示
            if (pageNumber == 1) {
                if (DSLCTalkArray.count == 0) {
                    [self nodataImageShow];
                } else {
                    if (ifHaveTableView) {
                        
                        [self tableViewShow];
                    } else {
                        
                        [_tableView reloadData];
                    }
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
    NSDictionary *parmeter = @{@"type":@2, @"curPage":[NSString stringWithFormat:@"%ld", (long)pageNumber], @"pageSize":@10};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"notice/getNoticeList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"大扫描-----------------%@", responseObject);
        
        NSMutableArray *dataArray = [responseObject objectForKey:@"noticeInfo"];
        for (NSDictionary *dataDic in dataArray) {
            TWOMessageModel *sweepModel = [[TWOMessageModel alloc] init];
            [sweepModel setValuesForKeysWithDictionary:dataDic];
            [bigSweepArray addObject:sweepModel];
        }
        
        //判断是否到达最后的页数
        if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
            flagStste = YES;
        }
        
        [refreshFooter endRefreshing];
        [headerT endRefreshing];
        
        //判断有无数据的显示
        if (pageNumber == 1) {
            if (bigSweepArray.count == 0) {
                [self nodataImageShow];
            } else {
                if (ifHaveTableView) {
                    
                    [_tableView reloadData];
                } else {
                    
                    [self tableViewShow];
                }
            }
        } else {
            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//上拉加载
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

//下拉刷新
- (void)loadNewData:(MJRefreshGifHeader *)header
{
    headerT = header;
    
    if ([self.kindState isEqualToString:@"1"]) {
        if (DSLCTalkArray != nil) {
            [DSLCTalkArray removeAllObjects];
            DSLCTalkArray = nil;
            DSLCTalkArray = [NSMutableArray array];
        }
        pageNumber = 1;
        [self getKanJingData];
        
    } else if ([self.kindState isEqualToString:@"2"]) {
        if (bigSweepArray != nil) {
            [bigSweepArray removeAllObjects];
            bigSweepArray = nil;
            bigSweepArray = [NSMutableArray array];
        }
        pageNumber = 1;
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
