//
//  TWOMyPrerogativeMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/11.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyPrerogativeMoneyViewController.h"
#import "TWOMyPrerogativeMoneyCell.h"
#import "TWOAskViewController.h"

@interface TWOMyPrerogativeMoneyViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOMyPrerogativeMoneyViewController

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
    [self.navigationItem setTitle:@"我的特权本金"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 150.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMyPrerogativeMoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
    UIImageView *imageViewBack = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor qianhuise] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageViewBack];
    imageViewBack.userInteractionEnabled = YES;
    
//    我的特权本金的钱数
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(0, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [imageViewBack addSubview:labelMoney];
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"10,000.00"]];
    NSRange moneyRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"元"].location);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:moneyRange];
    [labelMoney setAttributedText:moneyString];
    
//    存放 '我的特权本金&问号按钮' 的view
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 53, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 5, 111, 15) backgroundColor:[UIColor clearColor]];
    [imageViewBack addSubview:viewBottom];
    
//    我的特权本金 文字
    UIButton *butMyMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, 90, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"我的特权本金"];
    [viewBottom addSubview:butMyMoney];
    butMyMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butMyMoney addTarget:self action:@selector(buttonClickedAsk:) forControlEvents:UIControlEventTouchUpInside];
    
//    问号按钮
    UIButton *buttonAsk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(95, 2, 13, 13) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewBottom addSubview:buttonAsk];
    [buttonAsk setBackgroundImage:[UIImage imageNamed:@"wenhao"] forState:UIControlStateNormal];
    [buttonAsk setBackgroundImage:[UIImage imageNamed:@"wenhao"] forState:UIControlStateHighlighted];
    [buttonAsk addTarget:self action:@selector(buttonClickedAsk:) forControlEvents:UIControlEventTouchUpInside];
    
//    今日收益的钱数
    UILabel *labelTodayProfit = [CreatView creatWithLabelFrame:CGRectMake(13, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 20 + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), (WIDTH_CONTROLLER_DEFAULT - 26)/2, 24) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
    [imageViewBack addSubview:labelTodayProfit];
    NSMutableAttributedString *todayString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"5.00"]];
    NSRange todayRange = NSMakeRange(0, [[todayString string] rangeOfString:@"元"].location);
    [todayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:todayRange];
    [labelTodayProfit setAttributedText:todayString];
    
//    累计收益的钱数
    UILabel *labelAddProfit = [CreatView creatWithLabelFrame:CGRectMake(13 + labelTodayProfit.frame.size.width, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 20 + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), (WIDTH_CONTROLLER_DEFAULT - 26)/2, 24) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
    [imageViewBack addSubview:labelAddProfit];
    NSMutableAttributedString *addPrifitString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"5000.00"]];
    NSRange addPrifitRange = NSMakeRange(0, [[addPrifitString string] rangeOfString:@"元"].location);
    [addPrifitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:addPrifitRange];
    [labelAddProfit setAttributedText:addPrifitString];
    
    NSArray *wenZiArray = @[@"今日预计收益", @"累计收益"];
    CGFloat width = (WIDTH_CONTROLLER_DEFAULT - 26)/2;
    
    for (int o = 0; o < 2; o++) {
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(13 + width * o, 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 20 + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 5 + labelTodayProfit.frame.size.height, width, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[wenZiArray objectAtIndex:o]];
        [imageViewBack addSubview:label];
        
        if (o == 1) {
            label.textAlignment = NSTextAlignmentRight;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMyPrerogativeMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (indexPath.section == 2) {
        cell.imageProfiting.image = [UIImage imageNamed:@"已兑付hui"];
    } else {
        cell.imageProfiting.image = [UIImage imageNamed:@"收益中"];
    }
    
    cell.labelMoney.textColor = [UIColor profitColor];
    cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:24];
    NSMutableAttributedString *leftStriing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@", @"5000"]];
    NSRange leftRange = NSMakeRange(0, 1);
    [leftStriing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:leftRange];
    [cell.labelMoney setAttributedText:leftStriing];
    
    cell.labelYuQI.text = @" 预期年化1%";
    cell.labelYuQI.textColor = [UIColor findZiTiColor];
    cell.labelYuQI.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.labelFriend.text = @"好友投资11%产品30天";
    cell.labelFriend.textColor = [UIColor ZiTiColor];
    cell.labelFriend.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelBegin.text = [NSString stringWithFormat:@"起始日:%@", @"2016-10-10"];
    cell.labelBegin.textColor = [UIColor findZiTiColor];
    cell.labelBegin.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.labelCash.text = [NSString stringWithFormat:@"兑付日:2016-11-11"];
    cell.labelCash.textColor = [UIColor findZiTiColor];
    cell.labelCash.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.viewLine.backgroundColor = [UIColor grayColor];
    cell.viewLine.alpha = 0.2;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 37) backgroundColor:[UIColor qianhuise]];
    if (section == 0) {
        
        UILabel *labelList = [CreatView creatWithLabelFrame:CGRectMake(12, 2, WIDTH_CONTROLLER_DEFAULT - 24, 33) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"特权本金列表"];
        [view addSubview:labelList];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 37;
    } else {
        return 9;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

//问号按钮的方法
- (void)buttonClickedAsk:(UIButton *)button
{
    TWOAskViewController *askVC = [[TWOAskViewController alloc] init];
    pushVC(askVC);
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