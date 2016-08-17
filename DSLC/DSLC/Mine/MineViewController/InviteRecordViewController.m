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
    MJRefreshGifHeader *headerT;
    BOOL moreFlag;
    BOOL newFlag;
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
    newFlag = NO;
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT / 2 - 60];
    
    [self getRecordData];
}

- (void)noHaveInviteRecord
{
    UIImageView *imageViewNo = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageViewNo];
}

- (void)tabelViewShow
{
    if (_tabelView == nil) {
        
        _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
        _tabelView.dataSource = self;
        _tabelView.delegate = self;
        _tabelView.backgroundColor = [UIColor qianhuise];
        _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
        [_tabelView registerNib:[UINib nibWithNibName:@"InviteRecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
        
        [self addTableViewWithHeader:_tabelView];
        [self addTableViewWithFooter:_tabelView];
    }
    [self.view addSubview:_tabelView];
    
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
        
        cell.contentView.backgroundColor = [UIColor colorFromHexCode:@"e9f4fd"];
        cell.labelPhoneNum.backgroundColor = [UIColor colorFromHexCode:@"e9f4fd"];
        cell.labelRealName.backgroundColor = [UIColor colorFromHexCode:@"e9f4fd"];
        cell.labelMoney.backgroundColor = [UIColor colorFromHexCode:@"e9f4fd"];
        cell.labelTime.backgroundColor = [UIColor colorFromHexCode:@"e9f4fd"];
        
        cell.separatorInset = UIEdgeInsetsMake(0, WIDTH_CONTROLLER_DEFAULT, 0, 0);
        
        cell.labelPhoneNum.text = @"手机号";
        cell.labelRealName.text = @"实名认证";
        cell.labelMoney.text = @"投资";
        cell.labelTime.text = @"注册时间";
        
        cell.labelPhoneNum.textColor = [UIColor blackZiTi];
        cell.labelRealName.textColor = [UIColor blackZiTi];
        cell.labelMoney.textColor = [UIColor blackZiTi];
        cell.labelTime.textColor = [UIColor blackZiTi];
        
    } else {
        
        cell.contentView.backgroundColor = Color_White;
        cell.labelPhoneNum.backgroundColor = Color_White;
        cell.labelRealName.backgroundColor = Color_White;
        cell.labelMoney.backgroundColor = Color_White;
        cell.labelTime.backgroundColor = Color_White;
        
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        InviteRecordModel *inviteModel = [contentArr objectAtIndex:indexPath.row - 1];
        cell.labelPhoneNum.text = inviteModel.userPhone;
        cell.labelTime.text = inviteModel.inviteTime;
        
        cell.labelPhoneNum.textColor = [UIColor ZiTiColor];
        cell.labelRealName.textColor = [UIColor ZiTiColor];
        cell.labelMoney.textColor = [UIColor ZiTiColor];
        cell.labelTime.textColor = [UIColor ZiTiColor];
        
        if ([[inviteModel.realNameStatus description] isEqualToString:@"2"]) {
            cell.labelRealName.text = @"是";
        } else {
            cell.labelRealName.text = @"否";
        }
        
        if ([[inviteModel.isInvest description] isEqualToString:@"0"]) {
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
     NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"], @"curPage":[NSNumber numberWithInteger:curruntPage], @"invitationMyCode":[self.flagDic objectForKey:@"invitationMyCode"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"invite/getMyInviteList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"邀请记录:========&&&=======%@", responseObject);
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *userArray = [responseObject objectForKey:@"User"];
            
            if (userArray.count == 0) {
                
                [self noHaveInviteRecord];
            } else {
                
                for (dataDic in userArray) {
                    
                    InviteRecordModel *recordModel = [[InviteRecordModel alloc] init];
                    [recordModel setValuesForKeysWithDictionary:dataDic];
                    [contentArr addObject:recordModel];
                }
                
                if (curruntPage == 1) {
                    if (_tabelView == nil) {

                        [self tabelViewShow];
                    } else {
                        
                        [_tabelView reloadData];
                    }
                } else {
                    
                    [_tabelView reloadData];
                }
                
                if ([[responseObject objectForKey:@"currPage"] isEqualToNumber:[responseObject objectForKey:@"totalPage"]]) {
                    moreFlag = YES;
                } else {
                    moreFlag = NO;
                }
                
                if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:@"1"]) {
                    newFlag = YES;
                } else {
                    newFlag = NO;
                }
                
                [reFooter endRefreshing];
                [headerT endRefreshing];
            }
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//上拉加载
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

//下拉刷新
- (void)loadNewData:(MJRefreshGifHeader *)header
{
    headerT = header;
    
    if (newFlag) {
        
        [header endRefreshing];
    } else {
        
        if (contentArr != nil) {
            [contentArr removeAllObjects];
            contentArr = nil;
            contentArr = [NSMutableArray array];
        }
        
        curruntPage = 1;
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
