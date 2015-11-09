//
//  HistoryMemoryViewController.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "HistoryMemoryViewController.h"
#import "HistoryMemoryCell.h"

@interface HistoryMemoryViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
    NSArray *stateArr;
}

@end

@implementation HistoryMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"历史记录"];
    
    [self tabelViewSHow];
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
    
    stateArr = @[@"进行中", @"成功", @"审核未通过", @"充值失败", @"已撤销"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryMemoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelBigMoney.text = @"大额充值";
    cell.labelBigMoney.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelTime.text = @"2015-09-20";
    cell.labelTime.textColor = [UIColor zitihui];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    cell.labelMoney.text = @"+10000元";
    cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.labelState.text = [stateArr objectAtIndex:indexPath.row];
    cell.labelState.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        cell.labelState.textColor = [UIColor chongzhiColor];
        
    } else {
        
        cell.labelState.textColor = [UIColor daohanglan];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
