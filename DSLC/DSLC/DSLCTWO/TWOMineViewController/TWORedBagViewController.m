//
//  TWORedBagViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWORedBagViewController.h"
#import "TWOUseRedBagCell.h"
#import "TWOHistoryRedBagViewController.h"
#import "RedBagExplainViewController.h"
#import "TWOAddInterestViewController.h"
#import "TWOHistoryJiaXiQuanViewController.h"
#import "TWOWaitCashCell.h"

@interface TWORedBagViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UITableView *_tableViewJia;
    UIButton *butRedBag;
    UIButton *buttonJiaXi;
    UIScrollView *_scrollView;
}

@end

@implementation TWORedBagViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    butRedBag.hidden = NO;
    buttonJiaXi.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationTitleShow];
    [self tableViewShow];
}

- (void)navigationTitleShow
{
    butRedBag = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 105.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 10, 105.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"红包"];
    [self.navigationController.navigationBar addSubview:butRedBag];
    butRedBag.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    [butRedBag addTarget:self action:@selector(redBagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonJiaXi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 10, 105.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"加息券"];
    [self.navigationController.navigationBar addSubview:buttonJiaXi];
    buttonJiaXi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [buttonJiaXi addTarget:self action:@selector(jiaXiQuanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tableViewShow
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    [self.view addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT*2, 0);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64 - 72) style:UITableViewStylePlain];
    [_scrollView addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOUseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableViewJia = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 65, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64 - 72) style:UITableViewStylePlain];
    [_scrollView addSubview:_tableViewJia];
    _tableViewJia.dataSource = self;
    _tableViewJia.delegate = self;
    _tableViewJia.separatorColor = [UIColor clearColor];
    _tableViewJia.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60)];
    [_tableViewJia registerNib:[UINib nibWithNibName:@"TWOUseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableViewJia registerNib:[UINib nibWithNibName:@"TWOWaitCashCell" bundle:nil] forCellReuseIdentifier:@"reuseTWO"];
    
    [self redBagViewHeadShow];
    [self redBagTabelViewFoot];
    [self jiaxiquanHead];
    [self jiaxiquanFoot];
}

- (void)redBagViewHeadShow
{
    UIView *viewHead = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 65) backgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:viewHead];
    
    UIButton *butCanUse = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 36) backgroundColor:[UIColor redBagBankColor] textColor:[UIColor profitColor] titleText:[NSString stringWithFormat:@"%@张可用红包,去使用>", @"2"]];
    [viewHead addSubview:butCanUse];
    butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCanUse addTarget:self action:@selector(goToUseRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    红包使用说明按钮
    UIButton *butUseSHuo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 72, viewHead.frame.size.height - 16 -5, 72, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"红包使用说明"];
    [viewHead addSubview:butUseSHuo];
    butUseSHuo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butUseSHuo addTarget:self action:@selector(redBagUseExplain:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butLine = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 72, viewHead.frame.size.height - 2 - 5, 72, 1) backgroundColor:[UIColor profitColor] textColor:nil titleText:nil];
    [viewHead addSubview:butLine];
}

- (void)redBagTabelViewFoot
{
    UIView *viewFoot = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 96, _tableView.tableFooterView.frame.size.height - 20, 192, 20) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableFooterView addSubview:viewFoot];
    
    UILabel *labelGray = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 144, 19) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"没有更多有效红包了, 查看"];
    [viewFoot addSubview:labelGray];
    
    UIButton *butCheck = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewFoot.frame.size.width - 48, 0, 48, 19) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"历史红包"];
    [viewFoot addSubview:butCheck];
    butCheck.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butCheck addTarget:self action:@selector(buttonCheckHistoryRedBag:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, butCheck.frame.size.height - 1, butCheck.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [butCheck addSubview:viewLine];
}

- (void)jiaxiquanHead
{
    UIView *viewHead = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, 65) backgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:viewHead];
    
    UIButton *butCanUse = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 36) backgroundColor:[UIColor redBagBankColor] textColor:[UIColor profitColor] titleText:[NSString stringWithFormat:@"%@张可用加息券, 去使用>", @"2"]];
    [viewHead addSubview:butCanUse];
    butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCanUse addTarget:self action:@selector(goToUseRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //    红包使用说明按钮
    UIButton *butUseSHuo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 84, viewHead.frame.size.height - 16 -5, 84, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"加息券使用说明"];
    [viewHead addSubview:butUseSHuo];
    butUseSHuo.tag = 66;
    butUseSHuo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butUseSHuo addTarget:self action:@selector(redBagUseExplain:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butLine = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 84, viewHead.frame.size.height - 2 - 5, 84, 1) backgroundColor:[UIColor profitColor] textColor:nil titleText:nil];
    [viewHead addSubview:butLine];
}

- (void)jiaxiquanFoot
{
    UIView *viewFoot = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 108, _tableView.tableFooterView.frame.size.height - 20, 216, 20) backgroundColor:[UIColor whiteColor]];
    [_tableViewJia.tableFooterView addSubview:viewFoot];
    
    UILabel *labelGray = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 156, 19) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"没有更多有效加息券了, 查看"];
    [viewFoot addSubview:labelGray];
    
    UIButton *butCheck = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewFoot.frame.size.width - 60, 0, 60, 19) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"历史加息券"];
    [viewFoot addSubview:butCheck];
    butCheck.tag = 77;
    butCheck.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butCheck addTarget:self action:@selector(buttonCheckHistoryRedBag:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, butCheck.frame.size.height - 1, butCheck.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [butCheck addSubview:viewLine];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return 2;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        
        TWOUseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.imagePicture.image = [UIImage imageNamed:@"twohongbao"];
        
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", @"20"]];
        NSRange signRange = NSMakeRange(0, 1);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:signRange];
        [cell.labelMoney setAttributedText:moneyString];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", @"10000"]];
        NSRange leftRange = NSMakeRange(0, 5);
        [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
        [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:leftRange];
        NSRange rightRange = NSMakeRange([[useing string] length] - 2, 2);
        [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
        [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:rightRange];
        [cell.labelTiaoJian setAttributedText:useing];
        cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
        
        cell.labelEvery.text = @"所有产品适用";
        cell.labelEvery.backgroundColor = [UIColor clearColor];
        
        cell.labelCanUse.text = @"可\n使\n用";
        cell.labelCanUse.numberOfLines = 3;
        cell.labelCanUse.backgroundColor = [UIColor clearColor];
        
        cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
        cell.labelData.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row == 2) {
            cell.contentView.alpha = 0.5;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        if (indexPath.row == 2) {
            
            TWOWaitCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseTWO"];
            cell.imageWait.image = [UIImage imageNamed:@"quanTwo"];
            
            NSMutableAttributedString *percentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"2"]];
            NSRange qianRange = NSMakeRange(0, [[percentString string] rangeOfString:@"%"].location);
            [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:qianRange];
            [cell.labelPercent setAttributedText:percentString];
            cell.labelPercent.backgroundColor = [UIColor clearColor];
            if (WIDTH_CONTROLLER_DEFAULT == 320) {
                cell.labelPercent.textAlignment = NSTextAlignmentLeft;
            }
            
            NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", @"10000"]];
            NSRange leftRange = NSMakeRange(0, 5);
            [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
            [moneyString addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:leftRange];
            NSRange rightRange = NSMakeRange([[moneyString string] length] - 2, 2);
            [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
            [moneyString addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:rightRange];
            [cell.labelTiaoJian setAttributedText:moneyString];
            cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
            
            cell.labelEvery.text = @"所有产品适用";
            cell.labelEvery.backgroundColor = [UIColor clearColor];
            
            cell.laeblData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
            cell.laeblData.backgroundColor = [UIColor clearColor];
            
            NSMutableAttributedString *qianMianString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待兑付金额:%@元", @"20"]];
            NSRange qianMianRange = NSMakeRange(0, 6);
            [qianMianString addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:qianMianRange];
            [qianMianString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:qianMianRange];
            NSRange houMianRange = NSMakeRange([[qianMianString string] length] - 1, 1);
            [qianMianString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:houMianRange];
            [qianMianString addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:houMianRange];
            [cell.laeblMoney setAttributedText:qianMianString];
            cell.laeblMoney.backgroundColor = [UIColor clearColor];
            
            cell.labelTime.text = [NSString stringWithFormat:@"产品到期日:2016-09-09"];
            cell.labelTime.backgroundColor = [UIColor clearColor];
            
            cell.labelShuoMing.text = @"( 到期日后7个工作日内兑付至余额 )";
            cell.labelShuoMing.backgroundColor = [UIColor clearColor];
            
            cell.labelWait.text = @"待\n兑\n付";
            cell.labelWait.numberOfLines = 3;
            cell.labelWait.backgroundColor = [UIColor clearColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            TWOUseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
            cell.imagePicture.image = [UIImage imageNamed:@"jiaxijuan"];
            
            NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"2"]];
            NSRange signRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"%"].location);
            [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:signRange];
            NSRange baiRange = NSMakeRange([[moneyString string] length] - 1, 1);
            [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:baiRange];
            [cell.labelMoney setAttributedText:moneyString];
            cell.labelMoney.backgroundColor = [UIColor clearColor];
            if (WIDTH_CONTROLLER_DEFAULT == 320) {
                cell.labelMoney.textAlignment = NSTextAlignmentLeft;
            }
            
            NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", @"10000"]];
            NSRange leftRange = NSMakeRange(0, 5);
            [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
            [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:leftRange];
            NSRange rightRange = NSMakeRange([[useing string] length] - 2, 2);
            [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
            [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:rightRange];
            [cell.labelTiaoJian setAttributedText:useing];
            cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
            
            cell.labelEvery.text = @"所有产品适用";
            cell.labelEvery.backgroundColor = [UIColor clearColor];
            
            cell.labelCanUse.text = @"可\n使\n用";
            cell.labelCanUse.numberOfLines = 3;
            cell.labelCanUse.backgroundColor = [UIColor clearColor];
            
            cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
            cell.labelData.backgroundColor = [UIColor clearColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        return 140;
    } else {
        if (indexPath.row == 2) {
            return 160;
        } else {
            return 140;
        }
    }
}

//红包按钮
- (void)redBagButtonClicked:(UIButton *)button
{
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    buttonJiaXi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

//加息券按钮
- (void)jiaXiQuanButtonClicked:(UIButton *)button
{
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    butRedBag.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
    } completion:^(BOOL finished) {
        
    }];
}

//去使用可用红包页面
- (void)goToUseRedBagButton:(UIButton *)button
{
    NSLog(@"go");
}

//红包使用说明按钮
- (void)redBagUseExplain:(UIButton *)button
{
    if (button.tag == 66) {
        TWOAddInterestViewController *addInterestVC = [[TWOAddInterestViewController alloc] init];
        pushVC(addInterestVC);
    } else {
        RedBagExplainViewController *redBagExplain = [[RedBagExplainViewController alloc] init];
        pushVC(redBagExplain);
    }
}

//查看历史红包
- (void)buttonCheckHistoryRedBag:(UIButton *)button
{
    if (button.tag == 77) {
        TWOHistoryJiaXiQuanViewController *historyJia = [[TWOHistoryJiaXiQuanViewController alloc] init];
        pushVC(historyJia);
    } else {
        TWOHistoryRedBagViewController *historyRedBag = [[TWOHistoryRedBagViewController alloc] init];
        pushVC(historyRedBag);
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    butRedBag.hidden = YES;
    buttonJiaXi.hidden = YES;
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