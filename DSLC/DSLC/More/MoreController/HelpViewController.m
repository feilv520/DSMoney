//
//  HelpViewController.m
//  DSLC
//
//  Created by ios on 15/10/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpCell.h"
#import "NewHandViewController.h"

@interface HelpViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"帮助中心"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_tableView registerNib:[UINib nibWithNibName:@"HelpCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    titleArr = @[@"新手指南", @"常见问题"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.imageViewRight.image = [UIImage imageNamed:@"arrow"];
    
    return cell;
}

//新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        NewHandViewController *newHandVC = [[NewHandViewController alloc] init];
        newHandVC.signStr = NO;
        [self.navigationController pushViewController:newHandVC animated:YES];
        
    } else {
        
        
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
