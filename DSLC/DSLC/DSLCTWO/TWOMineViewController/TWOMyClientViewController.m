//
//  TWOMyClientViewController.m
//  DSLC
//
//  Created by ios on 16/5/31.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyClientViewController.h"
#import "TWOMyClientCell.h"
#import "ChatViewController.h"
#import "UserList.h"

@interface TWOMyClientViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *userArray;
    
    MJRefreshBackGifFooter *gifFooter;
    BOOL flagState;
    NSInteger pageNumber;
}

@end

@implementation TWOMyClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的客户"];
    userArray = [NSMutableArray array];
    pageNumber = 1;
    flagState = NO;
    
    [self getDataList];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMyClientCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMyClientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    UserList *userModel = [userArray objectAtIndex:indexPath.row];
    
    if ([[[dic objectForKey:@"id"] description] isEqualToString:[[userModel sendUserId] description]]) {
        
        cell.labelName.text = [userModel recUserName];
        if ([[userModel recAvatarImg] isEqualToString:@""]) {
            cell.imageHead.image = [UIImage imageNamed:@"two默认头像"];
        } else {
            cell.imageHead.yy_imageURL = [NSURL URLWithString:[userModel recAvatarImg]];
        }
        
    } else {
        cell.labelName.text = [userModel sendUserName];
        if ([[userModel sendAvatarImg] isEqualToString:@""]) {
            cell.imageHead.image = [UIImage imageNamed:@"two默认头像"];
        } else {
            cell.imageHead.yy_imageURL = [NSURL URLWithString:[userModel sendAvatarImg]];
        }
    }
    
    cell.imageHead.layer.cornerRadius = cell.imageHead.frame.size.width/2;
    cell.imageHead.layer.masksToBounds = YES;
    cell.imageRight.image = [UIImage imageNamed:@"righticon"];
    cell.labelName.textColor = [UIColor profitColor];
    
    cell.labelPhone.text = [userModel userAccount];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    UserList *userModel = [userArray objectAtIndex:indexPath.row];
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    if ([[[dic objectForKey:@"id"] description] isEqualToString:[[userModel sendUserId] description]]){
        chatVC.IId = [userModel recUserId];
    } else {
        chatVC.IId = [userModel sendUserId];
    }
    NSLog(@"%@", [dic objectForKey:@"id"]);
    pushVC(chatVC);
}

#pragma mark dataList****************************************************
- (void)getDataList
{
    NSDictionary *parmeter = @{@"msgType":@0, @"token":[self.flagDic objectForKey:@"token"], @"curPage":[NSString stringWithFormat:@"%ld", (long)pageNumber]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"msg/getUserMsgList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"客户列表~~~~~~~~~~~~~:%@", responseObject);
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"Msg"];
            for (NSDictionary *dataDic in dataArray) {
                UserList *userModel = [[UserList alloc] init];
                [userModel setValuesForKeysWithDictionary:dataDic];
                [userArray addObject:userModel];
            }
            
            if (userArray.count == 0) {
                [self noDataList];
            } else {
                [self tableViewShow];
            }
            
            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                flagState = YES;
            }
            
            [gifFooter endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//下拉刷新
- (void)loadNewData:(MJRefreshGifHeader *)header
{
    if (userArray != nil) {
        [userArray removeAllObjects];
        userArray = nil;
        userArray = [NSMutableArray array];
    }
    
    pageNumber = 1;
    [self getDataList];
}

//上拉加载
- (void)loadMoreData:(MJRefreshBackGifFooter *)footer
{
    gifFooter = footer;
    if (flagState) {
        [gifFooter endRefreshing];
    } else {
        pageNumber++;
        [self getDataList];
    }
}

- (void)noDataList
{
    UIImageView *imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageMonkey];
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
