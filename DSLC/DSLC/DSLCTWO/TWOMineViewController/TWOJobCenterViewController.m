//
//  TWOJobCenterViewController.m
//  DSLC
//
//  Created by ios on 16/5/12.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOJobCenterViewController.h"
#import "TWOJobCenterCell.h"

@interface TWOJobCenterViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOJobCenterViewController

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
    [self.navigationItem setTitle:@"任务中心"];
    
    [self getUserTaskListFuction];
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor lineColor];
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 151.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOJobCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
//    蓝色背景
    UIImageView *imageBackGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageBackGround];
    
//    任务进度圆圈
    UIImageView *imageSchedule = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 60, imageBackGround.frame.size.height/2 - 70, 120, 120) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"renwujindu1"]];
    [imageBackGround addSubview:imageSchedule];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        imageSchedule.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 50, 10, 100, 100);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        imageSchedule.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 45, 5, 90, 90);
    }
    
    UILabel *labelPlan = [CreatView creatWithLabelFrame:CGRectMake(5, imageSchedule.frame.size.height/2 - 30, imageSchedule.frame.size.width - 10, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:28] text:[NSString stringWithFormat:@"%@/%@", @"1", @"5"]];
    [imageSchedule addSubview:labelPlan];
    
    UILabel *labelZi = [CreatView creatWithLabelFrame:CGRectMake(5, imageSchedule.frame.size.height/2 + 9, imageSchedule.frame.size.width - 10, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"任务进度"];
    [imageSchedule addSubview:labelZi];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOJobCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *imageArray = @[@"qiandao", @"shoushi", @"xintouzi", @"touzis", @"touzis"];
    cell.imagePic.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.section]];
    
    NSArray *jobArray = @[@"每日签到", @"手势密码设置", @"新人体验金投资", @"首次实际投资", @"今日投资100"];
    cell.labelJobName.text = [jobArray objectAtIndex:indexPath.section];
    cell.labelJobName.textColor = [UIColor ZiTiColor];
    cell.labelJobName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    NSArray *contentArray = @[@"今日签到猴币+10", @"设置完成猴币+10", @"投资完成猴币+10", @"投资完成猴币+10", @"投资完成猴币+10"];
    cell.labelAddCoin.text = [contentArray objectAtIndex:indexPath.section];
    cell.labelAddCoin.textColor = [UIColor findZiTiColor];
    cell.labelAddCoin.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    if (indexPath.section == 0) {
        
        [cell.butFinish setTitle:@"已完成" forState:UIControlStateNormal];
        cell.butFinish.backgroundColor = [UIColor findZiTiColor];
        cell.butFinish.alpha = 0.4;
        
    } else {
        
        [cell.butFinish setTitle:@"去完成" forState:UIControlStateNormal];
        [cell.butFinish setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
        cell.butFinish.layer.borderColor = [[UIColor profitColor] CGColor];
        cell.butFinish.layer.borderWidth = 1;
    }
    
    cell.butFinish.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.butFinish.layer.cornerRadius = 3;
    cell.butFinish.layer.masksToBounds = YES;
    [cell.butFinish addTarget:self action:@selector(goToFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

//去完成按钮
- (void)goToFinishButton:(UIButton *)button
{
    NSLog(@"go");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
    }
}

#pragma mark 我的猴币详情
#pragma mark --------------------------------

//获取数据
- (void)getUserTaskListFuction
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"],};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"task/getUserTaskList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"任务中心详情:~~~~~%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
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
