//
//  TWOFindActivityCenterViewController.m
//  DSLC
//
//  Created by ios on 16/5/25.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOFindActivityCenterViewController.h"
#import "TWOFindActivityCenterCell.h"
#import "TWOActivityThreeStateModel.h"

@interface TWOFindActivityCenterViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UIScrollView *_scrollview;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;
    
    NSMutableArray *waitArray;
    NSMutableArray *runArray;
    NSMutableArray *overArray;
}

@end

@implementation TWOFindActivityCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"活动中心"];
    
    waitArray = [NSMutableArray array];
    runArray = [NSMutableArray array];
    overArray = [NSMutableArray array];
    
    [self contentShow];
    [self getListDataNo];
    [self getListDataAlready];
    [self getListDataAlreadyDown];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

- (void)contentShow
{
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    NSArray *nameArray = @[@"进行中", @"期待中", @"已结束"];
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:nameArray];
    segmented.frame = CGRectMake(9, 9, WIDTH_CONTROLLER_DEFAULT - 18, viewWhite.frame.size.height - 18);
    [viewWhite addSubview:segmented];
    segmented.selectedSegmentIndex = 0;
    segmented.tintColor = [UIColor profitColor];
    [segmented addTarget:self action:@selector(segmentedSelect:) forControlEvents:UIControlEventValueChanged];
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 55, WIDTH_CONTROLLER_DEFAULT * 3, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 55)];
    [self.view addSubview:_scrollview];
    _scrollview.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 3, 0);
}

//segment方法选择器
- (void)segmentedSelect:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
        }];
        
    } else if (seg.selectedSegmentIndex == 1) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
        } completion:^(BOOL finished) {
            
        }];

    } else {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT * 2, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

//进行中页面
- (void)tableViewShow1
{
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _scrollview.frame.size.height) style:UITableViewStylePlain];
    [_scrollview addSubview:_tableView1];
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    _tableView1.separatorColor = [UIColor clearColor];
    [_tableView1 registerNib:[UINib nibWithNibName:@"TWOFindActivityCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

//进行中无数据
- (void)runingNoData
{
    UIImageView *imageRuning = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 100, 260/2, 260/2) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [_scrollview addSubview:imageRuning];
}

//期待中页面
- (void)tableViewShow2
{
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, _scrollview.frame.size.height) style:UITableViewStylePlain];
    [_scrollview addSubview:_tableView2];
    _tableView2.dataSource = self;
    _tableView2.delegate = self;
    _tableView2.separatorColor = [UIColor clearColor];
    [_tableView2 registerNib:[UINib nibWithNibName:@"TWOFindActivityCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

//期待中无数据
- (void)waitingNoData
{
    UIImageView *imageRuning = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT + WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 100, 260/2, 260/2) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [_scrollview addSubview:imageRuning];
}

//已结束页面
- (void)tableViewShow3
{
    _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * 2, 0, WIDTH_CONTROLLER_DEFAULT, _scrollview.frame.size.height) style:UITableViewStylePlain];
    [_scrollview addSubview:_tableView3];
    _tableView3.dataSource = self;
    _tableView3.delegate = self;
    _tableView3.separatorColor = [UIColor clearColor];
    [_tableView3 registerNib:[UINib nibWithNibName:@"TWOFindActivityCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

//已结束无数据
- (void)overNoData
{
    UIImageView *imageRuning = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT*2 + WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 100, 260/2, 260/2) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [_scrollview addSubview:imageRuning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView1) {
        return runArray.count;
    } else if (tableView == _tableView2) {
        return waitArray.count;
    } else {
        return overArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOFindActivityCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.imageActivity.layer.cornerRadius = 4;
    cell.imageActivity.layer.masksToBounds = YES;
    
    if (tableView == _tableView1) {
        
        TWOActivityThreeStateModel *activityModel = [runArray objectAtIndex:indexPath.row];
        cell.imageActivity.yy_imageURL = [NSURL URLWithString:[activityModel poster]];
        cell.imageOver.hidden = YES;
        cell.imageWaiting.hidden = YES;
        cell.labelAlpha.hidden = YES;
        
    } else if (tableView == _tableView2) {
        
        TWOActivityThreeStateModel *activityModel = [waitArray objectAtIndex:indexPath.row];
        cell.imageActivity.yy_imageURL = [NSURL URLWithString:[activityModel poster]];
        cell.imageWaiting.hidden = NO;
        cell.imageOver.hidden = YES;
        cell.labelAlpha.hidden = YES;
        cell.imageWaiting.image = [UIImage imageNamed:@"期待中"];
        
    } else {
        
        TWOActivityThreeStateModel *activityModel = [overArray objectAtIndex:indexPath.row];
        cell.imageActivity.yy_imageURL = [NSURL URLWithString:[activityModel poster]];
        cell.imageWaiting.hidden = YES;
        cell.imageOver.hidden = NO;
        cell.labelAlpha.hidden = NO;
        cell.labelAlpha.backgroundColor = [UIColor blackColor];
        cell.labelAlpha.layer.cornerRadius = 4;
        cell.labelAlpha.layer.masksToBounds = YES;
        cell.labelAlpha.alpha = 0.4;
        cell.imageOver.image = [UIImage imageNamed:@"over"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark listData----------------------
//期待中接口
- (void)getListDataNo
{
    NSDictionary *parmeter1 = @{@"status":@1, @"clientType":@"iOS"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"activity/getActivityList" parameters:parmeter1 success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"期待中::::::::::::::%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *activityArr = [responseObject objectForKey:@"Activity"];
            for (NSDictionary *dataDic in activityArr) {
                TWOActivityThreeStateModel *model = [[TWOActivityThreeStateModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [waitArray addObject:model];
            }
            
            //有数据与无数据显示的判断
            if (waitArray.count == 0) {
                [self waitingNoData];
            } else {
                [self tableViewShow2];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//进行中接口
- (void)getListDataAlready
{
    NSDictionary *parmeter2 = @{@"status":@2, @"clientType":@"iOS"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"activity/getActivityList" parameters:parmeter2 success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"进行中::::::::::::::%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *activityArr = [responseObject objectForKey:@"Activity"];
            for (NSDictionary *dataDic in activityArr) {
                TWOActivityThreeStateModel *model = [[TWOActivityThreeStateModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [runArray addObject:model];
            }
            
            NSLog(@"aaaaaaaaaa%@", runArray);
            //有数据与无数据显示的判断
            if (runArray.count == 0) {
                [self runingNoData];
            } else {
                [self tableViewShow1];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//已下线接口
- (void)getListDataAlreadyDown
{
    NSDictionary *parmeter3 = @{@"status":@3, @"clientType":@"iOS"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"activity/getActivityList" parameters:parmeter3 success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"已下线::::::::::::::%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *activityArr = [responseObject objectForKey:@"Activity"];
            for (NSDictionary *dataDic in activityArr) {
                TWOActivityThreeStateModel *model = [[TWOActivityThreeStateModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [overArray addObject:model];
            }
            
            //有数据与无数据显示的判断
            if (overArray.count == 0) {
                [self overNoData];
            } else {
                [self tableViewShow3];
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
