//
//  TWOUseTicketViewController.m
//  DSLC
//
//  Created by ios on 16/5/26.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOUseTicketViewController.h"
#import "TWIJiaXiQuanCell.h"
#import "TWOJiaXiQuanModel.h"

@interface TWOUseTicketViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    
    NSInteger page;
    
    NSMutableArray *ticketArray;
    NSMutableArray *ticketNoArray;
    
    // 选中的加息卷Id
    TWOJiaXiQuanModel *incrModel;
    
    MJRefreshBackGifFooter *footerT;
    
    BOOL moreFlag;
}

@end

@implementation TWOUseTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"可用加息券"];
    
    ticketArray = [NSMutableArray array];
    ticketNoArray = [NSMutableArray array];
    
    page = 1;
    
    [self getMyIncreaseList];
}

- (void)returnText:(ReturnJiaXiQuanBlock)block {
    self.returnJiaXiQuanBlock = block;
}
- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.returnJiaXiQuanBlock != nil) {
        self.returnJiaXiQuanBlock(incrModel);
    }
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TWIJiaXiQuanCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self addTableViewWithFooter:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ticketArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWIJiaXiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    TWOJiaXiQuanModel *model = [ticketArray objectAtIndex:indexPath.row];
    
    cell.imagePicture.image = [UIImage imageNamed:@"jiaxijuan"];
    
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", [model incrMoney]]];
    NSRange signRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"%"].location);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:signRange];
    NSRange baifenhao = NSMakeRange([[moneyString string] length] - 1, 1);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:baifenhao];
    [cell.labelMoney setAttributedText:moneyString];
    cell.labelMoney.backgroundColor = [UIColor clearColor];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        cell.labelMoney.frame = CGRectMake(10, 55, 88, 40);
        cell.labelTiaoJian.frame = CGRectMake(100, 27, 170, 19);
        cell.labelEvery.frame = CGRectMake(100, 56, 170, 14);
        cell.labelData.frame = CGRectMake(100, 110, 170, 12);
        cell.butCanUse.frame = CGRectMake(281, 10, 23, 127);
    } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
        cell.labelMoney.frame = CGRectMake(10, 56, 105, 40);
    } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
        cell.labelMoney.frame = CGRectMake(12, 55, 112, 40);
        cell.labelTiaoJian.frame = CGRectMake(130, 27, 220, 19);
        cell.labelEvery.frame = CGRectMake(130, 56, 220, 14);
        cell.labelData.frame = CGRectMake(130, 110, 220, 12);
        cell.butCanUse.frame = CGRectMake(370, 10, 23, 127);
    }
    
    NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", [model investMoney]]];
    NSRange leftRange = NSMakeRange(0, 5);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
    [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[useing string] length] - 2, 2);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
    [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:rightRange];
    [cell.labelTiaoJian setAttributedText:useing];
    cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
    
    if ([[[model applyTypeName] description] isEqualToString:@"0"]) {
        cell.labelEvery.text = @"所有产品可用";
    } else {
        cell.labelEvery.text = [NSString stringWithFormat:@"期限%@天及以上产品可用",[model applyDays]];
    }
    
    cell.labelEvery.backgroundColor = [UIColor clearColor];
    
    [cell.butCanUse setTitle:@"可\n使\n用" forState:UIControlStateNormal];
    cell.butCanUse.titleLabel.numberOfLines = 3;
    cell.butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.butCanUse.backgroundColor = [UIColor clearColor];
    
    cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", [model startDate], [model endDate]];
    cell.labelData.backgroundColor = [UIColor clearColor];
    
    if ([[[model isEnabled] description] isEqualToString:@"1"]) {
        
        cell.contentView.alpha = 0.5;
    } else {
        
        cell.contentView.alpha = 1.0;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TWOJiaXiQuanModel *model = [ticketArray objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![[[model isEnabled] description] isEqualToString:@"1"]) {
    
        incrModel = model;
        popVC;
    }
}

- (void)getMyIncreaseList{
    
    if ([self.transMoney integerValue] <= 100) {
        self.transMoney = @"100";
    }
    
    NSDictionary *parmeter = @{@"curPage":[NSNumber numberWithInteger:page],@"status":@0,@"proPeriod":self.proPeriod,@"transMoney":self.transMoney,@"token":[self.flagDic objectForKey:@"token"],@"pageSize":@1000};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyIncreaseList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyIncreaseList = %@",responseObject);
        
        NSArray *increaseArray = [responseObject objectForKey:@"Increase"];
        for (NSDictionary *dic in increaseArray) {
            TWOJiaXiQuanModel *model = [[TWOJiaXiQuanModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if ([[[model isEnabled] description] isEqualToString:@"0"]) {
                [ticketArray addObject:model];
            } else {
                [ticketNoArray addObject:model];
            }
        }
        
        [ticketArray addObjectsFromArray:ticketNoArray];
        
        if (page == 1) {
            
            [self tableViewShow];
        } else {
            [_tableView reloadData];
        }
        
        if ([[responseObject objectForKey:@"currPage"] isEqual:[responseObject objectForKey:@"totalPage"]]) {
            moreFlag = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 判断是否还要加载更多
#pragma mark --------------------------------

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer{
    
    footerT = footer;
    
    if (moreFlag) {
        // 拿到当前的上拉刷新控件，结束刷新状态
        [footer endRefreshing];
    } else {
        page ++;
        [self getMyIncreaseList];
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
