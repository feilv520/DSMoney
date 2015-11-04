//
//  InvestNoticeViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "InvestNoticeViewController.h"
#import "InvestNoticeCell.h"

@interface InvestNoticeViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *contentArr;
    CGRect rect;
}

@end

@implementation InvestNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"投资须知"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"InvestNoticeCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    titleArr = @[@"1.购买条件", @"2.到期兑付"];
    contentArr = @[@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天,到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天,到期后兑付3天收益。", @"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天,到期后兑付3天收益。"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height + 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvestNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelOneTwo.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelOneTwo.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelContent.text = [contentArr objectAtIndex:indexPath.row];
    cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    cell.labelContent.textColor = [UIColor zitihui];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:13],NSFontAttributeName, nil];
    rect = [cell.labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    cell.labelContent.numberOfLines = 0;
    NSLog(@"%f", cell.labelContent.frame.origin.y);
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
