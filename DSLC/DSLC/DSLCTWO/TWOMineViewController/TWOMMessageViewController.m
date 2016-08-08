//
//  TWOMMessageViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMMessageViewController.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "AppDelegate.h"
#import "TWOMessageTableViewCell.h"
#import "TWONewsMessageModel.h"
#import "TWONewsMegDetailViewController.h"

@interface TWOMMessageViewController () <UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *mainTableView;
    NSMutableArray *newsArray;
    BOOL flag;
    MJRefreshBackGifFooter *gifFooter;
    MJRefreshGifHeader *gifHeader;
    BOOL flagSate;
    NSInteger pageNum;
    NSInteger oldPageNum;
    
    UIImageView *imageDian;
    UILabel *labelTitle;
}

@end

@implementation TWOMMessageViewController

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
    newsArray = [NSMutableArray array];
    
    flagSate = NO;
    pageNum = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMessageData) name:@"getMessageDataRefrush" object:nil];
    
    [self getMessageData];
}

- (void)tableViewShow
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:mainTableView];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.backgroundColor = [UIColor qianhuise];
    mainTableView.separatorColor = [UIColor clearColor];
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    mainTableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    
    [mainTableView registerNib:[UINib nibWithNibName:@"TWOMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"message"];
    
    [self addTableViewWithHeader:mainTableView];
    [self addTableViewWithFooter:mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    TWONewsMessageModel *newsModel = [newsArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [newsModel msgTitle];
    cell.titleLabel.tag = 123 + indexPath.row;
    
    cell.subTitleLabel.text = [newsModel msgText];
    cell.subTitleLabel.numberOfLines = 0;
    
    cell.backgroundV.layer.masksToBounds = YES;
    cell.backgroundV.layer.cornerRadius = 5.0f;
    cell.backgroundV.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    cell.backgroundV.layer.borderWidth = 1;
    
    cell.pointImage.hidden = YES;
    cell.pointImage.tag = 99999;
    
    //未读已读的判断
    if ([[[newsModel msgStatus] description] isEqualToString:@"0"]) {
        cell.pointImage.hidden = NO;
        cell.titleLabel.textColor = [UIColor ZiTiColor];
        NSLog(@"未读");
    } else {
        cell.pointImage.hidden = YES;
        cell.titleLabel.textColor = [UIColor findZiTiColor];
        NSLog(@"已读");
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    imageDian = (UIImageView *)[self.view viewWithTag:99999];
    labelTitle = (UILabel *)[self.view viewWithTag:123 + indexPath.row];
    
    imageDian.hidden = YES;
    labelTitle.textColor = [UIColor findZiTiColor];
    
    TWONewsMegDetailViewController *messageDVC = [[TWONewsMegDetailViewController alloc] init];
    TWONewsMessageModel *model = [newsArray objectAtIndex:indexPath.row];
    messageDVC.msgID = model.msgTextId;
    pushVC(messageDVC);
}

- (void)noDataShow
{
    UIImageView *imageNothing = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageNothing];
}

#pragma mark messageData=============================
- (void)getMessageData
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"], @"curPage":[NSString stringWithFormat:@"%ld", (long)pageNum]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"msg/getMessageList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"消息列表----------------%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            if (oldPageNum == pageNum) {
                if (newsArray != nil) {
                    [newsArray removeAllObjects];
                    newsArray = nil;
                    newsArray = [NSMutableArray array];
                }
            }
            
            NSMutableArray *dataArray = [responseObject objectForKey:@"message"];
            for (NSDictionary *dataDic in dataArray) {
                TWONewsMessageModel *newsMessageModel = [[TWONewsMessageModel alloc] init];
                [newsMessageModel setValuesForKeysWithDictionary:dataDic];
                [newsArray addObject:newsMessageModel];
            }
            
            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                flagSate = YES;
            }
            
            [gifFooter endRefreshing];
            [gifHeader endRefreshing];
            
            if (pageNum == 1) {
                if (newsArray.count == 0) {
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
            
            oldPageNum = pageNum;
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer
{
    gifFooter = footer;
    if (flagSate) {
        [gifFooter endRefreshing];
    } else {
        pageNum++;
        [self getMessageData];
    }
}

- (void)loadNewData:(MJRefreshGifHeader *)header
{
    gifHeader = header;
    
    if (newsArray != nil) {
        [newsArray removeAllObjects];
        newsArray = nil;
        newsArray = [NSMutableArray array];
    }
    
    pageNum = 1;
    [self getMessageData];
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
