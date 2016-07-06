//
//  TWOFinancialPlannerListViewController.m
//  DSLC
//
//  Created by ios on 16/5/30.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOFinancialPlannerListViewController.h"
#import "TWOFinancialPlannerCell.h"
#import "ChatViewController.h"
#import "TWOMoneyTeacherList.h"
#import "TWOMyOwnerPlannerViewController.h"

@interface TWOFinancialPlannerListViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
    NSMutableArray *listArray;
}

@end

@implementation TWOFinancialPlannerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的理财师"];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    listArray = [NSMutableArray array];
    
    [self getDataList];
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    _tabelView.backgroundColor = [UIColor qianhuise];
    [_tabelView registerNib:[UINib nibWithNibName:@"TWOFinancialPlannerCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tabelView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOFinancialPlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    TWOMoneyTeacherList *listModel = [listArray objectAtIndex:indexPath.row];
    
    cell.imageHead.yy_imageURL = [NSURL URLWithString:[listModel avatarImg]];
    cell.imageHead.layer.cornerRadius = cell.imageHead.frame.size.height/2;
    cell.imageHead.layer.masksToBounds = YES;
    cell.imageRight.image = [UIImage imageNamed:@"righticon"];
    
    cell.labelName.text = [listModel userRealname];
    cell.labelInviteCode.text = [NSString stringWithFormat:@"邀请码 %@", [listModel inviteCode]];
    cell.labelInviteCode.textColor = [UIColor profitColor]; //myhoutou
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TWOMyOwnerPlannerViewController *ownPlannerVC = [[TWOMyOwnerPlannerViewController alloc] init];
    ownPlannerVC.listModel = [listArray objectAtIndex:indexPath.row];
    ownPlannerVC.stateShow = NO;
    pushVC(ownPlannerVC);
}

#pragma mark Data--------------------------------
- (void)getDataList
{
    NSDictionary *parmeter = @{@"curPage":@1};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"front/getIndexFinPlannerList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"理财师列表:::::::::::%@", responseObject);
        [self loadingWithHidden:YES];
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"User"];
            for (NSDictionary *tempDic in dataArray) {
                TWOMoneyTeacherList *listModel = [[TWOMoneyTeacherList alloc] init];
                [listModel setValuesForKeysWithDictionary:tempDic];
                [listArray addObject:listModel];
            }

            [_tabelView reloadData];
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
