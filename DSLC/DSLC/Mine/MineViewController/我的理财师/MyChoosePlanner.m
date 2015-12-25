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
#import "Planner.h"

@interface MyChoosePlanner () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *plannerArr;
}

@end

@implementation MyChoosePlanner

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的理财师"];
    
    plannerArr = [NSMutableArray array];
    [self tableViewShow];
    [self getPlannerData];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    _tableView.hidden = YES;
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
    return plannerArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyChoosePlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    Planner *plan = [plannerArr objectAtIndex:indexPath.section];
    
    cell.imageHead.yy_imageURL = [NSURL URLWithString:plan.avatarImg];
    cell.imageHead.layer.cornerRadius = cell.imageHead.frame.size.width/2;
    cell.imageHead.layer.masksToBounds = YES;
    
    cell.labelName.text = plan.userRealname;
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelInvite.text = plan.inviteCode;
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
    Planner *planner = [plannerArr objectAtIndex:indexPath.section];
    MyPlannerViewController *plannerVC = [[MyPlannerViewController alloc] init];
    plannerVC.IDStr = planner.ID;
    [self.navigationController pushViewController:plannerVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
//获取数据
- (void)getPlannerData
{
    NSDictionary *parameter = @{@"curPage":@1};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/index/getIndexFinPlannerList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [self loadingWithHidden:YES];
            _tableView.hidden = NO;
            
            NSMutableArray *userArr = [responseObject objectForKey:@"User"];
            
            if (userArr.count == 0) {
                
                [self noDateWithView:@"暂无理财师" height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20)/2 view:self.view];
                _tableView.hidden = YES;
                
            } else {
                [self noDataViewWithRemoveToView];
                
                NSMutableArray *userArr = [responseObject objectForKey:@"User"];
                for (NSDictionary *userDic in userArr) {
                    
                    Planner *plan = [[Planner alloc] init];
                    [plan setValuesForKeysWithDictionary:userDic];
                    [plannerArr addObject:plan];
                }
                
                [_tableView reloadData];
            }
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hideWithTabbar" object:nil];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
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
