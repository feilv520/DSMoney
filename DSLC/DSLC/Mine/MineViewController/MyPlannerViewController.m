//
//  MyPlannerViewController.m
//  DSLC
//
//  Created by ios on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyPlannerViewController.h"
#import "define.h"
#import "MyPlannerCell.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"

@interface MyPlannerViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UIView *viewHead;
    NSArray *titleArr;
    NSArray *monAndPeoArr;
    UIImageView *imageBottom;
    UIImageView *imageHead;
    UIImageView *imageCrown;
    CGFloat height;
}

@end

@implementation MyPlannerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getMyFinPlanner];
    
    [self.navigationItem setTitle:@"我的理财师"];
    [self tableViewShow];
}

- (void)tableViewShow
{
    titleArr = @[@[@"共为客户赚取金额"], @[@"以服务客户人数"]];
    monAndPeoArr = @[@[@"3,803.00元"], @[@"237,438人"]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    
    viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 215)];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor whiteColor];
    [self viewHeadShow];
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView = viewFoot;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyPlannerCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

//tableViewHead内容
- (void)viewHeadShow
{
    imageBottom = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 215) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"9c1ccc47da95fed87b249e2557a28dbef422aec3edee-qv7sue_fw658-拷贝"]];
    [viewHead addSubview:imageBottom];
    imageBottom.userInteractionEnabled = YES;
    height = imageBottom.frame.size.height;
//    让子类自动布局
    imageBottom.autoresizesSubviews = YES;
    
    imageHead = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (144.0 / 375.0), 29, WIDTH_CONTROLLER_DEFAULT * (87.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (87.0 / 375.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"b17a045a80e620259fbb8f4f444393812bfc129c1ec3d-23eoii_fw658"]];
    [imageBottom addSubview:imageHead];
    imageHead.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    imageCrown = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (65.0 / 375.0), 0, WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (15.0 / 375.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"huangguan"]];
    [imageHead addSubview:imageCrown];
    imageCrown.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    UIButton *buttonAsk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (26.0 / 375.0), 156, WIDTH_CONTROLLER_DEFAULT * (136.0 / 375.0), 37) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"咨询"];
    [imageBottom addSubview:buttonAsk];
    buttonAsk.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    buttonAsk.layer.cornerRadius = 4;
    buttonAsk.layer.masksToBounds = YES;
    buttonAsk.layer.borderWidth = 0.5;
    buttonAsk.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonAsk addTarget:self action:@selector(askQuestionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butAlready = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (213.0 / 375.0), 156, WIDTH_CONTROLLER_DEFAULT * (136.0 / 375.0), 37) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"已申请服务"];
    [imageBottom addSubview:butAlready];
    [butAlready setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
    butAlready.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butAlready.layer.cornerRadius = 4;
    butAlready.layer.masksToBounds = YES;
    butAlready.layer.borderWidth = 0.5;
    butAlready.layer.borderColor = [[UIColor whiteColor] CGColor];
    [butAlready addTarget:self action:@selector(alreadyApplyForButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return HEIGHT_CONTROLLER_DEFAULT * (7.0 / 667.0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[MyPlannerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelTitle.text = [[titleArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.moneyAndPeople.text = [[monAndPeoArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.moneyAndPeople.textAlignment = NSTextAlignmentRight;
    
    if (indexPath.section == 0) {
        
        cell.moneyAndPeople.textColor = [UIColor daohanglan];
        
    } else {
        
        cell.moneyAndPeople.textColor = [UIColor zitihui];
        cell.labelLine.hidden = YES;
    }
    
    cell.labelLine.backgroundColor = [UIColor grayColor];
    cell.labelLine.alpha = 0.2;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSet = scrollView.contentOffset.y;
    
    if (offSet < 0) {
        
        imageBottom.contentMode = UIViewContentModeScaleAspectFill;
        CGRect frame = imageBottom.frame;
        frame.origin.y = offSet;
        frame.size.height = height - offSet;
        imageBottom.frame = frame;
    }
}
    
//咨询按钮
- (void)askQuestionButton:(UIButton *)button
{
    NSLog(@"咨询");
}

//已经申请服务按钮
- (void)alreadyApplyForButton:(UIButton *)button
{
    NSLog(@"已经申请服务");
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyFinPlanner{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"invitationCode":@"dIWCQa",@"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyFinPlanner" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
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
