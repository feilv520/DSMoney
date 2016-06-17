//
//  InviteRecordViewController.m
//  DSLC
//
//  Created by ios on 16/4/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "InviteRecordViewController.h"
#import "InviteRecordCell.h"
#import "InviteRecordModel.h"

@interface InviteRecordViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
    NSMutableArray *contentArr;
    NSInteger curruntPage;
    NSDictionary *dataDic;
    MJRefreshBackGifFooter *reFooter;
    BOOL moreFlag;
}

@end

@implementation InviteRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"邀请记录"];
    contentArr = [NSMutableArray array];
    curruntPage = 1;
    moreFlag = NO;
    [self loadingWithView:self.view loadingFlag:NO height:(HEIGHT_CONTROLLER_DEFAULT - 20 - 64)/2];
    
    [self getRecordData];
}

- (void)noHaveInviteRecord
{
    UIImageView *imageViewNo = [CreatView creatImageViewWithFrame:CGRectMake(75, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 100 - 50, WIDTH_CONTROLLER_DEFAULT - 150, 200) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"NoRecord"]];
    [self.view addSubview:imageViewNo];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        imageViewNo.frame = CGRectMake(75, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 100 - 50, WIDTH_CONTROLLER_DEFAULT - 150, 200);
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
        
        imageViewNo.frame = CGRectMake(85, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 120 - 50, WIDTH_CONTROLLER_DEFAULT - 170, 240);
        
    } else {
        
        imageViewNo.frame = CGRectMake(95, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 140 - 50, WIDTH_CONTROLLER_DEFAULT - 190, 280);
    }
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 120 - 50 + imageViewNo.frame.size.height + 30, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"您还没有邀请过好友,快去邀请拿好礼吧!"];
    [self.view addSubview:labelAlert];
}

- (void)tabelViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor qianhuise];
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
    [_tabelView registerNib:[UINib nibWithNibName:@"InviteRecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [self addTableViewWithFooter:_tabelView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (indexPath.row == 0) {
        
        cell.labelPhoneNum.text = @"手机号";
        cell.labelRealName.text = @"实名认证";
        cell.labelMoney.text = @"投资";
        cell.labelTime.text = @"注册时间";
        
    } else {
        
        InviteRecordModel *inviteModel = [contentArr objectAtIndex:indexPath.row - 1];
        cell.labelPhoneNum.text = inviteModel.phone;
        cell.labelTime.text = inviteModel.inviteTime;
        
        if ([inviteModel.realNameStatus isEqualToString:@"2"]) {
            cell.labelRealName.text = @"是";
        } else {
            cell.labelRealName.text = @"否";
        }
        
        if ([inviteModel.isInvest isEqualToString:@"0"]) {
            cell.labelMoney.text = @"否";
        } else {
            cell.labelMoney.text = @"是";
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)getRecordData
{
     NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"], @"curPage":[NSNumber numberWithInteger:curruntPage], @"invitationMyCode":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"invite/getMyInviteList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"邀请记录:========&&&=======%@", responseObject);
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *userArray = [responseObject objectForKey:@"User"];
            
            if (userArray.count == 0 && contentArr.count == 0) {
                
                [self noHaveInviteRecord];
                
            } else {
                
                for (dataDic in userArray) {
                    
                    InviteRecordModel *recordModel = [[InviteRecordModel alloc] init];
                    [recordModel setValuesForKeysWithDictionary:dataDic];
                    [contentArr addObject:recordModel];
                }
                
                if (curruntPage == 1) {
                    [self tabelViewShow];
                } else {
                    [_tabelView reloadData];
                }
                
                if ([[responseObject objectForKey:@"curPage"] isEqualToNumber:[responseObject objectForKey:@"totalPage"]]) {
                    moreFlag = YES;
                }
                
                [reFooter endRefreshing];
            }
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer
{
    reFooter = footer;
    
    if (moreFlag) {
        // 拿到当前的上拉刷新控件，结束刷新状态
        [footer endRefreshing];
    } else {
        curruntPage ++;
        [self getRecordData];
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
