//
//  TWOAlreayCashViewController.m
//  DSLC
//
//  Created by ios on 16/5/11.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAlreayCashViewController.h"
#import "TWOProfitingEveryCell.h"
#import "TWOBottomMoneyDetailViewController.h"

@interface TWOAlreayCashViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOAlreayCashViewController

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
    [self.navigationItem setTitle:self.productName];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 175.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOProfitingEveryCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
//    已兑付图片
    UIImageView *imageViewCash = [CreatView creatImageViewWithFrame:CGRectMake(233, 209.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 105, 105) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"已经兑付"]];
    [_tableView addSubview:imageViewCash];
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
    UIImageView *imageViewHead = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageViewHead];
    
    //    投资金额的钱数
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(0, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
    [imageViewHead addSubview:labelMoney];
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"400,000.00"]];
    NSRange moneyRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"元"].location);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:30] range:moneyRange];
    [labelMoney setAttributedText:moneyString];
    
    //    投资金额文字
    UILabel *labelTouZi = [CreatView creatWithLabelFrame:CGRectMake(0, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"投资金额"];
    [imageViewHead addSubview:labelTouZi];
    
    NSArray *topArray = @[@"40.00", @"72", @"8"];
    NSArray *downArray = @[@"兑付收益", @"理财期限", @"预期年化"];
    CGFloat width = (WIDTH_CONTROLLER_DEFAULT - 24)/3;
    CGFloat marginLeft = 12;
    
    for (int n = 0; n < 3; n++) {
        
        UILabel *labelTop = [CreatView creatWithLabelFrame:CGRectMake(marginLeft + width * n, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 15 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), width, 23) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[topArray objectAtIndex:n]];
        [imageViewHead addSubview:labelTop];
        
        if (n == 0) {
            
            NSMutableAttributedString *oneString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [topArray objectAtIndex:0]]];
            NSRange oneRange = NSMakeRange(0, [[oneString string] rangeOfString:@"元"].location);
            [oneString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:oneRange];
            [labelTop setAttributedText:oneString];
            labelTop.textAlignment = NSTextAlignmentLeft;
            
        } else if (n == 1) {
            
            NSMutableAttributedString *twoString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天", [topArray objectAtIndex:1]]];
            NSRange twoRange = NSMakeRange(0, [[twoString string] rangeOfString:@"天"].location);
            [twoString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:twoRange];
            [labelTop setAttributedText:twoString];
            
        } else {
            
            NSMutableAttributedString *threeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", [topArray objectAtIndex:2]]];
            NSRange threeRange = NSMakeRange(0, [[threeString string] rangeOfString:@"%"].location);
            [threeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:threeRange];
            [labelTop setAttributedText:threeString];
            labelTop.textAlignment = NSTextAlignmentRight;
        }
        
        UILabel *labelDown = [CreatView creatWithLabelFrame:CGRectMake(marginLeft + width * n, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 15 + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelTop.frame.size.height + 5, width, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[downArray objectAtIndex:n]];
        [imageViewHead addSubview:labelDown];
        
        if (n == 0) {
            labelDown.textAlignment = NSTextAlignmentLeft;
        } else if (n == 2) {
            labelDown.textAlignment = NSTextAlignmentRight;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOProfitingEveryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *titleArray = @[@[@"到期日", @"投资日", @"计息起始日", @"收益方式"], @[@"成安基金国富通亿丰商城项目"]];
    NSArray *timeArray = @[@[@"2016-09-09", @"2016-09-09", @"2016-09-09", @"到期还本付息"], @[[NSString stringWithFormat:@"%@元﹥", @"4000"]]];
    
    cell.labelName.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelName.textColor = [UIColor ZiTiColor];
    
    cell.labelRight.text = [[timeArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelRight.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            NSMutableAttributedString *leftString = [[NSMutableAttributedString alloc] initWithString:[[timeArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            NSRange leftRange = NSMakeRange(0, [[leftString string] rangeOfString:@"﹥"].location);
            [leftString addAttribute:NSForegroundColorAttributeName value:[UIColor orangecolor] range:leftRange];
            [cell.labelRight setAttributedText:leftString];
        }
        
    } else {
        cell.labelRight.textColor = [UIColor zitihui];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 36) backgroundColor:[UIColor clearColor]];
    
    if (section == 0) {
        
        UILabel *labelMoneyWhere = [CreatView creatWithLabelFrame:CGRectMake(12, 3, WIDTH_CONTROLLER_DEFAULT - 24, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"资金去向"];
        [view addSubview:labelMoneyWhere];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 36;
    } else {
        return 0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        TWOBottomMoneyDetailViewController *bottomMoneyDetaiVC = [[TWOBottomMoneyDetailViewController alloc] init];
        pushVC(bottomMoneyDetaiVC);
    }
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
