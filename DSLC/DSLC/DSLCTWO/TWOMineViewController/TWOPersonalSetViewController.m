//
//  TWOPersonalSetViewController.m
//  DSLC
//
//  Created by ios on 16/5/13.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOPersonalSetViewController.h"
#import "TWOPersonalSetCell.h"
#import "TWOAddBankCardViewController.h"
#import "TWOAlreadyBankCardViewController.h"
#import "TWONoRealNameViewController.h"
#import "TWORealNameIngViewController.h"
#import "TWOPhoneNumViewController.h"
#import "TWOEmailViewController.h"
#import "TWOSafeSetViewController.h"
#import "TWOAboutDSLCViewController.h"
#import "TWOFinancialPlannerListViewController.h"
#import "TWOMyOwnerPlannerViewController.h"
#import "TWOMyClientViewController.h"

@interface TWOPersonalSetViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOPersonalSetViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"账户设置"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"TWOPersonalSetCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    
//    退出登录按钮
    UIButton *butExitLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(11, _tableView.tableFooterView.frame.size.height - 40 - 15, WIDTH_CONTROLLER_DEFAULT - 22, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"退出登录"];
    [_tableView.tableFooterView addSubview:butExitLogin];
    butExitLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butExitLogin.layer.cornerRadius = 5;
    butExitLogin.layer.masksToBounds = YES;
    [butExitLogin addTarget:self action:@selector(buttonExitLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        butExitLogin.frame = CGRectMake(11, _tableView.tableFooterView.frame.size.height - 40 - 15 - 25, WIDTH_CONTROLLER_DEFAULT - 22, 40);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOPersonalSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *titleArray = @[@[@"银行卡", @"实名认证", @"手机号", @"邮箱绑定", @"安全设置"], @[@"我的理财师", @"关于大圣理财"]];
    cell.labelTitle.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
    if (indexPath.section == 1) {
        cell.labelStates.hidden = YES;
        cell.imagePic.hidden = YES;
        
    } else {
        if (indexPath.row == 4) {
            cell.labelStates.hidden = YES;
            cell.imagePic.hidden = YES;
        } else {
            cell.labelStates.hidden = NO;
            cell.imagePic.hidden = YES;
            
            if (indexPath.row == 0) {
                cell.imagePic.hidden = NO;
                cell.labelStates.text = @"已绑定";
                cell.imagePic.image = [UIImage imageNamed:@"bangding"];
            } else if (indexPath.row == 1) {
                cell.imagePic.hidden = NO;
                cell.labelStates.text = @"已认证";
                cell.imagePic.image = [UIImage imageNamed:@"renzheng"];
            } else if (indexPath.row == 2) {
                cell.labelStates.text = @"159****2599";
            } else if (indexPath.row == 3) {
                cell.labelStates.text = @"1032865506@qq.com";
            }
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    } else {
        return 0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            添加银行卡页面
//            TWOAddBankCardViewController *addBankCardVC = [[TWOAddBankCardViewController alloc] init];
//            [self.navigationController pushViewController:addBankCardVC animated:YES];
            
//            已经绑卡页面
            TWOAlreadyBankCardViewController *alreadyBankCard = [[TWOAlreadyBankCardViewController alloc] init];
            [self.navigationController pushViewController:alreadyBankCard animated:YES];
            
        } else if (indexPath.row == 1) {
//            未实名认证页面
            TWONoRealNameViewController *noRealNameVC = [[TWONoRealNameViewController alloc] init];
            [self.navigationController pushViewController:noRealNameVC animated:YES];
            
//            已经实名认证页面
//            TWORealNameIngViewController *realNameIng = [[TWORealNameIngViewController alloc] init];
//            [self.navigationController pushViewController:realNameIng animated:YES];
            
        } else if (indexPath.row == 2) {
//            手机号
            TWOPhoneNumViewController *phoneNumVC = [[TWOPhoneNumViewController alloc] init];
            [self.navigationController pushViewController:phoneNumVC animated:YES];
            
        } else if (indexPath.row == 3) {
            
//            邮箱绑定
            TWOEmailViewController *emailVC = [[TWOEmailViewController alloc] init];
            [self.navigationController pushViewController:emailVC animated:YES];
            
        } else {
            
//            安全设置
            TWOSafeSetViewController *safeSetVC = [[TWOSafeSetViewController alloc] init];
            [self.navigationController pushViewController:safeSetVC animated:YES];
        }
    } else {
        if (indexPath.row == 0) {
//            我的理财师
//            TWOMyOwnerPlannerViewController *myOwnerPlanner = [[TWOMyOwnerPlannerViewController alloc] init];
//            pushVC(myOwnerPlanner);
            
//            理财师列表页
//            TWOFinancialPlannerListViewController *financialPlannerVC = [[TWOFinancialPlannerListViewController alloc] init];
//            pushVC(financialPlannerVC);
            
//            我的客户列表
            TWOMyClientViewController *myClientVC = [[TWOMyClientViewController alloc] init];
            pushVC(myClientVC);
        } else {
//            关于大圣理财
            TWOAboutDSLCViewController *aboutDSLC = [[TWOAboutDSLCViewController alloc] init];
            [self.navigationController pushViewController:aboutDSLC animated:YES];
        }
    }
}

//退出登录按钮方法
- (void)buttonExitLoginClicked:(UIButton *)button
{
    NSLog(@"exit");
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
