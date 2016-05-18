//
//  TWOMonkeyDetailViewController.m
//  DSLC
//
//  Created by ios on 16/5/13.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMonkeyDetailViewController.h"
#import "MyMonkeyNumCell.h"
#import "TWOMonkeyRecordCell.h"

@interface TWOMonkeyDetailViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOMonkeyDetailViewController

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
    [self.navigationItem setTitle:@"猴币记录"];
    
    [self tableViewSHOW];
}

- (void)tableViewSHOW
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45)];
    _tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMonkeyRecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewFootView];
}

- (void)tableViewFootView
{
    UIView *viewLineDown = [CreatView creatViewWithFrame:CGRectMake(0, 45.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLineDown];
    viewLineDown.alpha = 0.3;
    
    UIButton *butMore = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableFooterView.frame.size.height - 0.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"点击查看更多"];
    [_tableView.tableFooterView addSubview:butMore];
    butMore.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butMore addTarget:self action:@selector(buttonCheckMore:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMonkeyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *titleArray = @[@"投资获取", @"活动获取", @"抽奖消耗", @"兑换金斗云", @"兑换收益"];
    cell.labelTitle.text = [titleArray objectAtIndex:indexPath.row];
    cell.labelTitle.textColor = [UIColor ZiTiColor];
    
    cell.labelTime.text = @"2016-01-01";
    cell.labelTime.textColor = [UIColor findZiTiColor];
    
    cell.labelMiddle.hidden = YES;
    cell.labelMiddle.textColor = [UIColor profitColor];
    cell.labelMiddle.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    if (indexPath.row == 3) {
        
        cell.labelMiddle.hidden = NO;
        
        NSMutableAttributedString *profitString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预期额外收益%@元", @"10.00"]];
        NSRange profitRange = NSMakeRange(0, 6);
        [profitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:profitRange];
        [profitString addAttribute:NSForegroundColorAttributeName value:[UIColor findZiTiColor] range:profitRange];
        NSRange oneRange = NSMakeRange([[profitString string] length] - 1, 1);
        [profitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:oneRange];
        [cell.labelMiddle setAttributedText:profitString];
    }
    
    NSArray *numberArr = @[@"+5000", @"+5000", @"-500", @"-200", @"-200"];
    cell.labelNumber.text = [numberArr objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        cell.labelNumber.textColor = [UIColor profitColor];
    } else {
        cell.labelNumber.textColor = [UIColor orangecolor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

//点击查看更多
- (void)buttonCheckMore:(UIButton *)button
{
    NSLog(@"more");
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
