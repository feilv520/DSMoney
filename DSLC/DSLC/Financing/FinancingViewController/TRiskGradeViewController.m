//
//  TRiskGradeViewController.m
//  DSLC
//
//  Created by ios on 16/3/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TRiskGradeViewController.h"
#import "TRiskCell.h"
#import "TRightNowViewController.h"

@interface TRiskGradeViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *nameArr;
    NSArray *styleArr;
}

@end

@implementation TRiskGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"风险等级"];
    
    nameArr = @[@"用户等级", @"A1   (保守型)", @"A2   (稳健性)", @"A3   (平衡型)", @"A4   (成长型)", @"A5   (进取型)"];
    styleArr = @[@"产品等级", @"R1   (谨慎型)", @"R2   (稳健性)", @"R3   (平衡型)", @"R4   (进取型)", @"R5   (激进型)"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 170)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TRiskCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"您是否需要进行风险等级评测"];
    [_tableView.tableFooterView addSubview:labelAlert];
    
    UIButton *butonPing = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 85, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"立即测评"];
    [_tableView.tableFooterView addSubview:butonPing];
    butonPing.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butonPing setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butonPing setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [butonPing addTarget:self action:@selector(buttonRightNowCePing:) forControlEvents:UIControlEventTouchUpInside];
}

//立即测评按钮
- (void)buttonRightNowCePing:(UIButton *)button
{
    TRightNowViewController *rightNow = [[TRightNowViewController alloc] init];
    [self.navigationController pushViewController:rightNow animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    cell.labelName.text = [nameArr objectAtIndex:indexPath.row];

    cell.labelStyle.text = [styleArr objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"risk" object:[styleArr objectAtIndex:indexPath.row]];
//    [self.navigationController popViewControllerAnimated:YES];
//}

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
