//
//  TWOMyMonkeyCoinViewController.m
//  DSLC
//
//  Created by ios on 16/5/12.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyMonkeyCoinViewController.h"
#import "TWOMyMonkeyCoinCell.h"
#import "TWOMonkeyDetailViewController.h"
#import "MonkeyRulesViewController.h"

@interface TWOMyMonkeyCoinViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UIImageView *imagePicture;
    UIButton *butBlackAlpha;
    UIView *viewBottom;
}

@end

@implementation TWOMyMonkeyCoinViewController

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
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"我的猴币"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 248.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMyMonkeyCoinCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
    imagePicture = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 156.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor qianhuise] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imagePicture];
    
    UILabel *labelMonkeyCoin = [CreatView creatWithLabelFrame:CGRectMake(0, 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [imagePicture addSubview:labelMonkeyCoin];
    
    NSMutableAttributedString *monkeyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@猴币", @"100098"]];
    NSRange monkeyRange = NSMakeRange(0, [[monkeyString string] rangeOfString:@"猴"].location);
    [monkeyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:monkeyRange];
    [labelMonkeyCoin setAttributedText:monkeyString];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelMonkeyCoin.frame = CGRectMake(0, 8.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30);
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        labelMonkeyCoin.frame = CGRectMake(0, 12.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30);
    }
    
    [self monkeyCoinDetail];
    [self playMonkeyCoin];
}

//猴币明细布局
- (void)monkeyCoinDetail
{
    UIButton *butMonkeyDetail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, imagePicture.frame.size.height + 10, (WIDTH_CONTROLLER_DEFAULT - 28)/2, _tableView.tableHeaderView.frame.size.height - imagePicture.frame.size.height - 20) backgroundColor:[UIColor colorWithRed:251.0 / 225.0 green:175.0 / 225.0 blue:61.0 / 225.0 alpha:1.0] textColor:nil titleText:nil];
    [_tableView.tableHeaderView addSubview:butMonkeyDetail];
    butMonkeyDetail.layer.cornerRadius = 5;
    butMonkeyDetail.layer.masksToBounds = YES;
    [butMonkeyDetail addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];

    CGFloat height = butMonkeyDetail.frame.size.height;
    
    UIButton *buttonDeatil = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, height/2 - 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [butMonkeyDetail addSubview:buttonDeatil];
    [buttonDeatil setBackgroundImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateNormal];
    [buttonDeatil setBackgroundImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateHighlighted];
    [buttonDeatil addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonTop = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20 + 36 + 5, height/2 - 18, 60, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"猴币明细"];
    [butMonkeyDetail addSubview:buttonTop];
    buttonTop.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonTop addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonDown = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(25 + 36, height/2 - 18 + 15 + 5, 8 * 13, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"囤积猴币赢取奖品"];
    [butMonkeyDetail addSubview:buttonDown];
    buttonDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    [buttonDown addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        buttonDeatil.frame = CGRectMake(10, height/2 - 17, 34, 34);
        buttonTop.frame = CGRectMake(10 + 34 + 2, height/2 - 17, 60, 15);
        buttonDown.frame = CGRectMake(12 + 34, height/2 - 17 + 15 + 5, 8 * 12, 14);
        buttonDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    }
}

//猴币玩法布局
- (void)playMonkeyCoin
{
    CGFloat width = (WIDTH_CONTROLLER_DEFAULT - 20 - 8)/2;
    
    UIButton *buttonPlay = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10 + width + 8, imagePicture.frame.size.height + 10, width, _tableView.tableHeaderView.frame.size.height - imagePicture.frame.size.height - 20) backgroundColor:[UIColor colorWithRed:62.0 / 225.0 green:158.0 / 225.0 blue:232.0 / 225.0 alpha:1.0] textColor:nil titleText:nil];
    [_tableView.tableHeaderView addSubview:buttonPlay];
    buttonPlay.layer.cornerRadius = 5;
    buttonPlay.layer.masksToBounds = YES;
    [buttonPlay addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat height = buttonPlay.frame.size.height;
    UIButton *buttonImage = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, height/2 - 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [buttonPlay addSubview:buttonImage];
    [buttonImage setBackgroundImage:[UIImage imageNamed:@"houbiwanfa"] forState:UIControlStateNormal];
    [buttonImage setBackgroundImage:[UIImage imageNamed:@"houbiwanfa"] forState:UIControlStateHighlighted];
    [buttonImage addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonTop = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20 + 36 + 5, height/2 - 18, 60, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"猴币玩法"];
    [buttonPlay addSubview:buttonTop];
    buttonTop.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonTop addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonDown = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(25 + 36, height/2 - 18 + 15 + 5, 8 * 13, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"一般人我不告诉他"];
    [buttonPlay addSubview:buttonDown];
    buttonDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    [buttonDown addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        buttonImage.frame = CGRectMake(10, height/2 - 17, 34, 34);
        buttonTop.frame = CGRectMake(10 + 34 + 2, height/2 - 17, 60, 15);
        buttonDown.frame = CGRectMake(12 + 34, height/2 - 17 + 15 + 5, 8 * 12, 14);
        buttonDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMyMonkeyCoinCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.viewLineTop.backgroundColor = [UIColor grayColor];
    cell.viewLineTop.alpha = 0.2;
    
    cell.viewLineDown.backgroundColor = [UIColor grayColor];
    cell.viewLineDown.alpha = 0.2;
    
    cell.labelScore.text = @"游戏积分";
    cell.labelScore.textColor = [UIColor ZiTiColor];
    cell.labelScore.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelFenShu.text = [NSString stringWithFormat:@"%@分", @"2000000"];
    cell.labelFenShu.textColor = [UIColor orangecolor];
    cell.labelFenShu.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    [cell.butCashCoin setTitle:@"兑换猴币" forState:UIControlStateNormal];
    [cell.butCashCoin setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    cell.butCashCoin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [cell.butCashCoin addTarget:self action:@selector(cashMonkeyCoinButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.labelBottom.backgroundColor = [UIColor qianhuise];
    cell.labelPlayCoin.text = @"玩猴币";
    cell.labelPlayCoin.textColor = [UIColor ZiTiColor];
    cell.labelPlayCoin.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelPlayCoin.backgroundColor = [UIColor clearColor];
    
    cell.viewLineH.backgroundColor = [UIColor grayColor];
    cell.viewLineH.alpha = 0.2;
    
    cell.viewLineS.backgroundColor = [UIColor grayColor];
    cell.viewLineS.alpha = 0.2;
    
    cell.viewLineHZ.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.viewLineHZ.alpha = 0.7;
    
    cell.viewLineSZ.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.viewLineSZ.alpha = 0.7;
    
    [cell.butLeftUp setBackgroundImage:[UIImage imageNamed:@"大转盘"] forState:UIControlStateNormal];
    [cell.butRightUp setBackgroundImage:[UIImage imageNamed:@"baojichoujiang"] forState:UIControlStateNormal];
    [cell.butLeftDown setBackgroundImage:[UIImage imageNamed:@"duihuanshouyi"] forState:UIControlStateNormal];
    [cell.butRightDown setBackgroundImage:[UIImage imageNamed:@"youxi"] forState:UIControlStateNormal];
    
    [cell.butLeftUp addTarget:self action:@selector(bigTurntableButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butRightUp addTarget:self action:@selector(crazyBeatButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butLeftDown addTarget:self action:@selector(cashProfitButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butRightDown addTarget:self action:@selector(gameCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butOneUp setTitle:@"大转盘" forState:UIControlStateNormal];
    [cell.butOneDown setTitle:@"转出幸运大礼" forState:UIControlStateNormal];
    [cell.butTwoUp setTitle:@"爆击红包" forState:UIControlStateNormal];
    [cell.butTwoDown setTitle:@"免费抽奖抽不停" forState:UIControlStateNormal];
    [cell.butThreeUp setTitle:@"兑换收益" forState:UIControlStateNormal];
    [cell.butThreeDown setTitle:@"猴币变现金duang" forState:UIControlStateNormal];
    [cell.butFourUp setTitle:@"游戏中心" forState:UIControlStateNormal];
    [cell.butFourDown setTitle:@"特殊装备你最牛" forState:UIControlStateNormal];
    
    [cell.butOneUp addTarget:self action:@selector(bigTurntableButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butOneDown addTarget:self action:@selector(bigTurntableButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butTwoUp addTarget:self action:@selector(crazyBeatButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butTwoDown addTarget:self action:@selector(crazyBeatButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butThreeUp addTarget:self action:@selector(cashProfitButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butThreeDown addTarget:self action:@selector(cashProfitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butFourUp addTarget:self action:@selector(gameCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butFourDown addTarget:self action:@selector(gameCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.viewLineMonkey.backgroundColor = [UIColor profitColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 216;
}

//兑换猴币按钮
- (void)cashMonkeyCoinButton:(UIButton *)button
{
    NSLog(@"兑换");
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
//    黑色遮罩层透明
    butBlackAlpha = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:butBlackAlpha];
    butBlackAlpha.alpha = 0.3;
    [butBlackAlpha addTarget:self action:@selector(buttonBlackAlphaDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
//    白色底部view
    viewBottom = [CreatView creatViewWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 310)/2, HEIGHT_CONTROLLER_DEFAULT/2 - 138, 310, 236) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewBottom];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        viewBottom.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 280)/2, HEIGHT_CONTROLLER_DEFAULT/2 - 138, 280, 236);
    }
    
    CGFloat width = viewBottom.frame.size.width;
    
//    兑换确认文字
    UILabel *labelMakeSure = [CreatView creatWithLabelFrame:CGRectMake(0, 0, width, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackZiTi] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"兑换确认"];
    [viewBottom addSubview:labelMakeSure];
    labelMakeSure.userInteractionEnabled = YES;
    
//    x按钮
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(labelMakeSure.frame.size.width - 22 - 5, 9, 22, 22) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [labelMakeSure addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"product-cuo"] forState:UIControlStateNormal];
    [butCancle addTarget:self action:@selector(buttonBlackAlphaDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
//    蓝线
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 39.5, width, 0.5) backgroundColor:[UIColor profitColor]];
    [labelMakeSure addSubview:viewLine];
    
//    可兑换积分多少个
    UILabel *labelScore = [CreatView creatWithLabelFrame:CGRectMake(0, 76, width, 15) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[NSString stringWithFormat:@"可兑换积分:%@个", @"100000"]];
    [viewBottom addSubview:labelScore];
    
//    确认兑换猴币数量
    UILabel *labelSureCoin = [CreatView creatWithLabelFrame:CGRectMake(0, 76 + 15 + 13, width, 15) backgroundColor:[UIColor whiteColor] textColor:[UIColor orangecolor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewBottom addSubview:labelSureCoin];
    
    NSMutableAttributedString *coinString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"确认兑换:10000猴币"]];
    NSRange coinRange = NSMakeRange(0, 5);
    [coinString addAttribute:NSForegroundColorAttributeName value:[UIColor ZiTiColor] range:coinRange];
    [labelSureCoin setAttributedText:coinString];
    
//    确认按钮
    UIButton *butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(29, 76 + 15 + 13 + 15 + 25, width - 58, 45) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确认"];
    [viewBottom addSubview:butMakeSure];
    butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butMakeSure.layer.cornerRadius = 5;
    butMakeSure.layer.masksToBounds = YES;
    [butMakeSure addTarget:self action:@selector(buttonBlackAlphaDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelScale = [CreatView creatWithLabelFrame:CGRectMake(0, 76 + 15 + 13 + 15 + 25 + 45 + 14, width, 13) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"游戏积分兑换猴币为10:1"];
    [viewBottom addSubview:labelScale];
}

//猴币明细按钮
- (void)buttonMonkeyCoinDetail:(UIButton *)button
{
    TWOMonkeyDetailViewController *monkeyDetailVC = [[TWOMonkeyDetailViewController alloc] init];
    [self.navigationController pushViewController:monkeyDetailVC animated:YES];
}

//猴币玩法按钮
- (void)buttonPlayMonkey:(UIButton *)button
{
    MonkeyRulesViewController *monkeyRuleVC = [[MonkeyRulesViewController alloc] init];
    pushVC(monkeyRuleVC);
}

//大转盘按钮方法
- (void)bigTurntableButton:(UIButton *)button
{
    NSLog(@"big");
}

//爆击红包按钮方法
- (void)crazyBeatButton:(UIButton *)button
{
    NSLog(@"beat");
}

//兑换收益按钮方法
- (void)cashProfitButton:(UIButton *)button
{
    NSLog(@"cash");
}

//游戏中心按钮方法
- (void)gameCenterButton:(UIButton *)button
{
    NSLog(@"game");
}

//遮罩层消失方法
- (void)buttonBlackAlphaDisappear:(UIButton *)button
{
    [butBlackAlpha removeFromSuperview];
    [viewBottom removeFromSuperview];
    
    butBlackAlpha = nil;
    viewBottom = nil;
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
