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
#import "MyMonkeyModel.h"
#import "PNChart.h"
#import "TWOgameCenterViewController.h"
#import "TBigTurntableViewController.h"
#import "TBaoJiViewController.h"
#import "TWOFindActivityCenterViewController.h"

@interface TWOMyMonkeyCoinViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UIImageView *imagePicture;
    UIButton *butBlackAlpha;
    UIView *viewBottom;
    
    NSMutableArray *monkeyArr;
    
    NSString *integralString;
    NSString *exchangeRatioStr;
    NSDictionary *dataDic;
    
    UILabel *labelScoreShow;
    UILabel *labelMonkeyCoin;
    PNChart * lineChart;
    
    UIButton *butMonkeyDetail;
    UIButton *buttonDeatil;
    UIButton *buttonTop;
    UIButton *buttonDown;
    
    UIButton *buttonPlay;
    UIButton *buttonImage;
    UIButton *buttonRightTop;
    UIButton *butRightDown;
    
    NSString *gameState;
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
    
    monkeyArr = [NSMutableArray array];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    [self getUserMonkeyInfosFuction];
}

- (void)tableViewShow
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor qianhuise];
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 248.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
        _tableView.tableHeaderView.backgroundColor = [UIColor qianhuise];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
        if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
            _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50)];
        }
        
        [_tableView registerNib:[UINib nibWithNibName:@"TWOMyMonkeyCoinCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    }
    [self.view addSubview:_tableView];
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
    if (imagePicture == nil) {
        imagePicture = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 156.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor qianhuise] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    }
    [_tableView.tableHeaderView addSubview:imagePicture];
    
    if (labelMonkeyCoin == nil) {
        labelMonkeyCoin = [CreatView creatWithLabelFrame:CGRectMake(0, 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    }
    NSMutableAttributedString *monkeyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@猴币", [dataDic objectForKey:@"totalMonkeyNum"]]];
    NSRange monkeyRange = NSMakeRange(0, [[monkeyString string] rangeOfString:@"猴"].location);
    [monkeyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:monkeyRange];
    [labelMonkeyCoin setAttributedText:monkeyString];
    [imagePicture addSubview:labelMonkeyCoin];
    
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelMonkeyCoin.frame = CGRectMake(0, 8.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30);
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        labelMonkeyCoin.frame = CGRectMake(0, 12.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30);
    }
    
    if (lineChart == nil) {
        lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, labelMonkeyCoin.frame.size.height + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), SCREEN_WIDTH, 100.0)];
        lineChart.backgroundColor = [UIColor clearColor];
        
        if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
            lineChart.frame = CGRectMake(0, 11.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30, SCREEN_WIDTH, 73.0);
        } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
            lineChart.frame = CGRectMake(0, 13.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30, SCREEN_WIDTH, 91.0);
        } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
            lineChart.frame = CGRectMake(0, 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30, SCREEN_WIDTH, 119.0);
        }
    }
    
    [lineChart setXLabels:@[[[monkeyArr objectAtIndex:0] objectForKey:@"getDate"],
                            [[[monkeyArr objectAtIndex:1] objectForKey:@"getDate"] substringWithRange:NSMakeRange(3, 2)],
                            [[[monkeyArr objectAtIndex:2] objectForKey:@"getDate"] substringWithRange:NSMakeRange(3, 2)],
                            [[[monkeyArr objectAtIndex:3] objectForKey:@"getDate"] substringWithRange:NSMakeRange(3, 2)],
                            [[[monkeyArr objectAtIndex:4] objectForKey:@"getDate"] substringWithRange:NSMakeRange(3, 2)]]];
    [lineChart setYValues:@[[[monkeyArr objectAtIndex:0] objectForKey:@"monkeyNum"],[[monkeyArr objectAtIndex:1] objectForKey:@"monkeyNum"],[[monkeyArr objectAtIndex:2] objectForKey:@"monkeyNum"],[[monkeyArr objectAtIndex:3] objectForKey:@"monkeyNum"],[[monkeyArr objectAtIndex:4] objectForKey:@"monkeyNum"]]];
    [lineChart strokeChart];
    [imagePicture addSubview:lineChart];
    
    [self monkeyCoinDetail];
    [self playMonkeyCoin];
}

//猴币明细布局
- (void)monkeyCoinDetail
{
    if (butMonkeyDetail == nil) {
        butMonkeyDetail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, imagePicture.frame.size.height + 10, (WIDTH_CONTROLLER_DEFAULT - 28)/2, _tableView.tableHeaderView.frame.size.height - imagePicture.frame.size.height - 20) backgroundColor:[UIColor colorWithRed:251.0 / 225.0 green:175.0 / 225.0 blue:61.0 / 225.0 alpha:1.0] textColor:nil titleText:nil];
        butMonkeyDetail.layer.cornerRadius = 5;
        butMonkeyDetail.layer.masksToBounds = YES;
        [butMonkeyDetail addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_tableView.tableHeaderView addSubview:butMonkeyDetail];

    
    CGFloat height = butMonkeyDetail.frame.size.height;
    if (buttonDeatil == nil) {
        buttonDeatil = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, height/2 - 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [buttonDeatil setBackgroundImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateNormal];
        [buttonDeatil setBackgroundImage:[UIImage imageNamed:@"mingxi"] forState:UIControlStateHighlighted];
        [buttonDeatil addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    [butMonkeyDetail addSubview:buttonDeatil];
    
    if (buttonTop == nil) {
        buttonTop = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(25 + 36, height/2 - 18, 60, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"猴币明细"];
        buttonTop.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [buttonTop addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    [butMonkeyDetail addSubview:buttonTop];
    
    if (buttonDown == nil) {
        buttonDown = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(25 + 36, height/2 - 18 + 15 + 5, 8 * 13, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"囤积猴币赢取奖品"];
        buttonDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        [buttonDown addTarget:self action:@selector(buttonMonkeyCoinDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
    [butMonkeyDetail addSubview:buttonDown];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        buttonDeatil.frame = CGRectMake(10, height/2 - 17, 34, 34);
        buttonTop.frame = CGRectMake(10 + 34, height/2 - 17, 60, 15);
        buttonDown.frame = CGRectMake(12 + 34, height/2 - 17 + 15 + 5, 8 * 12, 14);
        buttonTop.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        buttonDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    }
}

//猴币玩法布局
- (void)playMonkeyCoin
{
    CGFloat width = (WIDTH_CONTROLLER_DEFAULT - 20 - 8)/2;
    
    if (buttonPlay == nil) {
        buttonPlay = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10 + width + 8, imagePicture.frame.size.height + 10, width, _tableView.tableHeaderView.frame.size.height - imagePicture.frame.size.height - 20) backgroundColor:[UIColor colorWithRed:62.0 / 225.0 green:158.0 / 225.0 blue:232.0 / 225.0 alpha:1.0] textColor:nil titleText:nil];
        buttonPlay.layer.cornerRadius = 5;
        buttonPlay.layer.masksToBounds = YES;
        [buttonPlay addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_tableView.tableHeaderView addSubview:buttonPlay];
    
    CGFloat height = buttonPlay.frame.size.height;
    if (buttonImage == nil) {
        buttonImage = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, height/2 - 18, 36, 36) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [buttonImage setBackgroundImage:[UIImage imageNamed:@"houbiwanfa"] forState:UIControlStateNormal];
        [buttonImage setBackgroundImage:[UIImage imageNamed:@"houbiwanfa"] forState:UIControlStateHighlighted];
        [buttonImage addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    }
    [buttonPlay addSubview:buttonImage];
    
    if (buttonRightTop == nil) {
        buttonRightTop = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20 + 36 + 5, height/2 - 18, 60, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"猴币玩法"];
        buttonRightTop.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [buttonRightTop addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    }
    [buttonPlay addSubview:buttonRightTop];
    
    if (butRightDown == nil) {
        butRightDown = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(25 + 36, height/2 - 18 + 15 + 5, 8 * 13, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"一般人我不告诉他"];
        butRightDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        [butRightDown addTarget:self action:@selector(buttonPlayMonkey:) forControlEvents:UIControlEventTouchUpInside];
    }
    [buttonPlay addSubview:butRightDown];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        buttonImage.frame = CGRectMake(10, height/2 - 17, 34, 34);
        buttonRightTop.frame = CGRectMake(10 + 34, height/2 - 17, 60, 15);
        buttonRightTop.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        butRightDown.frame = CGRectMake(12 + 34, height/2 - 17 + 15 + 5, 8 * 12, 14);
        butRightDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
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
    
    cell.labelFenShu.text = [NSString stringWithFormat:@"%@分", integralString];
    cell.labelFenShu.textColor = [UIColor orangecolor];
    cell.labelFenShu.tag = 771;
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
    [cell.butLeftDown setBackgroundImage:[UIImage imageNamed:@"huodong"] forState:UIControlStateNormal];
    [cell.butRightDown setBackgroundImage:[UIImage imageNamed:@"youxi"] forState:UIControlStateNormal];
    
    [cell.butLeftUp addTarget:self action:@selector(bigTurntableButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butRightUp addTarget:self action:@selector(crazyBeatButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butLeftDown addTarget:self action:@selector(cashProfitButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butRightDown addTarget:self action:@selector(gameCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butOneUp setTitle:@"大转盘" forState:UIControlStateNormal];
    [cell.butOneDown setTitle:@"转出幸运大礼" forState:UIControlStateNormal];
    [cell.butTwoUp setTitle:@"爆击抽奖" forState:UIControlStateNormal];
    [cell.butTwoDown setTitle:@"免费抽奖抽不停" forState:UIControlStateNormal];
    [cell.butThreeUp setTitle:@"活动中心" forState:UIControlStateNormal];
    [cell.butThreeDown setTitle:@"月月活动玩不停" forState:UIControlStateNormal];
    [cell.butFourUp setTitle:@"游戏中心" forState:UIControlStateNormal];
    [cell.butFourDown setTitle:@"特殊装备你最牛" forState:UIControlStateNormal];
    
    [cell.butOneUp addTarget:self action:@selector(bigTurntableButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butOneDown addTarget:self action:@selector(bigTurntableButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butTwoUp addTarget:self action:@selector(crazyBeatButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butTwoDown addTarget:self action:@selector(crazyBeatButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butThreeUp addTarget:self action:@selector(cashProfitButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.butThreeDown addTarget:self action:@selector(cashProfitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //游戏中心
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
    gameState = @"monkeyCoin";
    //调用猴币兑换积分的开关
    [self gameOpenSwitch];
}

//兑换猴币弹出视图布局
- (void)cashMonekeyCoin
{
    if ([integralString integerValue] >= [exchangeRatioStr integerValue]) {
        
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        //黑色遮罩层透明
        butBlackAlpha = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
        [app.tabBarVC.view addSubview:butBlackAlpha];
        butBlackAlpha.alpha = 0.3;
        [butBlackAlpha addTarget:self action:@selector(buttonBlackAlphaDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
        //白色底部view
        viewBottom = [CreatView creatViewWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 310)/2, HEIGHT_CONTROLLER_DEFAULT/2 - 138, 310, 236) backgroundColor:[UIColor whiteColor]];
        [app.tabBarVC.view addSubview:viewBottom];
        viewBottom.layer.cornerRadius = 5;
        viewBottom.layer.masksToBounds = YES;
        
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [viewBottom.layer addAnimation:animation forKey:nil];
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            viewBottom.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 280)/2, HEIGHT_CONTROLLER_DEFAULT/2 - 138, 280, 236);
        }
        
        CGFloat width = viewBottom.frame.size.width;
        
        //兑换确认文字
        UILabel *labelMakeSure = [CreatView creatWithLabelFrame:CGRectMake(0, 0, width, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackZiTi] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"兑换确认"];
        [viewBottom addSubview:labelMakeSure];
        labelMakeSure.userInteractionEnabled = YES;
        
        //x按钮
        UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(labelMakeSure.frame.size.width - 22 - 5, 12, 18, 18) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [labelMakeSure addSubview:butCancle];
        [butCancle setBackgroundImage:[UIImage imageNamed:@"product-cuo"] forState:UIControlStateNormal];
        [butCancle addTarget:self action:@selector(buttonBlackAlphaDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
        //    蓝线
        UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 39.5, width, 0.5) backgroundColor:[UIColor profitColor]];
        [labelMakeSure addSubview:viewLine];
        
        //    可兑换积分多少个
        UILabel *labelScore = [CreatView creatWithLabelFrame:CGRectMake(0, 76, width, 15) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[NSString stringWithFormat:@"可兑换积分:%@个", integralString]];
        [viewBottom addSubview:labelScore];
        
        //    确认兑换猴币数量
        UILabel *labelSureCoin = [CreatView creatWithLabelFrame:CGRectMake(0, 76 + 15 + 13, width, 15) backgroundColor:[UIColor whiteColor] textColor:[UIColor orangecolor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
        [viewBottom addSubview:labelSureCoin];
        
        NSInteger score = [integralString integerValue] / [exchangeRatioStr integerValue];
        NSMutableAttributedString *coinString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"确认兑换:%ld猴币", (long)score]];
        NSRange coinRange = NSMakeRange(0, 5);
        [coinString addAttribute:NSForegroundColorAttributeName value:[UIColor ZiTiColor] range:coinRange];
        [labelSureCoin setAttributedText:coinString];
        
        //    确认按钮
        UIButton *butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(29, 76 + 15 + 13 + 15 + 25, width - 58, 45) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确认"];
        [viewBottom addSubview:butMakeSure];
        butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        butMakeSure.layer.cornerRadius = 5;
        butMakeSure.layer.masksToBounds = YES;
        [butMakeSure addTarget:self action:@selector(makeSureCashButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *labelScale = [CreatView creatWithLabelFrame:CGRectMake(0, 76 + 15 + 13 + 15 + 25 + 45 + 14, width, 13) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:[NSString stringWithFormat:@"游戏积分兑换猴币为%@:1", exchangeRatioStr]];
        [viewBottom addSubview:labelScale];
        
    } else {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"积分不足,无法兑换"];
    }
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
    [self bigWheelSwitch];
}

//爆击红包按钮方法
- (void)crazyBeatButton:(UIButton *)button
{
    NSLog(@"beat");
    [self baoJiSwitch];
}

//活动中心按钮方法
- (void)cashProfitButton:(UIButton *)button
{
    NSLog(@"cash");
    TWOFindActivityCenterViewController *activityCenter = [[TWOFindActivityCenterViewController alloc] init];
    pushVC(activityCenter);
}

//游戏中心按钮方法
- (void)gameCenterButton:(UIButton *)button
{
    NSLog(@"game");
    gameState = @"center";
    [self gameOpenSwitch];
}

//确定兑换按钮
- (void)makeSureCashButton:(UIButton *)button
{
    [butBlackAlpha removeFromSuperview];
    [viewBottom removeFromSuperview];
    
    butBlackAlpha = nil;
    viewBottom = nil;
    
    [self makeSureCashGetData];
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

#pragma mark 我的猴币
#pragma mark --------------------------------

//获取数据
- (void)getUserMonkeyInfosFuction
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};

    [[MyAfHTTPClient sharedClient] postWithURLString:@"monkey/getUserMonkeyInfos" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"获取猴币详情:~~~~~%@", responseObject);
        [self loadingWithHidden:YES];
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            dataDic = responseObject;
            monkeyArr = [responseObject objectForKey:@"Monkey"];
            integralString = [responseObject objectForKey:@"integral"];
            exchangeRatioStr = [responseObject objectForKey:@"exchangeRatio"];
            
            [self tableViewShow];
            [_tableView reloadData];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//确认兑换掉接口
- (void)makeSureCashGetData
{
    NSDictionary *parmeter = @{@"integral":integralString, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"integral/exchangeToMonkey" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"确认兑换猴币:::::::::::::::::%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [self getUserMonkeyInfosFuction];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//游戏功能开关
#pragma mark switch------------------------------------------
- (void)gameOpenSwitch
{
    NSDictionary *parmeter = @{@"key":@"game"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sys/sysSwitch" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        NSLog(@"游戏功能开关>>>>>>>>>>>%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:201]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"waitMoment" object:nil];
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            //游戏中心
            if ([gameState isEqualToString:@"monkeyCoin"]) {
                //积分兑换猴币弹窗
                [self cashMonekeyCoin];
            } else if ([gameState isEqualToString:@"center"]) {
                //进入游戏中心页面
                TWOgameCenterViewController *gameCenterVC = [[TWOgameCenterViewController alloc] init];
                pushVC(gameCenterVC);
            }
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//大转盘开关
#pragma mark bigWheelSwitch!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
- (void)bigWheelSwitch
{
    NSDictionary *parmeter = @{@"key":@"bigWheel"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sys/sysSwitch" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        NSLog(@"大转盘游戏开关$$$$$$$$$$$$$$$%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:201]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"waitMoment" object:nil];
            
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]){
            
            TBigTurntableViewController *bigPanVC = [[TBigTurntableViewController alloc] init];
            bigPanVC.tokenString = [self.flagDic objectForKey:@"token"];
            pushVC(bigPanVC);
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//爆击抽奖开关
#pragma mark bigWheelSwitch!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
- (void)baoJiSwitch
{
    NSDictionary *parmeter = @{@"key":@"is_CritDraw"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sys/sysSwitch" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        NSLog(@"爆击抽奖开关$$$$$$$$$$$$$$$%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:201]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"waitMoment" object:nil];
            
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]){
            
            TBaoJiViewController *baoji = [[TBaoJiViewController alloc] init];
            NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
            //判断'特权本金'登录态
            if (![[dicLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
                baoji.tokenString = [self.flagDic objectForKey:@"token"];
            } else {
                baoji.tokenString = @"";
            }
            pushVC(baoji);
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
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
