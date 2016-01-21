//
//  HistoryMemoryViewController.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "HistoryMemoryViewController.h"
#import "HistoryMemoryCell.h"
#import "BigMoneyHistory.h"

@interface HistoryMemoryViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
    NSMutableArray *stateArr;
}

@end

@implementation HistoryMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"历史记录"];
    
    [self tabelViewSHow];
    [self getData];
    
    stateArr = [NSMutableArray array];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    _tabelView.hidden = YES;
}

- (void)tabelViewSHow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor huibai];
    _tabelView.tableFooterView = [UIView new];
    [_tabelView registerNib:[UINib nibWithNibName:@"HistoryMemoryCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryMemoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    BigMoneyHistory *bigMoney = [stateArr objectAtIndex:indexPath.row];
    
    cell.labelBigMoney.text = @"大额充值";
    cell.labelBigMoney.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelTime.text = bigMoney.createTime;
    cell.labelTime.textColor = [UIColor zitihui];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    cell.labelMoney.text = [DES3Util decrypt:bigMoney.money];
    cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.labelState.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    if ([[bigMoney.status description] isEqualToString:@"0"]) {
        cell.labelState.text = @"已申请";
        cell.labelState.textColor= [UIColor zitihui];
        
    } else if ([[bigMoney.status description] isEqualToString:@"1"]) {
        cell.labelState.text = @"已提供银行转账流水号";
        cell.labelState.textColor = [UIColor chongzhiColor];

    } else if ([[bigMoney.status description] isEqualToString:@"2"]) {
        cell.labelState.text = @"审核失败";
        cell.labelState.textColor = [UIColor daohanglan];
        
    } else if ([[bigMoney.status description] isEqualToString:@"3"]) {
        cell.labelState.text = @"审核成功";
        cell.labelState.textColor = [UIColor chongzhiColor];
        
    } else if ([[bigMoney.status description] isEqualToString:@"4"]) {
        cell.labelState.text = @"复核失败";
        cell.labelState.textColor = [UIColor daohanglan];
        
    } else if ([[bigMoney.status description] isEqualToString:@"5"]) {
        cell.labelState.text = @"复核成功";
        cell.labelState.textColor = [UIColor chongzhiColor];
        
    } else if ([[bigMoney.status description] isEqualToString:@"6"]) {
        cell.labelState.text = @"取消充值";
        cell.labelState.textColor = [UIColor zitihui];
        
    } else {
        cell.labelState.text = @"充值成功";
        cell.labelState.textColor = [UIColor chongzhiColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
- (void)getData
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *parameter = @{@"curPage":@1, @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getBigPutOnList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"kkkkkkkkkkkkk%@", responseObject);
        [self loadingWithHidden:YES];
        NSMutableArray *dataArr = [responseObject objectForKey:@"BigPutOn"];
        
        if (dataArr.count == 0) {
            
            [self noDateWithView:@"无历史记录" height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20)/2 view:self.view];
            _tabelView.hidden = YES;
            
        } else {
            _tabelView.hidden = NO;
            
            for (NSDictionary *dataDic in dataArr) {
                BigMoneyHistory *bigMoney = [[BigMoneyHistory alloc] init];
                [bigMoney setValuesForKeysWithDictionary:dataDic];
                [stateArr addObject:bigMoney];
            }
            
            [_tabelView reloadData];
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
