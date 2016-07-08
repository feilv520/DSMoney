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
    NSMutableArray *listArray;
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
    listArray = [NSMutableArray array];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self getMyGameScoreData];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    
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
    
    NSMutableAttributedString *scoreString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@分", @"100098"]];
    NSRange shuziRange = NSMakeRange(0, [[scoreString string] rangeOfString:@"分"].location);
    [scoreString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:shuziRange];
    [labelZongScore setAttributedText:scoreString];
    
    PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 60.0, WIDTH_CONTROLLER_DEFAULT, 180.0)];
    lineChart.backgroundColor = [UIColor clearColor];
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
    
    if (indexPath.row == 5) {
        
        cell.labelScore.text = @"-10,000分";
        cell.labelName.text = @"兑换猴币";
        cell.labelScore.textColor = [UIColor daohanglan];
        
    } else {
        
        cell.labelScore.text = @"+10,000分";
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
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"integral/getUserIntegralList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"我的游戏积分~~~~~~~~~%@", responseObject);
        if ([[responseObject objectForKey:@"resultCode"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"integralInfo"];
            for (NSDictionary *dataDic in dataArray) {
                TWOGameScoreModel *gameScoreModel = [[TWOGameScoreModel alloc] init];
                [gameScoreModel setValuesForKeysWithDictionary:dataDic];
                [listArray addObject:gameScoreModel];
            }
            
            [self tableViewShow];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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
