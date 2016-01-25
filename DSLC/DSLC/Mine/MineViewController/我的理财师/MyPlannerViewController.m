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
#import "ChatViewController.h"
#import "Planner.h"

@interface MyPlannerViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UIView *viewHead;
    NSArray *titleArr;
    NSArray *monAndPeoArr;
    UIImageView *imageBottom;
    YYAnimatedImageView *imageHead;
    UIImageView *imageCrown;
    CGFloat height;
    UILabel *labelName;
    NSMutableArray *contentArr;
    Planner *planner;
    UIButton *butAlready;
    
    BOOL panduan;
    
    UILabel *labelAlert;
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
    contentArr = [NSMutableArray array];
    panduan = NO;
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnMineLeaf:)];
    [imageReturn addGestureRecognizer:tap];
    
    [self tableViewShow];
    [self getMyFinPlanner];
    
    [self.navigationItem setTitle:@"我的理财师"];
}

- (void)returnMineLeaf:(UIBarButtonItem *)bar
{
    if (panduan == YES) {
        
        NSArray *viewController = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
        
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)tableViewShow
{
    titleArr = @[@"邀请码", @"共为客户赚取金额", @"已服务客户人数", @"累计投资总额"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.showsVerticalScrollIndicator = NO;
    
    viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 215)];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor whiteColor];
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    _tableView.tableFooterView = viewFoot;
    
    labelAlert = [CreatView creatWithLabelFrame:CGRectMake(20, 10, WIDTH_CONTROLLER_DEFAULT - 40, 40) backgroundColor:[UIColor huibai] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"26年专职理财顾问,私人银行级的资产配置,为客户提供中立客观的真诚服务。"];
    [viewFoot addSubview:labelAlert];
    labelAlert.numberOfLines = 2;
    
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
    
    imageHead = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 40, 25, 80, 80)];
    imageHead.backgroundColor = Color_Clear;
    imageHead.layer.cornerRadius = 40;
    imageHead.layer.masksToBounds = YES;
    imageHead.layer.borderWidth = 0.5;
    imageHead.layer.borderColor = [[UIColor clearColor]CGColor];
    [imageBottom addSubview:imageHead];
    imageHead.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    imageCrown = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 18, 25, WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (15.0 / 375.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"huangguan"]];
    [imageBottom addSubview:imageCrown];
    imageCrown.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    labelName = [CreatView creatWithLabelFrame:CGRectMake(0, 115, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [imageBottom addSubview:labelName];
    labelName.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    UIButton *buttonAsk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (26.0 / 375.0), 156, WIDTH_CONTROLLER_DEFAULT * (136.0 / 375.0), 37) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"咨询"];
    [imageBottom addSubview:buttonAsk];
    buttonAsk.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    buttonAsk.layer.cornerRadius = 4;
    buttonAsk.layer.masksToBounds = YES;
    buttonAsk.layer.borderWidth = 0.5;
    buttonAsk.layer.borderColor = [[UIColor whiteColor] CGColor];
    [buttonAsk addTarget:self action:@selector(askQuestionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    butAlready = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (213.0 / 375.0), 156, WIDTH_CONTROLLER_DEFAULT * (136.0 / 375.0), 37) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"申请服务"];
    [imageBottom addSubview:butAlready];
    butAlready.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butAlready.layer.cornerRadius = 4;
    butAlready.layer.masksToBounds = YES;
    butAlready.layer.borderWidth = 0.5;
    butAlready.layer.borderColor = [[UIColor whiteColor] CGColor];
    [butAlready addTarget:self action:@selector(alreadyApplyForButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    if (self.design == 1) {
       
        cell.moneyAndPeople.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        cell.moneyAndPeople.textAlignment = NSTextAlignmentRight;
        labelName.text = [DES3Util decrypt:planner.userRealname];
        if (planner.avatarImg == nil || [planner.avatarImg isEqualToString:@""]) {
            imageHead.image = [UIImage imageNamed:@"默认头像"];
        } else {
            imageHead.yy_imageURL = [NSURL URLWithString:planner.avatarImg];
        }
        
        if (indexPath.row == 1) {
            cell.moneyAndPeople.textColor = [UIColor daohanglan];
            cell.moneyAndPeople.text = [NSString stringWithFormat:@"%@%@", [DES3Util decrypt:planner.earnMoney], @"元"];
            
        } else if (indexPath.row == 0) {
            cell.moneyAndPeople.text = planner.inviteCode;
            
        } else if (indexPath.row == 2) {
            cell.moneyAndPeople.text = [NSString stringWithFormat:@"%@%@", planner.serveCount, @"人"];
            
        } else {
            cell.moneyAndPeople.text = [NSString stringWithFormat:@"%@%@", planner.totalAmount, @"元"];
        }
        
    } else {
        
        cell.moneyAndPeople.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        cell.moneyAndPeople.textAlignment = NSTextAlignmentRight;
        labelName.text = planner.userRealname;

        if (planner.avatarImg == nil || [planner.avatarImg isEqualToString:@""]) {
            imageHead.image = [UIImage imageNamed:@"默认头像"];
        } else {
            imageHead.yy_imageURL = [NSURL URLWithString:planner.avatarImg];
        }

        
        if (indexPath.row == 1) {
            cell.moneyAndPeople.textColor = [UIColor daohanglan];
            cell.moneyAndPeople.text = [NSString stringWithFormat:@"%@%@", planner.totalProfit, @"元"];
            
        } else if (indexPath.row == 0) {
            cell.moneyAndPeople.text = planner.inviteCode;
            
        } else if (indexPath.row == 2) {
            cell.moneyAndPeople.text = [NSString stringWithFormat:@"%@%@", planner.serCount, @"人"];
            
        } else {
            cell.moneyAndPeople.text = [NSString stringWithFormat:@"%@%@", planner.totalAmount, @"元"];
        }
        
    }
    
    
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
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.IId = planner.ID;
    chatVC.chatName = planner.userRealname;
    chatVC.userORplanner = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
}

//申请理财师服务按钮
- (void)alreadyApplyForButton:(UIButton *)button
{
    NSLog(@"已经申请服务");
    
    NSDictionary *parmeter = @{@"finUserId":planner.ID};
    NSLog(@"-------%@", planner.ID);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/applyFinanciers" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"vvvvvvvvvvv%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [butAlready setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            panduan = YES;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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
- (void)getMyFinPlanner
{
    if (self.design == 1) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        NSDictionary *parmeter = @{@"token":[dic objectForKey:@"token"]};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyFinPlanner" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"^^^^^^^^^%@", responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                
                NSDictionary *dataDic = [responseObject objectForKey:@"User"];
                planner = [[Planner alloc] init];
                [planner setValuesForKeysWithDictionary:dataDic];
                
                [self viewHeadShow];
                [butAlready setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
                butAlready.enabled = NO;
                
                labelAlert.text = [planner resume];
                
            } else {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            }
            
            [_tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    } else {
        
        NSDictionary *parameter = @{@"fpId":self.IDStr};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/index/getIndexFinPlannerInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"我的理财师:%@",responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                
                planner = [[Planner alloc] init];
                NSDictionary *dataDic = [responseObject objectForKey:@"User"];
                [planner setValuesForKeysWithDictionary:dataDic];
                [contentArr addObject:planner];
                
                [self viewHeadShow];
                
                labelAlert.text = [planner resume];
                
                NSLog(@"mmmmmmm%@", contentArr);
            } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                    [FileOfManage createWithFile:@"isLogin.plist"];
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                    [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                } else {
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                    [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"hideWithTabbar" object:nil];
                [self.navigationController popToRootViewControllerAnimated:NO];
                return ;
            }
            
            [_tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"jjjjjj%@", error);
            
        }];
        
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
