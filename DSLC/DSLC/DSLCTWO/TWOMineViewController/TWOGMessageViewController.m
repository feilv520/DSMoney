//
//  TWOGMessageViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOGMessageViewController.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "AppDelegate.h"
#import "TWOMessageModel.h"
#import "TWOGetNoticeCell.h"
#import "TWONoticeDetailViewController.h"

@interface TWOGMessageViewController ()<UITableViewDataSource, UITableViewDelegate> {

    UITableView *mainTableView;
    NSMutableArray *messageArray;
    BOOL flag;
    
    BOOL flagSate;
    BOOL newFlag;
    NSInteger pageNumber;
    MJRefreshBackGifFooter *gifFooter;
    MJRefreshGifHeader *gifHeader;
    UIImageView *imageNothing;
}

@end

@implementation TWOGMessageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    
    flag = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor huibai];
    
    messageArray = [NSMutableArray array];
    pageNumber = 1;
    flagSate = NO;
    newFlag = NO;
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self getMessageDataList];
}

- (void)tableViewShow
{
    if (mainTableView == nil) {
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    }
    [self.view addSubview:mainTableView];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.backgroundColor = [UIColor qianhuise];
    mainTableView.separatorColor = [UIColor clearColor];
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    mainTableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    
    [mainTableView registerNib:[UINib nibWithNibName:@"TWOGetNoticeCell" bundle:nil] forCellReuseIdentifier:@"message"];
    
    [self addTableViewWithHeader:mainTableView];
    [self addTableViewWithFooter:mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TWOGetNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    TWOMessageModel *messageModel = [messageArray objectAtIndex:indexPath.row];
    
    cell.viewBottom.layer.masksToBounds = YES;
    cell.viewBottom.layer.cornerRadius = 5.0f;
    cell.viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    cell.viewBottom.layer.borderWidth = 1;
    
    cell.labelTitle.text = [messageModel title];
    cell.labelContent.text = [messageModel content];
    cell.labelContent.numberOfLines = 0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor qianhuise];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TWOMessageModel *messageModel = [messageArray objectAtIndex:indexPath.row];
    
    TWONoticeDetailViewController *messageDVC = [[TWONoticeDetailViewController alloc] init];
    messageDVC.messageID = [messageModel ID];
    pushVC(messageDVC);
}

#pragma mark message--------------------------------++++++++++++++++++++++++++++++++++++++++++++++++++++++++
- (void)getMessageDataList
{
    NSDictionary *parmeter = @{@"type":@1, @"curPage":[NSString stringWithFormat:@"%ld", (long)pageNumber], @"pageSize": @10};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"notice/getNoticeList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"公告!!!!!!!!!!%@", responseObject);
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            if (gifHeader.state == MJRefreshStateRefreshing) {
                [messageArray removeAllObjects];
                messageArray = nil;
                messageArray = [NSMutableArray array];
            }
            
            NSMutableArray *dataArray = [responseObject objectForKey:@"noticeInfo"];
            for (NSDictionary *dataDic in dataArray) {
                TWOMessageModel *messageModel = [[TWOMessageModel alloc] init];
                [messageModel setValuesForKeysWithDictionary:dataDic];
                [messageArray addObject:messageModel];
            }
            
            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                flagSate = YES;
                NSLog(@"全部数据");
            } else {
                flagSate = NO;
            }
            
            [gifFooter endRefreshing];
            [gifHeader endRefreshing];
            
            if (pageNumber == 1) {
                
                if (dataArray.count == 0) {
                    [self noDataShow];
                } else {
                    if (mainTableView == nil) {
                        
                        [self tableViewShow];
                    } else {
                        
                        [mainTableView reloadData];
                    }
                }
            } else {
                [mainTableView reloadData];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"%@", error);
    }];
}

- (void)noDataShow
{
    if (imageNothing == nil) {
        imageNothing = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    }
    [self.view addSubview:imageNothing];
}

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer
{
    gifFooter = footer;
    if (flagSate) {
        [gifFooter endRefreshing];
    } else {
        pageNumber++;
        [self getMessageDataList];
    }
}

- (void)loadNewData:(MJRefreshGifHeader *)header
{
    gifHeader = header;

    pageNumber = 1;
    [self getMessageDataList];
    
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
