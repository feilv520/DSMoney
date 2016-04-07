//
//  MyMonkeyNumViewController.m
//  DSLC
//
//  Created by ios on 16/4/6.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "MyMonkeyNumViewController.h"
#import "MyMonkeyNumCell.h"
#import "MonkeyRulesViewController.h"
#import "MyMonkeyModel.h"

@interface MyMonkeyNumViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *detailArray;
    UILabel *labelMonkeyShu;
}

@end

@implementation MyMonkeyNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的猴币"];
    detailArray = [NSMutableArray array];
    
    [self getMonkeyDetail];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 200)];
    _tableView.tableHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self tableViewHeadShow];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyMonkeyNumCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

//头部内容
- (void)tableViewHeadShow
{
    UIImageView *imageViewBei = [CreatView creatImageViewWithFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 130) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"monkeyNumber"]];
    [_tableView.tableHeaderView addSubview:imageViewBei];
    imageViewBei.userInteractionEnabled = YES;
    
    UIButton *buttMonkeyRule = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(imageViewBei.frame.size.width - 70, imageViewBei.frame.size.height - 30, 70, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"猴币细则>"];
    [imageViewBei addSubview:buttMonkeyRule];
    buttMonkeyRule.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [buttMonkeyRule addTarget:self action:@selector(buttonMonkeyNumRuleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *monkeyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@猴币", self.monkeyNumber]];
    NSRange monkeyRange = NSMakeRange([[monkeyStr string] length] - 2, 2);
    [monkeyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:monkeyRange];
    NSRange numStr = NSMakeRange(0, [[monkeyStr string] rangeOfString:@"猴"].location);
    [monkeyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:numStr];
    
    labelMonkeyShu = [CreatView creatWithLabelFrame:CGRectMake(0, imageViewBei.frame.size.height/3 - 10, imageViewBei.frame.size.width, imageViewBei.frame.size.height/3) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [imageViewBei addSubview:labelMonkeyShu];
    [labelMonkeyShu setAttributedText:monkeyStr];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, imageViewBei.frame.size.height/3 * 2 - 10, imageViewBei.frame.size.width, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"囤积小猴币,赢取大奖品!"];
    [imageViewBei addSubview:labelAlert];
    
    UIView *viewSmall = [CreatView creatViewWithFrame:CGRectMake(10, 150, WIDTH_CONTROLLER_DEFAULT - 20, 50) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableHeaderView addSubview:viewSmall];
    viewSmall.layer.cornerRadius = 5;
    viewSmall.layer.masksToBounds = YES;
    
    UILabel *labelDetail = [CreatView creatWithLabelFrame:CGRectMake(10, 0, viewSmall.frame.size.width - 20, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"猴币明细"];
    [viewSmall addSubview:labelDetail];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 49.5, viewSmall.frame.size.width, 0.5) backgroundColor:[UIColor grayColor]];
    [viewSmall addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return detailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMonkeyNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.viewBottom.layer.cornerRadius = 5;
    cell.viewBottom.layer.masksToBounds = YES;
    
    MyMonkeyModel *model = [detailArray objectAtIndex:indexPath.row];
    cell.labelTime.text = model.createTime;
    cell.labelTime.textColor = [UIColor zitihui];
    
    if ([[model.useType description] isEqualToString:@"0"]) {
        cell.labelName.text = @"历史记录";
        cell.labelMoney.textColor = [UIColor profitGreen];
        
    } else if ([[model.useType description] isEqualToString:@"1"]) {
        cell.labelName.text = @"投资获取";
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.text = [NSString stringWithFormat:@"+%@", model.MonkeyNumber.description];
        
    } else if ([[model.useType description] isEqualToString:@"2"]) {
        cell.labelName.text = @"活动获取";
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.text = [NSString stringWithFormat:@"+%@", model.MonkeyNumber.description];
        
    } else if ([[model.useType description] isEqualToString:@"3"]) {
        cell.labelName.text = @"兑换收益";
        cell.labelMoney.textColor = [UIColor profitGreen];
        cell.labelMoney.text = [NSString stringWithFormat:@"-%@", model.MonkeyNumber.description];
        
    } else if ([[model.useType description] isEqualToString:@"4"]) {
        cell.labelName.text = @"抽奖消耗";
        cell.labelMoney.textColor = [UIColor profitGreen];
        cell.labelMoney.text = [NSString stringWithFormat:@"-%@", model.MonkeyNumber.description];
        
    } else {
        cell.labelName.text = @"兑换金斗云";
        cell.labelMoney.textColor = [UIColor profitGreen];
        cell.labelMoney.text = [NSString stringWithFormat:@"-%@", model.MonkeyNumber.description];
        
        NSMutableAttributedString *incomeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预期额外收益%@个", model.preIncome]];
        NSRange redRange = NSMakeRange(5, [[incomeStr string] rangeOfString:@"元"].location - 5);
        [incomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:redRange];
        [cell.labelProfit setAttributedText:incomeStr];
    }
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//获取数据
- (void)getMonkeyDetail
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"/app/user/getUserMonkeyDetail" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"获取猴币详情:~~~~~%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *dataArr = [responseObject objectForKey:@"Detail"];
            for (NSDictionary *dataDic in dataArr) {
                MyMonkeyModel *model = [[MyMonkeyModel alloc] init];
                [model setValuesForKeysWithDictionary:dataDic];
                [detailArray addObject:model];
            }
            
            [_tableView reloadData];
            [self tableViewShow];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//猴币细则按钮
- (void)buttonMonkeyNumRuleClicked:(UIButton *)button
{
    MonkeyRulesViewController *monkeyRule = [[MonkeyRulesViewController alloc] init];
    [self.navigationController pushViewController:monkeyRule animated:YES];
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
