//
//  TWOMyTidyMoneyViewController.m
//  DSLC
//
//  Created by ios on 16/5/10.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyTidyMoneyViewController.h"
#import "TWOProfitGettingCell.h"
#import "TWOProfitingViewController.h"
#import "TWOAlreayCashViewController.h"
#import "TWOUserAssetsListModel.h"

@interface TWOMyTidyMoneyViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

{
    UIView *viewBottom;
    UIScrollView *_scrollView;
    UITableView *_tableViewProfit;
    UITableView *_tabelViewCash;
    UIButton *butProfit;
    UIView *viewLineLeft;
    UIButton *buttonCash;
    UIView *viewLineRight;
    
    NSString *labelMoneyString;
    NSString *labelTouZiString;
    
    UILabel *labelMoney;
    UILabel *labelTouZi;
    
    NSMutableArray *profitting;
    NSMutableArray *profitted;
}

@end

@implementation TWOMyTidyMoneyViewController

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
    [self.navigationItem setTitle:@"我的理财"];
    
    profitting = [NSMutableArray array];
    profitted = [NSMutableArray array];
    
    labelMoneyString = @"0";
    labelTouZiString = @"0";
    
    [self contentShow];
    [self tableViewProfitShow];
    [self tableViewAlredyCashShow];
    [self getUserAssetsListOneFuction];
    [self getUserAssetsListTwoFuction];
}

- (void)contentShow
{
    viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 245.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIImageView *imageHead = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, viewBottom.frame.size.height - 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [viewBottom addSubview:imageHead];
    
//    待收本息的钱数
    if (labelMoney == nil) {
        labelMoney = [CreatView creatWithLabelFrame:CGRectMake(0, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
    }
    [imageHead addSubview:labelMoney];
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", labelMoneyString]];
    NSRange moneyRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"元"].location);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:36] range:moneyRange];
    [labelMoney setAttributedText:moneyString];
    
    UILabel *labelWaitGet = [CreatView creatWithLabelFrame:CGRectMake(0, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 5, WIDTH_CONTROLLER_DEFAULT, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"待收本息"];
    [imageHead addSubview:labelWaitGet];
    
//    投资总额钱数
    if (labelTouZi == nil) {
        labelTouZi = [CreatView creatWithLabelFrame:CGRectMake(0, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 5 + labelWaitGet.frame.size.height + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 24) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
    }
    [imageHead addSubview:labelTouZi];
    NSMutableAttributedString *touziString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", labelTouZiString]];
    NSRange touziRange = NSMakeRange(0, [[touziString string] rangeOfString:@"元"].location);
    [touziString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:24] range:touziRange];
    [labelTouZi setAttributedText:touziString];
    
    UILabel *labelInvestZong = [CreatView creatWithLabelFrame:CGRectMake(0, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelMoney.frame.size.height + 5 + labelWaitGet.frame.size.height + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelTouZi.frame.size.height + 7, WIDTH_CONTROLLER_DEFAULT, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"投资总额"];
    [imageHead addSubview:labelInvestZong];
    
//    收益中按钮
    butProfit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, viewBottom.frame.size.height - 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"收益中"];
    [viewBottom addSubview:butProfit];
    butProfit.tag = 321;
    butProfit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butProfit addTarget:self action:@selector(buttonProfitGetting:) forControlEvents:UIControlEventTouchUpInside];
    
//    收益中&已兑付中间的线
    UIView *viewCenterLine = [CreatView creatViewWithFrame:CGRectMake(butProfit.frame.size.width - 0.5, 0, 0.5, butProfit.frame.size.height) backgroundColor:[UIColor grayColor]];
    [butProfit addSubview:viewCenterLine];
    viewCenterLine.alpha = 0.3;
    
//    收益中下面的横线
    viewLineLeft = [CreatView creatViewWithFrame:CGRectMake(0, butProfit.frame.size.height - 0.5, butProfit.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [butProfit addSubview:viewLineLeft];
    
//    已兑付按钮
    buttonCash = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, viewBottom.frame.size.height - 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"已兑付"];
    [viewBottom addSubview:buttonCash];
    buttonCash.tag = 123;
    buttonCash.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonCash addTarget:self action:@selector(alreadyCashButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    viewLineRight = [CreatView creatViewWithFrame:CGRectMake(0, buttonCash.frame.size.height - 0.5, buttonCash.frame.size.width, 0.5) backgroundColor:[UIColor grayColor]];
    [buttonCash addSubview:viewLineRight];
    viewLineRight.alpha = 0.3;
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelMoney.frame = CGRectMake(0, 5, WIDTH_CONTROLLER_DEFAULT, 40);
        labelWaitGet.frame = CGRectMake(0, 5 + labelMoney.frame.size.height + 5, WIDTH_CONTROLLER_DEFAULT, 15);
        labelTouZi.frame = CGRectMake(0, labelMoney.frame.size.height + labelWaitGet.frame.size.height + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 24);
        labelInvestZong.frame = CGRectMake(0, labelMoney.frame.size.height + labelWaitGet.frame.size.height + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelTouZi.frame.size.height + 7, WIDTH_CONTROLLER_DEFAULT, 15);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        labelMoney.frame = CGRectMake(0, 13, WIDTH_CONTROLLER_DEFAULT, 40);
        labelWaitGet.frame = CGRectMake(0, 13 + labelMoney.frame.size.height + 5, WIDTH_CONTROLLER_DEFAULT, 15);
        labelTouZi.frame = CGRectMake(0, 13 + labelMoney.frame.size.height + labelWaitGet.frame.size.height + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 24);
        labelInvestZong.frame = CGRectMake(0, 13 + labelMoney.frame.size.height + labelWaitGet.frame.size.height + 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + labelTouZi.frame.size.height + 7, WIDTH_CONTROLLER_DEFAULT, 15);
    }
}

//收益中的tableView
- (void)tableViewProfitShow
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, viewBottom.frame.size.height, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - viewBottom.frame.size.height - 64 - 20)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 2, 0);
    [self.view addSubview:_scrollView];
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _tableViewProfit = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _scrollView.frame.size.height) style:UITableViewStylePlain];
    [_scrollView addSubview:_tableViewProfit];
    _tableViewProfit.dataSource = self;
    _tableViewProfit.delegate = self;
    _tableViewProfit.backgroundColor = [UIColor qianhuise];
    _tableViewProfit.separatorColor = [UIColor whiteColor];
    _tableViewProfit.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    _tableViewProfit.tableHeaderView.backgroundColor = [UIColor qianhuise];
    [_tableViewProfit registerNib:[UINib nibWithNibName:@"TWOProfitGettingCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

//已兑付的tableView;
- (void)tableViewAlredyCashShow
{
    _tabelViewCash = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, _scrollView.frame.size.height) style:UITableViewStylePlain];
    [_scrollView addSubview:_tabelViewCash];
    _tabelViewCash.dataSource = self;
    _tabelViewCash.delegate = self;
    _tabelViewCash.backgroundColor = [UIColor qianhuise];
    _tabelViewCash.separatorColor = [UIColor clearColor];
    _tabelViewCash.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    _tabelViewCash.tableFooterView.backgroundColor = [UIColor qianhuise];
    [_tabelViewCash registerNib:[UINib nibWithNibName:@"TWOProfitGettingCell" bundle:nil] forCellReuseIdentifier:@"reuseCash"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableViewProfit == tableView) {
        return profitting.count;
    } else {
        return profitted.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tableViewProfit) {
        TWOUserAssetsListModel *model = [profitting objectAtIndex:indexPath.row];
        
        TWOProfitGettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.viewBottom.layer.cornerRadius = 5;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.viewBottom.layer.borderWidth = 1;
        
        cell.labelName.text = [model productName];
        cell.labelName.textColor = [UIColor blackZiTi];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@到期", [model dueDate]];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelTouZiMoney.textColor = [UIColor orangecolor];
        cell.labelTouZiMoney.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [DES3Util decrypt:[model investMoney]]]];
        NSRange moneyRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"元"].location);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:moneyRange];
        [cell.labelTouZiMoney setAttributedText:moneyString];
        
        cell.labelTouZi.text = @"投资金额";
        cell.labelTouZi.textColor = [UIColor zitihui];
        cell.labelTouZi.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        
        cell.labelProfit.textColor = [UIColor orangecolor];
        cell.labelProfit.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        NSMutableAttributedString *profitString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [DES3Util decrypt:[model exceptedYield]]]];
        NSRange profitRange = NSMakeRange(0, [[profitString string] rangeOfString:@"元"].location);
        [profitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:profitRange];
        [cell.labelProfit setAttributedText:profitString];
        
        cell.labelShouYi.text = @"预期收益";
        cell.labelShouYi.textColor = [UIColor zitihui];
        cell.labelShouYi.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        
        cell.viewLineS.backgroundColor = [UIColor grayColor];
        cell.viewLineS.alpha = 0.1;
        
        cell.imageCash.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor qianhuise];
        return cell;
        
    } else {
        
        TWOUserAssetsListModel *model = [profitted objectAtIndex:indexPath.row];
        
        TWOProfitGettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCash"];
        
        cell.viewBottom.layer.cornerRadius = 5;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.viewBottom.layer.borderWidth = 1;
        
        cell.labelName.text = [model productName];
        cell.labelName.textColor = [UIColor blackZiTi];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@到期", [model dueDate]];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelTouZiMoney.textColor = [UIColor zitihui];
        cell.labelTouZiMoney.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [DES3Util decrypt:[model investMoney]]]];
        NSRange moneyRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"元"].location);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:moneyRange];
        [cell.labelTouZiMoney setAttributedText:moneyString];
        
        cell.labelTouZi.text = @"投资金额";
        cell.labelTouZi.textColor = [UIColor zitihui];
        cell.labelTouZi.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        
        cell.labelProfit.textColor = [UIColor zitihui];
        cell.labelProfit.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        NSMutableAttributedString *profitString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [DES3Util decrypt:[model exceptedYield]]]];
        NSRange profitRange = NSMakeRange(0, [[profitString string] rangeOfString:@"元"].location);
        [profitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:profitRange];
        [cell.labelProfit setAttributedText:profitString];
        
        cell.labelShouYi.text = @"兑付收益";
        cell.labelShouYi.textColor = [UIColor zitihui];
        cell.labelShouYi.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        
        cell.imageCash.hidden = NO;
        cell.imageCash.image = [UIImage imageNamed:@"已经兑付"];
        
        cell.viewLineS.backgroundColor = [UIColor grayColor];
        cell.viewLineS.alpha = 0.1;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor qianhuise];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tableViewProfit) {
        
        TWOUserAssetsListModel *model = [profitting objectAtIndex:indexPath.row];
        
        TWOProfitingViewController *profitingVC = [[TWOProfitingViewController alloc] init];
        profitingVC.productName = [model productName];
        profitingVC.orderId = [model orderId];
        [self.navigationController pushViewController:profitingVC animated:YES];
        
    } else {
        
        TWOUserAssetsListModel *model = [profitted objectAtIndex:indexPath.row];
        
        TWOAlreayCashViewController *alreadyCashVC = [[TWOAlreayCashViewController alloc] init];
        alreadyCashVC.productName = [model productName];
        alreadyCashVC.orderId = [model orderId];
        [self.navigationController pushViewController:alreadyCashVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

//收益中按钮方法
- (void)buttonProfitGetting:(UIButton *)button
{
    viewLineLeft.backgroundColor = [UIColor profitColor];
    viewLineLeft.alpha = 1.0;
    [butProfit setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    
    viewLineRight.backgroundColor = [UIColor grayColor];
    viewLineRight.alpha = 0.3;
    [buttonCash setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

//已兑付按钮方法
- (void)alreadyCashButtonClicked:(UIButton *)button
{
    viewLineRight.backgroundColor = [UIColor profitColor];
    viewLineRight.alpha = 1.0;
    [buttonCash setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    
    viewLineLeft.backgroundColor = [UIColor grayColor];
    viewLineLeft.alpha = 0.3;
    [butProfit setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _scrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tabelViewCash.scrollEnabled = NO;
        _tableViewProfit.scrollEnabled = NO;
    } else {
        _tabelViewCash.scrollEnabled = YES;
        _tableViewProfit.scrollEnabled = YES;
    }
    
    if (scrollView == _scrollView) {
        
        if (scrollView.contentOffset.x > 30) {
            
            viewLineRight.backgroundColor = [UIColor profitColor];
            viewLineRight.alpha = 1.0;
            [buttonCash setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
            
            viewLineLeft.backgroundColor = [UIColor grayColor];
            viewLineLeft.alpha = 0.3;
            [butProfit setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
            
        } else {
            
            if (scrollView.contentOffset.x == 0) {
                
                viewLineLeft.backgroundColor = [UIColor profitColor];
                viewLineLeft.alpha = 1.0;
                [butProfit setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
                
                viewLineRight.backgroundColor = [UIColor grayColor];
                viewLineRight.alpha = 0.3;
                [buttonCash setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark 我的理财列表
#pragma mark --------------------------------


- (void)getUserAssetsListOneFuction{
    
    NSDictionary *parmeter = @{@"phone":[self.flagDic objectForKey:@"phone"],@"curPage":@1,@"status":@"1,2",@"pageSize":@10,@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getUserAssetsList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getUserAssetsListOne = %@",responseObject);
        
        NSArray *oneArray = [responseObject objectForKey:@"Product"];
        
        labelTouZiString = [DES3Util decrypt:[responseObject objectForKey:@"totalInvestMoney"]];
        labelMoneyString = [DES3Util decrypt:[responseObject objectForKey:@"totalAccrualMoney"]];
        
        for (NSDictionary *dic in oneArray) {
            TWOUserAssetsListModel *model = [[TWOUserAssetsListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [profitting addObject:model];
        }
        
        [self contentShow];
        
        [_tableViewProfit reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)getUserAssetsListTwoFuction{
    
    NSDictionary *parmeter = @{@"phone":[self.flagDic objectForKey:@"phone"],@"curPage":@1,@"status":@3,@"pageSize":@10,@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getUserAssetsList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getUserAssetsListThree = %@",responseObject);
        
        NSArray *oneArray = [responseObject objectForKey:@"Product"];
        
        for (NSDictionary *dic in oneArray) {
            TWOUserAssetsListModel *model = [[TWOUserAssetsListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [profitted addObject:model];
        }
        
        [_tabelViewCash reloadData];
        
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
