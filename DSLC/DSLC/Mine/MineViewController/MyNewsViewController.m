//
//  MyNewsViewController.m
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyNewsViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "MyNewsCell.h"
#import "MessageDetailViewController.h"
#import "MessageModel.h"

@interface MyNewsViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *picArr;
}

@property (nonatomic, strong) NSMutableArray *msgArr;

@end

@implementation MyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.msgArr = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getDataList];
    
    [self.navigationItem setTitle:@"消息中心"];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    _tableView.hidden = YES;
    
}

- (void)tableViewShow
{
    picArr = [NSMutableArray arrayWithObjects:@"icon04@2x", @"icon05@2x", @"icon04@2x", @"icon05@2x", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.backgroundColor = [UIColor huibai ];
    [_tableView registerNib:[UINib nibWithNibName:@"MyNewsCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [picArr removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    MessageModel *mModel = [self.msgArr objectAtIndex:indexPath.row];
    
    cell.labelPrize.text = [mModel msgTitle];
    cell.labelPrize.font = [UIFont systemFontOfSize:15];
    
    cell.labelTime.text = [mModel sendTime];
    cell.labelTime.textColor = [UIColor zitihui];
    cell.labelTime.font = [UIFont systemFontOfSize:12];
    
    if ([[mModel msgType] isEqualToString:@"0"]) {
        cell.imageLeft.image = [UIImage imageNamed:@"icon04"];
    } else {
        cell.imageLeft.image = [UIImage imageNamed:@"icon05"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageDetailViewController *messageDetailVC = [[MessageDetailViewController alloc] init];

    messageDetailVC.idString = [[self.msgArr objectAtIndex:indexPath.row] msgTextId];

    [self.navigationController pushViewController:messageDetailVC animated:YES];
    
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

//获取消息列表
- (void)getDataList
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"recUserId":[dic objectForKey:@"id"], @"msgType":@1, @"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/getMsgList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"消息中心......%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        }
        
        [self loadingWithHidden:YES];
        if ([[responseObject objectForKey:@"Msg"] count] == 0) {
            [self noDateWithHeight:HEIGHT_CONTROLLER_DEFAULT/2 - 80 view:self.view];
            
        } else {
        
            _tableView.hidden = NO;
            for (NSDictionary *dic in [responseObject objectForKey:@"Msg"]) {
                MessageModel *messageM = [[MessageModel alloc] init];
                [messageM setValuesForKeysWithDictionary:dic];
                [self.msgArr addObject:messageM];
            }
        
            [self tableViewShow];
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
