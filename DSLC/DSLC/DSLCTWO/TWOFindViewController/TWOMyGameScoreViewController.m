//
//  TWOMyGameScoreViewController.m
//  DSLC
//
//  Created by ios on 16/5/9.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyGameScoreViewController.h"
#import "TWOMyGameScoreCell.h"
#import "PNChart.h"
#import "TWOGameListModel.h"
#import "TWOGameScoreModel.h"

@interface TWOMyGameScoreViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UIView *viewHead;
    NSDictionary *responsterDic;
    NSMutableArray *listArray;
    UIButton *butClickMore;
    
    BOOL flagState;
    NSInteger pageNumber;
}

@end

@implementation TWOMyGameScoreViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的游戏积分"];
    
    responsterDic = [NSDictionary dictionary];
    listArray = [NSMutableArray array];
    flagState = NO;
    pageNumber = 1;
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self getMyGameScoreData];
}

- (void)noDataShow
{
    UIImageView *imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, (HEIGHT_CONTROLLER_DEFAULT - 80 - 20 - 53)/2 - 260/2/2, 260/2, 260/2) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageMonkey];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60)];
    UIView *viewFoot = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableFooterView addSubview:viewFoot];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewFoot addSubview:viewLine];
    viewLine.alpha = 0.4;
    
    butClickMore = [UIButton buttonWithType:UIButtonTypeCustom];
    butClickMore.frame = CGRectMake(0, 1, WIDTH_CONTROLLER_DEFAULT, 59.5);
    [viewFoot addSubview:butClickMore];
    [butClickMore setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [butClickMore setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    butClickMore.enabled = YES;
    [butClickMore addTarget:self action:@selector(buttonClickedMoreData:) forControlEvents:UIControlEventTouchUpInside];
    
    viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 247.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor orangeColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMyGameScoreCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self viewHeadShow];
}

- (void)viewHeadShow
{
    UIImageView *imageBottom = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [viewHead addSubview:imageBottom];
    
    UILabel *labelZongScore = [CreatView creatWithLabelFrame:CGRectMake(0, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewHead addSubview:labelZongScore];
    
    NSMutableAttributedString *scoreString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@分", [responsterDic objectForKey:@"integral"]]];
    NSRange shuziRange = NSMakeRange(0, [[scoreString string] rangeOfString:@"分"].location);
    [scoreString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:shuziRange];
    [labelZongScore setAttributedText:scoreString];
    
    PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 60.0, WIDTH_CONTROLLER_DEFAULT, 180.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        lineChart.frame = CGRectMake(0, 30.0 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 133.0);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        lineChart.frame = CGRectMake(0, 30.0 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 164.0);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        lineChart.frame = CGRectMake(0, 60.0, WIDTH_CONTROLLER_DEFAULT, 210.0);
    }
    
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    [lineChart setYValues:@[@"1",@"8",@"2",@"6",@"3"]];
    [lineChart strokeChart];
    [viewHead addSubview:lineChart];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMyGameScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    TWOGameScoreModel *gameScoreModel = [listArray objectAtIndex:indexPath.row];
    
    cell.labelName.text = [gameScoreModel typeName];
    cell.labelName.textColor = [UIColor blackZiTi];
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelTime.text = [gameScoreModel createTime];
    cell.labelTime.textColor = [UIColor findZiTiColor];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    if ([[gameScoreModel mark] isEqualToString:@"+"]) {
        cell.labelScore.text = [NSString stringWithFormat:@"+%@", [gameScoreModel pntegral]];
        cell.labelScore.textColor = [UIColor daohanglan];
        
    } else {
        cell.labelScore.text = [NSString stringWithFormat:@"-%@", [gameScoreModel pntegral]];
        cell.labelScore.textColor = [UIColor profitColor];
    }
    
    cell.labelScore.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark 我的游戏积分~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)getMyGameScoreData
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"], @"curPage":[NSString stringWithFormat:@"%ld", (long)pageNumber], @"pageSize":@"10"};

    [[MyAfHTTPClient sharedClient] postWithURLString:@"integral/getUserIntegralList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"我的游戏积分~~~~~~~~~%@", responseObject);
        responsterDic = responseObject;
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"integralInfo"];
            for (NSDictionary *dataDic in dataArray) {
                TWOGameScoreModel *gameScoreModel = [[TWOGameScoreModel alloc] init];
                [gameScoreModel setValuesForKeysWithDictionary:dataDic];
                [listArray addObject:gameScoreModel];
            }
            
            if (pageNumber == 1) {
                if (listArray.count == 0) {
                    [self noDataShow];
                } else {
                    [self tableViewShow];
                }
            } else {
                [_tableView reloadData];
            }

            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                
                [butClickMore setTitle:@"已显示全部" forState:UIControlStateNormal];
                [butClickMore setTitleColor:[UIColor findZiTiColor] forState:UIControlStateNormal];
                butClickMore.enabled = NO;
                flagState = YES;
                NSLog(@"已显示全部");
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//点击查看更多
- (void)buttonClickedMoreData:(UIButton *)button
{
    NSLog(@"888888");
    if (!flagState) {
        pageNumber++;
        [self getMyGameScoreData];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
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
