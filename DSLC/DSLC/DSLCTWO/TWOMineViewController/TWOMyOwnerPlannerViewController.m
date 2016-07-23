//
//  TWOMyOwnerPlannerViewController.m
//  DSLC
//
//  Created by ios on 16/5/30.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyOwnerPlannerViewController.h"
#import "MyPlannerCell.h"
#import "TWOMyOwnerPlannerCell.h"
#import "TWOMyOwnerModel.h"
#import "ChatViewController.h"

@interface TWOMyOwnerPlannerViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSDictionary *dataDic;
    NSDictionary *tempDic;
    UIButton *buttonAlready;
    UIImageView *imageHead;
    UILabel *labelName;
    UILabel *labelAlert;
    BOOL stateOr;
    NSString *idString;
}

@end

@implementation TWOMyOwnerPlannerViewController

//重写导航栏返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    if (stateOr == YES) {
        NSArray *viewControllers = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[viewControllers objectAtIndex:1] animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的理财师"];
    stateOr = NO;
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    
    if (self.stateShow == YES) {
        [self getMyOwnerData];
    } else {
        [self getListDetailData];
    }
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [UIView new];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 280.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    } else {
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 266.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];    }
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMyOwnerPlannerCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
    UIImageView *imageBackground = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageBackground];
    imageBackground.userInteractionEnabled = YES;
    
    imageHead = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 48.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 15.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 96.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 96.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"two默认头像"]];
    [imageBackground addSubview:imageHead];
    imageHead.layer.cornerRadius = imageHead.frame.size.height/2;
    imageHead.layer.masksToBounds = YES;
    imageHead.layer.borderColor = [[UIColor whiteColor] CGColor];
    imageHead.layer.borderWidth = 1;
    
    CGFloat imageJianJu = 15.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    CGFloat imageNameJainJu = 7.0;
    CGFloat buttonNameJianJu = 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    
    labelName = [CreatView creatWithLabelFrame:CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu, WIDTH_CONTROLLER_DEFAULT, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:nil];
    [imageBackground addSubview:labelName];
    
    CGFloat butWidth = (WIDTH_CONTROLLER_DEFAULT - 55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT * 2 - 65.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2;
    
    UIButton *buttonAsk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu, butWidth, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"咨询"];
    [imageBackground addSubview:buttonAsk];
    buttonAsk.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonAsk.layer.cornerRadius = 6;
    buttonAsk.layer.masksToBounds = YES;
    buttonAsk.layer.borderColor = [[UIColor whiteColor] CGColor];
    buttonAsk.layer.borderWidth = 1;
    [buttonAsk addTarget:self action:@selector(askQuestionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonAlready = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + buttonAsk.frame.size.width + 65.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu, butWidth, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:nil];
    [imageBackground addSubview:buttonAlready];
    buttonAlready.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonAlready.layer.cornerRadius = 6;
    buttonAlready.layer.masksToBounds = YES;
    buttonAlready.layer.borderColor = [[UIColor whiteColor] CGColor];
    buttonAlready.layer.borderWidth = 1;
    if (self.stateShow == YES) {
        [buttonAlready setTitle:@"已申请服务" forState:UIControlStateNormal];
    } else {
        [buttonAlready setTitle:@"申请服务" forState:UIControlStateNormal];
    }
    [buttonAlready addTarget:self action:@selector(applyMoneyTeacherButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat alertButtonJianJu = 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu + 35 + alertButtonJianJu, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [imageBackground addSubview:labelAlert];
    labelAlert.numberOfLines = 0;
    
//    判断是首页理财师数据还是我的理财师数据
    if (self.stateShow == YES) {
        
        if ([[tempDic objectForKey:@"avatarImg"] isEqualToString:@""] || [tempDic objectForKey:@"avatarImg"]  == nil) {
            imageHead.image = [UIImage imageNamed:@"two默认头像"];
        } else {
            imageHead.yy_imageURL = [NSURL URLWithString:[tempDic objectForKey:@"avatarImg"]];
        }
        labelName.text = [DES3Util decrypt:[tempDic objectForKey:@"userRealname"]];
        labelAlert.text = [tempDic objectForKey:@"resume"];
        
    } else {
        
        if ([[self.listModel avatarImg] isEqualToString:@""] || [self.listModel avatarImg] == nil) {
            imageHead.image = [UIImage imageNamed:@"two默认头像"];
        } else {
            imageHead.yy_imageURL = [NSURL URLWithString:[self.listModel avatarImg]];
        }
        labelName.text = [self.listModel userRealname];
        labelAlert.text = [self.listModel resume];
    }
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        
        buttonAsk.frame = CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butWidth, 30);
        
        buttonAlready.frame = CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + buttonAsk.frame.size.width + 65.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butWidth, 30);
        
        labelAlert.frame = CGRectMake(0, 0 + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30 + alertButtonJianJu, WIDTH_CONTROLLER_DEFAULT, 40);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        
        labelAlert.frame = CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu + 35 + 10, WIDTH_CONTROLLER_DEFAULT, 40);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        
        labelAlert.frame = CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu + 35 + alertButtonJianJu + 5, WIDTH_CONTROLLER_DEFAULT, 40);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMyOwnerPlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *titleArray = @[@"邀请码", @"已为客户赚取", @"已服务客户数", @"累计投资总额"];
    cell.labelTitle.text = [titleArray objectAtIndex:indexPath.row];
    
    if (self.stateShow == YES) {
        
        NSArray *contentArray = @[[tempDic objectForKey:@"inviteCode"], [NSString stringWithFormat:@"%@元", [DES3Util decrypt:[tempDic objectForKey:@"earnMoney"]]], [NSString stringWithFormat:@"%@", [tempDic objectForKey:@"serveCount"]], [NSString stringWithFormat:@"%@元", [tempDic objectForKey:@"totalAmount"]]];
        cell.labelContent.text = [contentArray objectAtIndex:indexPath.row];
        
    } else {
        
        NSArray *contentArray = @[[self.listModel inviteCode], [NSString stringWithFormat:@"%@元", [dataDic objectForKey:@"totalProfit"]], [NSString stringWithFormat:@"%@人", [dataDic objectForKey:@"serCount"]], [NSString stringWithFormat:@"%@元", [dataDic objectForKey:@"totalAmount"]]];
        cell.labelContent.text = [contentArray objectAtIndex:indexPath.row];
    }
    if (indexPath.row == 0) {
        cell.labelContent.textColor = [UIColor orangecolor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//申请按钮
- (void)applyMoneyTeacherButton:(UIButton *)button
{
    if (self.stateShow == YES) {
        
    } else {
        [self applyForData];
    }
}

//咨询按钮
- (void)askQuestionButtonClicked:(UIButton *)button
{
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    if (self.stateShow == YES) {
        chatVC.IId = idString;
    } else {
        chatVC.IId = [self.listModel ID];
    }
    pushVC(chatVC);
}

#pragma mark listDetail=====================================================
- (void)getListDetailData
{
    NSDictionary *parmeter = @{@"fpId":[self.listModel ID]};
    NSLog(@"%@", [self.listModel ID]);
    [[MyAfHTTPClient sharedClient] postWithURLString:@"front/getIndexFinPlannerInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"理财师详情::::::::::::::::::::%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            dataDic = [responseObject objectForKey:@"User"];
            [self tableViewShow];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark myOwner===================================
- (void)getMyOwnerData
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getMyFinPlanner" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"我的理财师详情-----------%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            tempDic = [responseObject objectForKey:@"User"];
            idString = [tempDic objectForKey:@"id"];
            NSLog(@"----^^^^^---%@", idString);
            [self tableViewShow];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark applyData=================================
- (void)applyForData
{
    NSDictionary *parmeter = @{@"finUserId":[self.listModel ID], @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/applyFinanciers" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"申请理财师>>>>>>>>>>>>>>>%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            [buttonAlready setTitle:@"已申请服务" forState:UIControlStateNormal];
            stateOr = YES;
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
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
