//
//  UserListViewController.m
//  DSLC
//
//  Created by ios on 15/12/25.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "UserListViewController.h"
#import "UserListCell.h"
#import "ChatViewController.h"
#import "UserList.h"

@interface UserListViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *userListArr;
    UIImageView *imageDian;
}

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"用户列表"];
    userListArr = [NSMutableArray array];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    
    [self getUserList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shifouYouDian:) name:@"dian" object:nil];
}

- (void)shifouYouDian:(NSNotification *)notice
{
    [userListArr removeAllObjects];
    userListArr = [NSMutableArray array];
    [self getUserList];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
    [_tableView registerNib:[UINib nibWithNibName:@"UserListCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return userListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    UserList *userlist = [userListArr objectAtIndex:indexPath.section];
    
    if ([[userlist.msgStatus description] isEqualToString:@"1"]) {
        cell.imageDian.image = [UIImage imageNamed:@""];
    } else {
        cell.imageDian.image = [UIImage imageNamed:@"reddian"];
    }
    
    cell.imageDian.tag = 590;
    cell.imageHead.layer.cornerRadius = cell.imageHead.frame.size.width/2;
    cell.imageHead.layer.masksToBounds = YES;
    
    if ([[dic objectForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%@",userlist.sendUserId]]) {
        
        cell.labelName.text = userlist.recUserName;
        if (userlist.recAvatarImg == nil || [userlist.recAvatarImg isEqualToString:@""]) {
            cell.imageHead.image = [UIImage imageNamed:@"组-4-拷贝"];
        } else {
            cell.imageHead.yy_imageURL = [NSURL URLWithString:userlist.recAvatarImg];
        }
        
    } else {
        
        cell.labelName.text = userlist.sendUserName;
        if (userlist.sendAvatarImg == nil || [userlist.sendAvatarImg isEqualToString:@""]) {
            cell.imageHead.image = [UIImage imageNamed:@"组-4-拷贝"];
        } else {
            cell.imageHead.yy_imageURL = [NSURL URLWithString:userlist.sendAvatarImg];
        }

        cell.imageHead.yy_imageURL = [NSURL URLWithString:userlist.sendAvatarImg];
    }
    
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelContent.text = userlist.msgText;
    cell.labelContent.textColor = [UIColor zitihui];
    cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    cell.labelTime.text = userlist.sendTime;
    cell.labelTime.textColor = [UIColor zitihui];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    UserList *userlist = [userListArr objectAtIndex:indexPath.section];
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.userORplanner = NO;
    chatVC.chatName = userlist.recUserName;
    if ([[dic objectForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%@",userlist.sendUserId]]) {
        chatVC.IId = userlist.recUserId;
        
    } else {
        chatVC.IId = userlist.sendUserId;
    }
    NSLog(@"qqqqqqqqqqq%@", userlist.recUserId);
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------------------------------------------------------------------
- (void)getUserList
{
    NSLog(@"6666666666");
    NSDictionary *parameter = @{@"msgType":@0};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/getUserMsgList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        NSLog(@"走过");
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]){
            
            [self loadingWithHidden:YES];
            NSLog(@"走过1");
            NSLog(@"用户列表:::::::::::::%@", responseObject);
            NSMutableArray *dataArr = [responseObject objectForKey:@"Msg"];
            if (dataArr.count == 0) {
                NSLog(@"走过2");
                [self noDateWithView:@"暂无用户" height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20)/2 view:self.view];
                _tableView.hidden = YES;
                
            } else {
                [self noDataViewWithRemoveToView];
                _tableView.hidden = NO;
                NSLog(@"走过3");
                
                for (NSDictionary *dataDic in dataArr) {
                    UserList *userList = [[UserList alloc] init];
                    [userList setValuesForKeysWithDictionary:dataDic];
                    [userListArr addObject:userList];
                }
                [self tableViewShow];
            }
        } else {
            NSLog(@"%@",[responseObject objectForKey:@"resultMsg"]);
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
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
