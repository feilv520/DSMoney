//
//  MyChoosePlanner.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyChoosePlanner.h"
#import "MyChoosePlannerCell.h"
#import "MyPlannerViewController.h"

@interface MyChoosePlanner () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation MyChoosePlanner

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的理财师"];
    
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
    [_tableView registerNib:[UINib nibWithNibName:@"MyChoosePlannerCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return 8;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyChoosePlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imageHead.image = [UIImage imageNamed:@"picture"];
    
    cell.labelName.text = @"林海峰";
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelInvite.text = @"邀请码:389756";
    cell.labelInvite.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.labelInvite.textColor = [UIColor zitihui];
    
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
    if (indexPath.section == 0) {
        
        cell.labelTop.hidden = YES;
        
    } else {
        
        cell.labelTop.backgroundColor = [UIColor grayColor];
        cell.labelTop.alpha = 0.2;
        
    }
    
    cell.labelDown.backgroundColor = [UIColor grayColor];
    cell.labelDown.alpha = 0.2;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPlannerViewController *plannerVC = [[MyPlannerViewController alloc] init];
    [self.navigationController pushViewController:plannerVC animated:YES];
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
