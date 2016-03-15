//
//  MoreViewController.m
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MoreViewController.h"
#import "CreatView.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "MoreCell.h"
#import "HelpViewController.h"
#import "ServiceViewController.h"
#import "AboutViewController.h"
#import "SuggestionViewController.h"
#import "LoginViewController.h"
#import "UserListViewController.h"
#import "MyPlannerViewController.h"
#import "MyChoosePlanner.h"

@interface MoreViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *imageArr;
    NSArray *titleArr;
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
//    [self naviagationShow];
    [self tableViewShow];
    
    self.navigationItem.title = @"更多";
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    _tableView.tableFooterView = viewFoot;
    [_tableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    imageArr = @[@"mylicaishi", @"bangzhu", @"lianxikefuG", @"yijianfankui", @"guanyuG", @"提示"];
    titleArr = @[@"我的理财师", @"帮助中心", @"联系客服", @"意见反馈", @"关于大圣理财", @"当前版本"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imageViewHead.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageArr objectAtIndex:indexPath.row]]];
//        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        cell.imageRight.hidden = YES;
        
        cell.banbenhao.hidden = NO;
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        cell.banbenhao.text = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
        cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    } else {
        MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imageViewHead.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageArr objectAtIndex:indexPath.row]]];
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
        cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        [MobClick event:@"MyPlanner"];
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        
        if ([[dic objectForKey:@"inviteType"] isEqualToNumber:[NSNumber numberWithInteger:0]]) {
            
            if ([[dic objectForKey:@"myFinPlanner"] isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                
                //      如果还没有自己的理财师 跳转到理财师列表的页面
                MyChoosePlanner *myChoose = [[MyChoosePlanner alloc] init];
                [self.navigationController pushViewController:myChoose animated:YES];
                
            } else {
                
                //      如果已经有自己的理财师直接跳转到我的理财师
                MyPlannerViewController *myPlannerVC = [[MyPlannerViewController alloc] init];
                myPlannerVC.design = 1;
                [self.navigationController pushViewController:myPlannerVC animated:YES];
            }
        } else {
            UserListViewController *userList = [[UserListViewController alloc] init];
            [self.navigationController pushViewController:userList animated:YES];
        }

        
    } else if (indexPath.row == 1) {
        
        HelpViewController *helpVC = [[HelpViewController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
        
    } else if (indexPath.row == 2) {
        
        ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
        [self.navigationController pushViewController:serviceVC animated:YES];
        
    } else if (indexPath.row == 3) {
        
        SuggestionViewController *suggestVC = [[SuggestionViewController alloc] init];
        [self.navigationController pushViewController:suggestVC animated:YES];
        
    } else if (indexPath.row == 4){
        
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
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
