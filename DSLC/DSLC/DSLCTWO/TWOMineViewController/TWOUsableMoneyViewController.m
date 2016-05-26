//
//  TWOUsableMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOUsableMoneyViewController.h"
#import "TWOUsableMoneyCell.h"
#import "TWOLiftMoneyViewController.h"
#import "TWOMoneyMoreViewController.h"
#import "TWOUsableAllMoneyViewController.h"

@interface TWOUsableMoneyViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UIButton *butLiftMoney;
    UIButton *butChongZhi;
}

@end

@implementation TWOUsableMoneyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [butChongZhi setHidden:NO];
    [butLiftMoney setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"可用余额"];
    
    [self tableViewShow];
    [self downContentShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 159)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOUsableMoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    [self tableViewHead];
}

- (void)tableViewHead
{
    UIImageView *imageBackground = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 159) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageBackground];
    
    UILabel *labelYuE = [CreatView creatWithLabelFrame:CGRectMake(0, 30, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [imageBackground addSubview:labelYuE];
    
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"100,300.00"]];
    NSRange moneyRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"元"].location);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:36] range:moneyRange];
    [labelYuE setAttributedText:moneyString];
    
    UILabel *labelWenZi = [CreatView creatWithLabelFrame:CGRectMake(0, 30 + 40 + 10, WIDTH_CONTROLLER_DEFAULT, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"账户余额"];
    [imageBackground addSubview:labelWenZi];
}

//充值&提现
- (void)downContentShow
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    butLiftMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, self.view.frame.size.height - 49, WIDTH_CONTROLLER_DEFAULT/2, 49) backgroundColor:[UIColor colorWithRed:112.0 / 225.0 green:193.0 / 225.0 blue:252.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:@"提现"];
    [app.tabBarVC.view addSubview:butLiftMoney];
    butLiftMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butLiftMoney setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateNormal];
    [butLiftMoney setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateHighlighted];
    [butLiftMoney addTarget:self action:@selector(liftMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    butChongZhi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, self.view.frame.size.height - 49, WIDTH_CONTROLLER_DEFAULT/2, 49) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"充值"];
    [app.tabBarVC.view addSubview:butChongZhi];
    butChongZhi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butChongZhi setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
    [butChongZhi setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateHighlighted];
    [butChongZhi addTarget:self action:@selector(moneyMoreButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOUsableMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *leftArray = @[@"余额不产生收益", @"我的账单"];
    cell.labelTitle.text = [leftArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        cell.labelSate.text = @"购买理财产品";
        cell.labelSate.textColor = [UIColor profitColor];
        cell.imageRight.image = [UIImage imageNamed:@"blueicon"];
    } else {
        cell.labelSate.text = @"查看";
        cell.labelSate.textColor = [UIColor orangecolor];
        cell.imageRight.image = [UIImage imageNamed:@"orangeicon"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
        
        UIButton *indexButton = [app.tabBarVC.tabButtonArray objectAtIndex:1];
        
        for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
            
            if (indexButton.tag != tempButton.tag) {
                NSLog(@"%ld",(long)tempButton.tag);
                [tempButton setSelected:NO];
            }
        }
        
        [indexButton setSelected:YES];
        
    } else {
        TWOUsableAllMoneyViewController *usableAllMVC = [[TWOUsableAllMoneyViewController alloc] init];
        pushVC(usableAllMVC);
    }
}

//提现按钮
- (void)liftMoneyButton:(UIButton *)button
{
    TWOLiftMoneyViewController *liftMoneyVC = [[TWOLiftMoneyViewController alloc] init];
    [self.navigationController pushViewController:liftMoneyVC animated:YES];
}

//充值按钮
- (void)moneyMoreButton:(UIButton *)button
{
    TWOMoneyMoreViewController *moneyMoreVC = [[TWOMoneyMoreViewController alloc] init];
    [self.navigationController pushViewController:moneyMoreVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [butChongZhi setHidden:YES];
    [butLiftMoney setHidden:YES];
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
