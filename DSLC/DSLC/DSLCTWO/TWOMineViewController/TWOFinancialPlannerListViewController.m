//
//  TWOFinancialPlannerListViewController.m
//  DSLC
//
//  Created by ios on 16/5/30.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOFinancialPlannerListViewController.h"
#import "TWOFinancialPlannerCell.h"
#import "ChatViewController.h"

@interface TWOFinancialPlannerListViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
}

@end

@implementation TWOFinancialPlannerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的理财师"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    _tabelView.backgroundColor = [UIColor qianhuise];
    [_tabelView registerNib:[UINib nibWithNibName:@"TWOFinancialPlannerCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tabelView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOFinancialPlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imageHead.image = [UIImage imageNamed:@"myhoutou"];
    cell.imageHead.layer.cornerRadius = cell.imageHead.frame.size.height/2;
    cell.imageHead.layer.masksToBounds = YES;
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
    cell.labelName.text = @"郭敏";
    cell.labelInviteCode.text = [NSString stringWithFormat:@"邀请码 %@", @"918734917"];
    cell.labelInviteCode.textColor = [UIColor profitColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    pushVC(chatVC);
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
