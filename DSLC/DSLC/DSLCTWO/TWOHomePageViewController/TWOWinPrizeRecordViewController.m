//
//  TWOWinPrizeRecordViewController.m
//  DSLC
//
//  Created by ios on 16/5/23.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOWinPrizeRecordViewController.h"
#import "TWOWinPrizeRecordCell.h"
#import "TWORedBagViewController.h"
#import "TWOWinPrizeModel.h"
#import "TWOMyMonkeyCoinViewController.h"
#import "TWOUsableAllMoneyViewController.h"
#import "MJRefreshBackGifFooter.h"

@interface TWOWinPrizeRecordViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *recordArray;
    UILabel *labelCiShu;
    NSDictionary *resDiction;
    
    MJRefreshBackGifFooter *refreshFooter;
    BOOL flag;
    NSInteger pageNumber;
}

@end

@implementation TWOWinPrizeRecordViewController

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
    [self.navigationItem setTitle:@"中奖纪录"];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    
    recordArray = [NSMutableArray array];
    pageNumber = 1;
    flag = NO;
    
    [self recordList];
}

//没有数据的显示
- (void)noData
{
    UIImageView *imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageMonkey];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 116.0)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOWinPrizeRecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self addTableViewWithFooter:_tableView];
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.4;
    
    [self tabelViewHeadShow];
}

- (void)tabelViewHeadShow
{
    UIImageView *imageHead = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor qianhuise] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageHead];
    
    labelCiShu = [CreatView creatWithLabelFrame:CGRectMake(0, 15, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [imageHead addSubview:labelCiShu];
    NSMutableAttributedString *ciShuString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@次", [resDiction objectForKey:@"totalCount"]]];
    NSRange ciShuRange = NSMakeRange(0, [[ciShuString string] rangeOfString:@"次"].location);
    [ciShuString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:ciShuRange];
    [labelCiShu setAttributedText:ciShuString];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 15 + 40 + 14, WIDTH_CONTROLLER_DEFAULT, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"每日一摇中奖"];
    [imageHead addSubview:labelAlert];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOWinPrizeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    TWOWinPrizeModel *prizeModel = [recordArray objectAtIndex:indexPath.row];
    
    cell.imageRight.image = [UIImage imageNamed:@"clickRightjiantou"];
    cell.labelTime.text = [prizeModel winTime];
    
    if ([[[prizeModel prizeType] description] isEqualToString:@"1"]) {
        cell.imagePic.image = [UIImage imageNamed:@"中奖红包"];
        
        NSString *redBagString = [[prizeModel prizeNumber] stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"摇一摇获得¥%d红包", [redBagString intValue]]];
        NSRange leftRange = NSMakeRange(0, 6);
        [contentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:leftRange];
        [contentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:leftRange];
        NSRange meetRange = NSMakeRange(5, 1);
        [contentString addAttribute:NSForegroundColorAttributeName value:[UIColor orangecolor] range:meetRange];
        NSRange rightRange = NSMakeRange([[contentString string] length] - 2, 2);
        [contentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:rightRange];
        [contentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:rightRange];
        [cell.labelPrize setAttributedText:contentString];
        
    } else if ([[[prizeModel prizeType] description] isEqualToString:@"2"]) {
        [self changeSizeWithLabel:cell.labelPrize nameString:[NSString stringWithFormat:@"摇一摇获得%@%%加息券", [prizeModel prizeNumber]] frontLength:5 afterLength:3];
        cell.imagePic.image = [UIImage imageNamed:@"winRecord"];
        
    } else if ([[[prizeModel prizeType] description] isEqualToString:@"3"]) {
        
        NSString *monkeyCoin = [[prizeModel prizeNumber] stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        [self changeSizeWithLabel:cell.labelPrize nameString:[NSString stringWithFormat:@"摇一摇获得%d猴币", [monkeyCoin intValue]] frontLength:5 afterLength:2];
        cell.imagePic.image = [UIImage imageNamed:@"中奖猴币"];
        
    } else if ([[[prizeModel prizeType] description] isEqualToString:@"4"]) {
        cell.imagePic.image = [UIImage imageNamed:@"中奖现金"];
        
        NSString *moneyStr = [[[prizeModel prizeNumber] description] stringByReplacingOccurrencesOfString:@"," withString:@""];

        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"摇一摇获得¥%d现金", [moneyStr intValue]]];
        NSRange leftRange = NSMakeRange(0, 6);
        [contentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:leftRange];
        [contentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:leftRange];
        NSRange meetRange = NSMakeRange(5, 1);
        [contentString addAttribute:NSForegroundColorAttributeName value:[UIColor orangecolor] range:meetRange];
        NSRange rightRange = NSMakeRange([[contentString string] length] - 2, 2);
        [contentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:rightRange];
        [contentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:rightRange];
        [cell.labelPrize setAttributedText:contentString];
    }
    
    return cell;
}

//改变字体颜色尺寸封装
- (void)changeSizeWithLabel:(UILabel *)label nameString:(NSString *)str frontLength:(NSInteger)frontLength afterLength:(NSInteger)afterLength
{
    NSMutableAttributedString *percentString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange leftRange = NSMakeRange(0, frontLength);
    [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:leftRange];
    [percentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:leftRange];
    NSRange rightRange = NSMakeRange([[percentString string] length] - afterLength, afterLength);
    [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:rightRange];
    [percentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:rightRange];
    [label setAttributedText:percentString];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TWOWinPrizeModel *prizeModel = [recordArray objectAtIndex:indexPath.row];
    
    if ([[[prizeModel prizeType] description] isEqualToString:@"1"]) {
        TWORedBagViewController *redBageVC = [[TWORedBagViewController alloc] init];
        pushVC(redBageVC);
        
    } else if ([[[prizeModel prizeType] description] isEqualToString:@"2"]) {
        
        TWORedBagViewController *redBagVC = [[TWORedBagViewController alloc] init];
        redBagVC.recordState = @"2";
        pushVC(redBagVC);
        
    } else if ([[[prizeModel prizeType] description] isEqualToString:@"3"]) {
        TWOMyMonkeyCoinViewController *monkeyCoinVC = [[TWOMyMonkeyCoinViewController alloc] init];
        pushVC(monkeyCoinVC);
        
    } else if ([[[prizeModel prizeType] description] isEqualToString:@"4"]) {
        TWOUsableAllMoneyViewController *usableMoneyVC = [[TWOUsableAllMoneyViewController alloc] init];
        pushVC(usableMoneyVC);
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

#pragma mark data---------------------------------------------
- (void)recordList
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"], @"curPage":[NSString stringWithFormat:@"%ld", (long)pageNumber], @"pageSize":@"10"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"shake/getShakeWinning" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"摇一摇中奖纪录::::::::::::::%@", responseObject);
        [self loadingWithHidden:YES];
        resDiction = responseObject;
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *dataArray = [responseObject objectForKey:@"prize"];
            for (NSDictionary *dataDic in dataArray) {
                TWOWinPrizeModel *prizeModel = [[TWOWinPrizeModel alloc] init];
                [prizeModel setValuesForKeysWithDictionary:dataDic];
                [recordArray addObject:prizeModel];
            }
            
            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                flag = YES;
            }
            
            if (pageNumber == 1) {
                if (recordArray.count == 0) {
                    [self noData];
                } else {
                    [self tabelViewShow];
                }
            } else {
                [_tableView reloadData];
            }
            
            [refreshFooter endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer
{
    refreshFooter = footer;
    
    if (flag) {
        [refreshFooter endRefreshing];
    } else {
        pageNumber++;
        [self recordList];
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
