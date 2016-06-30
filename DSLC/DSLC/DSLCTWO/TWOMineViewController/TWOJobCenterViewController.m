//
//  TWOJobCenterViewController.m
//  DSLC
//
//  Created by ios on 16/5/12.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOJobCenterViewController.h"
#import "TWOJobCenterCell.h"
#import "TWOTaskModel.h"
#import "TWOEmailViewController.h"
#import "TWOSetLoginSecretViewController.h"
#import "TWOHandSettingViewController.h"
#import "TWOAddressManageViewController.h"
#import "TWOYaoYiYaoViewController.h"
#import "TBaoJiViewController.h"
#import "NewInviteViewController.h"

@interface TWOJobCenterViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    // tableview 头部元素
    UIImageView *imageBackGround;
    //    任务进度圆圈
    UIImageView *imageSchedule;
    UILabel *labelPlan;
    UILabel *labelZi;
    
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *taskArray;
@property (nonatomic, strong) NSString *finishString;
@property (nonatomic, strong) NSString *countString;

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
    
    self.taskArray = [NSMutableArray array];
    
    [self loadingWithView:self.view loadingFlag:NO height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2.0 - 50];
    
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
    if (imageBackGround == nil) {
        
        imageBackGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    }
    [_tableView.tableHeaderView addSubview:imageBackGround];
    
//    任务进度圆圈
    if (imageSchedule == nil) {
        
        imageSchedule = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 60, imageBackGround.frame.size.height/2 - 70, 120, 120) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"renwujindu1"]];
    }
    [imageBackGround addSubview:imageSchedule];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        imageSchedule.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 50, 10, 100, 100);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        imageSchedule.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 45, 5, 90, 90);
    }
    
    if (labelPlan == nil) {
        
        labelPlan = [CreatView creatWithLabelFrame:CGRectMake(5, imageSchedule.frame.size.height/2 - 30, imageSchedule.frame.size.width - 10, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:28] text:[NSString stringWithFormat:@"%@/%@", self.finishString, self.countString]];
    }
    labelPlan.text = [NSString stringWithFormat:@"%@/%@", self.finishString, self.countString];
    [imageSchedule addSubview:labelPlan];

    if (labelZi == nil) {
        
        labelZi = [CreatView creatWithLabelFrame:CGRectMake(5, imageSchedule.frame.size.height/2 + 9, imageSchedule.frame.size.width - 10, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"任务进度"];
    }
    [imageSchedule addSubview:labelZi];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.taskArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOJobCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    TWOTaskModel *taskModel = [self.taskArray objectAtIndex:indexPath.section];
    
//    NSArray *imageArray = @[@"qiandao", @"shoushi", @"xintouzi", @"touzis", @"touzis"];
    cell.imagePic.yy_imageURL = [NSURL URLWithString:[taskModel taskImg]];
    
//    NSArray *jobArray = @[@"每日签到", @"手势密码设置", @"新人体验金投资", @"首次实际投资", @"今日投资100"];
    cell.labelJobName.text = [taskModel taskName];
    cell.labelJobName.textColor = [UIColor ZiTiColor];
    cell.labelJobName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
//    NSArray *contentArray = @[@"今日签到猴币+10", @"设置完成猴币+10", @"投资完成猴币+10", @"投资完成猴币+10", @"投资完成猴币+10"];
    cell.labelAddCoin.text = [taskModel taskCaption];
    cell.labelAddCoin.textColor = [UIColor findZiTiColor];
    cell.labelAddCoin.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    if ([[[taskModel status] debugDescription] isEqualToString:@"1"]) {
        
        [cell.butFinish setTitle:@"已完成" forState:UIControlStateNormal];
        cell.butFinish.backgroundColor = [UIColor findZiTiColor];
        cell.butFinish.alpha = 0.4;
        
    } else {
        
        [cell.butFinish setTitle:@"去完成" forState:UIControlStateNormal];
        [cell.butFinish setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
        cell.butFinish.layer.borderColor = [[UIColor profitColor] CGColor];
        cell.butFinish.layer.borderWidth = 1;
    }
    
    cell.butFinish.tag = indexPath.section;
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
    TWOTaskModel *taskModel = [self.taskArray objectAtIndex:button.tag];
    
    switch ([[taskModel taskType] integerValue]) {
        case 1:{
                NSLog(@"开通汇付账号");
                break;
            }
        case 2:{
            NSLog(@"绑定银行卡");
            break;
        }
        case 3:{
            NSLog(@"实名认证");
            break;
        }
        case 4:{
            NSLog(@"绑定邮箱");
            TWOEmailViewController *emailVC = [[TWOEmailViewController alloc] init];
            pushVC(emailVC);
            break;
        }
        case 5:{
            NSLog(@"设置登录密码");
            TWOSetLoginSecretViewController *setLoginSVC = [[TWOSetLoginSecretViewController alloc] init];
            pushVC(setLoginSVC);
            break;
        }
        case 6:{
            NSLog(@"设置手势密码");
            TWOHandSettingViewController *handSettingVC = [[TWOHandSettingViewController alloc] init];
            pushVC(handSettingVC);
            break;
        }
        case 7:{
            NSLog(@"体验金使用");
            break;
        }
        case 8:{
            NSLog(@"首次有效投资");
            break;
        }
        case 9:{
            NSLog(@"填写地址");
            TWOAddressManageViewController *addressMVC = [[TWOAddressManageViewController alloc] init];
            pushVC(addressMVC);
            break;
        }
        case 10:{
            NSLog(@"每日签到");
            break;
        }
        case 11:{
            NSLog(@"每日投资");
            break;
        }
        case 12:{
            NSLog(@"每日一摇");
            TWOYaoYiYaoViewController *yaoYiYaoVC = [[TWOYaoYiYaoViewController alloc] init];
            pushVC(yaoYiYaoVC);
            break;
        }
        case 13:{
            NSLog(@"玩小游戏");
            break;
        }
        case 14:{
            NSLog(@"参加爆击抽奖");
            TBaoJiViewController *baojiVC = [[TBaoJiViewController alloc] init];
            pushVC(baojiVC);
            break;
        }
        case 15:{
            NSLog(@"邀请好友");
            NewInviteViewController *newInviteVC = [[NewInviteViewController alloc] init];
            pushVC(newInviteVC);
            break;
        }
        case 16:{
            NSLog(@"单笔投资");
            break;
        }
        case 17:{
            NSLog(@"累计投资");
            break;
        }
        case 18:{
            NSLog(@"固收投资");
            break;
        }
        default:
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"敬请期待"];
            break;
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

#pragma mark 我的猴币详情
#pragma mark --------------------------------

//获取数据
- (void)getUserTaskListFuction
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"],};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"task/getUserTaskList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        _tableView.hidden = NO;
        
        NSLog(@"任务中心详情:~~~~~%@", responseObject);
        
        NSArray *taskArr = [responseObject objectForKey:@"Task"];
        
        self.countString = [responseObject objectForKey:@"totalCount"];
        self.finishString = [responseObject objectForKey:@"finishCount"];
        
        for (NSDictionary *dic in taskArr) {
            TWOTaskModel *taskModel = [[TWOTaskModel alloc] init];
            [taskModel setValuesForKeysWithDictionary:dic];
            [self.taskArray addObject:taskModel];
        }
        
        [_tableView reloadData];
        [self tableViewHeadShow];
        
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
