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
    imageDian = (UIImageView *)[self.view viewWithTag:590];
    imageDian.image = [UIImage imageNamed:@""];
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
    
    UserList *userlist = [userListArr objectAtIndex:indexPath.section];
    
    if ([userlist.recAvatarImg isEqualToString:@""]) {
        cell.imageHead.image = [UIImage imageNamed:@"组-4-拷贝"];
        
    } else {
        cell.imageHead.yy_imageURL = [NSURL URLWithString:userlist.recAvatarImg];
    }
    
    if ([[userlist.msgStatus description] isEqualToString:@"1"]) {
        cell.imageDian.image = [UIImage imageNamed:@"img_wd_buble_red"];
    } else {
        cell.imageDian.image = [UIImage imageNamed:@""];
    }
    
    cell.imageDian.tag = 590;
    cell.imageHead.layer.cornerRadius = cell.imageHead.frame.size.width/2;
    cell.imageHead.layer.masksToBounds = YES;
    
    cell.labelName.text = userlist.recUserName;
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
    UserList *userlist = [userListArr objectAtIndex:indexPath.section];
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.userORplanner = NO;
    chatVC.chatName = userlist.recUserName;
    chatVC.IId = userlist.recUserId;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dian" object:nil];
    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------------------------------------------------------------------
- (void)getUserList
{
    NSLog(@"6666666666");
    NSDictionary *parameter = @{@"msgType":@0};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/getUserMsgList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]){
            
            [self loadingWithHidden:YES];
            NSLog(@"用户列表:::::::::::::%@", responseObject);
            NSMutableArray *dataArr = [responseObject objectForKey:@"Msg"];
            if (dataArr.count == 0) {
                [self noDateWithView:@"暂无用户" height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20)/2 view:self.view];
                _tableView.hidden = YES;
                
            } else {
                [self noDataViewWithRemoveToView];
                _tableView.hidden = NO;
                
                for (NSDictionary *dataDic in dataArr) {
                    UserList *userList = [[UserList alloc] init];
                    [userList setValuesForKeysWithDictionary:dataDic];
                    [userListArr addObject:userList];
                }
                [self tableViewShow];
            }
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
