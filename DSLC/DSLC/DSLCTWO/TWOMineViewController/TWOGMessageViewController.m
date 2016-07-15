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
#import "TWOMessageTableViewCell.h"
#import "TWOMessageDetailViewController.h"

@interface TWOGMessageViewController ()<UITableViewDataSource, UITableViewDelegate> {

    UITableView *mainTableView;
    BOOL flag;
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
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self getMessageDataList];
}

- (void)tableViewShow
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:mainTableView];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.backgroundColor = [UIColor huibai];
    
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    mainTableView.tableFooterView.backgroundColor = [UIColor huibai];
    
//    [mainTableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [mainTableView setSeparatorColor:[UIColor huibai]];
    [mainTableView registerNib:[UINib nibWithNibName:@"TWOMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"message"];
    
    [self addTableViewWithHeader:mainTableView];
    [self addTableViewWithFooter:mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TWOMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    
    cell.titleLabel.text = @"喜大普奔,大圣理财APP2.0版本上线啦!";
    
    cell.subTitleLabel.text = @"经过小伙伴们两个月的努力,大圣理财2.0版本终于上线啦!大圣理财,专注银行信贷资产";
    
    cell.backgroundV.layer.masksToBounds = YES;
    cell.backgroundV.layer.cornerRadius = 5.0f;
    
    if (!flag) {
        
        cell.pointImage.hidden = YES;
        [cell.titleLabel setTextColor:[UIColor colorFromHexCode:@"8c909d"]];
    } else {
        
        cell.pointImage.hidden = NO;
        [cell.titleLabel setTextColor:[UIColor colorFromHexCode:@"434a54"]];
    }
    
    flag = !flag;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TWOMessageDetailViewController *messageDVC = [[TWOMessageDetailViewController alloc] init];
    pushVC(messageDVC);
}

#pragma mark message--------------------------------
- (void)getMessageDataList
{
    NSDictionary *parmeter = @{@"type":@1};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"notice/getNoticeList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"公告!!!!!!!!!!%@", responseObject);
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"noticeInfo"];
            for (NSDictionary *dataDic in dataArray) {
                
            }
            
            if (dataArray.count == 0) {
                [self noDataShow];
            } else {
                [self tableViewShow];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)noDataShow
{
    UIImageView *imageNothing = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageNothing];
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
