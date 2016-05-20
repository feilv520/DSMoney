//
//  TWOSafeSetViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOSafeSetViewController.h"
#import "TWOPersonalSetCell.h"
#import "TWOSetDealSecretViewController.h"
#import "TWOMendLoginViewController.h"
#import "TWOHandSettingViewController.h"

@interface TWOSafeSetViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOSafeSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"安全设置"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOPersonalSetCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOPersonalSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *titleArr = @[@"登录密码", @"手势密码"];
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    cell.imagePic.hidden = YES;
    
    if (indexPath.row == 1) {
        cell.labelStates.hidden = YES;
    } else {
        cell.labelStates.text = @"设置";
        cell.labelStates.textColor = [UIColor profitColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        如未设置登录 跳转设置登录密码
//        TWOSetDealSecretViewController *setDealSecret = [[TWOSetDealSecretViewController alloc] init];
//        [self.navigationController pushViewController:setDealSecret animated:YES];
        
//        如已设置登录密码 跳转修改登录密码
        TWOMendLoginViewController *mendLogin = [[TWOMendLoginViewController alloc] init];
        pushVC(mendLogin);
    } else {
        
        TWOHandSettingViewController *handSettingVC = [[TWOHandSettingViewController alloc] init];
        pushVC(handSettingVC);
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
