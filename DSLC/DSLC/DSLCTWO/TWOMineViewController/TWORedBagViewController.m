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
#import "TWORedBagModel.h"
#import "TWOJiaXiQuanModel.h"
#import "TWIJiaXiQuanCell.h"

@interface TWORedBagViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UITableView *_tableViewJia;
    UIButton *butRedBag;
    UIButton *buttonJiaXi;
    UIScrollView *_scrollView;
    UIButton *butCanUse;
    NSMutableArray *redBagArray;
    NSMutableArray *jiaXiQuanArray;
    TWOJiaXiQuanModel *jiaXiQuanModel;
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
    
    redBagArray = [NSMutableArray array];
    jiaXiQuanArray = [NSMutableArray array];
    
    [self navigationTitleShow];
    [self tableViewShow];
    [self getMyRedPacketListFuction];
    [self getMyIncreaseListFuction];
}

- (void)navigationTitleShow
{
    UIImageView *imageBack = [CreatView creatImageViewWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 180)/2, 5, 180, 30) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"圆左"]];
    [self.navigationController.navigationBar addSubview:imageBack];
    imageBack.userInteractionEnabled = YES;
    CGFloat widthImg = imageBack.frame.size.width;
    
    butRedBag = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, widthImg/2, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] titleText:@"红包"];
    [imageBack addSubview:butRedBag];
    butRedBag.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butRedBag addTarget:self action:@selector(redBagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonJiaXi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(widthImg/2, 5, widthImg/2, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"加息券"];
    [imageBack addSubview:buttonJiaXi];
    buttonJiaXi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonJiaXi addTarget:self action:@selector(jiaXiQuanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tableViewShow
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT*2, 1);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64 - 72) style:UITableViewStylePlain];
    [_scrollView addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tag = 700;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOUseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableViewJia = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 65, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64 - 72) style:UITableViewStylePlain];
    [_scrollView addSubview:_tableViewJia];
    _tableViewJia.dataSource = self;
    _tableViewJia.delegate = self;
    _tableViewJia.tag = 800;
    _tableViewJia.separatorColor = [UIColor clearColor];
    _tableViewJia.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60)];
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        _tableViewJia.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 90)];
    }
    [_tableViewJia registerNib:[UINib nibWithNibName:@"TWIJiaXiQuanCell" bundle:nil] forCellReuseIdentifier:@"reuseJia"];
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
    
    butCanUse = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 36) backgroundColor:[UIColor redBagBankColor] textColor:[UIColor profitColor] titleText:[NSString stringWithFormat:@"%@张可用红包,去使用>", [NSString stringWithFormat:@"%lu", (unsigned long)redBagArray.count]]];
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
    
    UIButton *butCanUseJ = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 36) backgroundColor:[UIColor redBagBankColor] textColor:[UIColor profitColor] titleText:[NSString stringWithFormat:@"%@张可用加息券, 去使用>", [NSString stringWithFormat:@"%lu", (unsigned long)jiaXiQuanArray.count]]];
    [viewHead addSubview:butCanUseJ];
    butCanUseJ.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCanUseJ addTarget:self action:@selector(goToUseRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
    
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
        return redBagArray.count;
    } else {
        return jiaXiQuanArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        
        TWOUseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.imagePicture.image = [UIImage imageNamed:@"twohongbao"];
        
        TWORedBagModel *redBagModel = [redBagArray objectAtIndex:indexPath.row];
        
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", [redBagModel repPacketMoney]]];
        NSRange signRange = NSMakeRange(0, 1);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:signRange];
        [cell.labelMoney setAttributedText:moneyString];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
//        红包frame值机型判断
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelMoney.frame = CGRectMake(10, 55, 108, 40);
            cell.butCanUse.frame = CGRectMake(281, 10, 23, 127);
            cell.labelTiaoJian.frame = CGRectMake(118, 27, 150, 19);
            cell.labelEvery.frame = CGRectMake(122, 56, 146, 15);
            cell.labelData.frame = CGRectMake(116, 110, 152, 12);
        } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
            cell.labelMoney.frame = CGRectMake(10, 55, 127, 40);
        } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
            cell.labelMoney.frame = CGRectMake(12, 55, 138, 40);
            cell.butCanUse.frame = CGRectMake(370, 10, 23, 127);
            cell.labelTiaoJian.frame = CGRectMake(158, 27, 195, 19);
            cell.labelEvery.frame = CGRectMake(158, 56, 195, 15);
            cell.labelData.frame = CGRectMake(158, 110, 195, 12);
        }
        
        NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", [redBagModel investMoney]]];
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
        
        if ([[[redBagModel status] description] isEqualToString:@"0"]) {
            [cell.butCanUse setTitle:@"可\n使\n用" forState:UIControlStateNormal];
        } else if ([[[redBagModel status] description] isEqualToString:@"1"]) {
            [cell.butCanUse setTitle:@"已\n使\n用" forState:UIControlStateNormal];
        } else if ([[[redBagModel status] description] isEqualToString:@"2"]) {
            [cell.butCanUse setTitle:@"已\n失\n效" forState:UIControlStateNormal];
        }

        cell.butCanUse.titleLabel.numberOfLines = 3;
        cell.butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.butCanUse.backgroundColor = [UIColor clearColor];
        
        cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", [redBagModel startDate], [redBagModel endDate]];
        cell.labelData.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row == 2) {
            cell.contentView.alpha = 0.5;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        TWOJiaXiQuanModel *jiaXiModel = [jiaXiQuanArray objectAtIndex:indexPath.row];
        
//        加息券待兑付状态
        if ([[[jiaXiModel status] description] isEqualToString:@"1"]) {
            
            TWOWaitCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseTWO"];
            cell.imageWait.image = [UIImage imageNamed:@"待兑换加息券ios"];
            
            NSMutableAttributedString *percentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", [jiaXiModel incrMoney]]];
            NSRange qianRange = NSMakeRange(0, [[percentString string] rangeOfString:@"%"].location);
            [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:qianRange];
            [cell.labelPercent setAttributedText:percentString];
            cell.labelPercent.backgroundColor = [UIColor clearColor];
            
//            待兑付加息券frame值机型判断
            if (WIDTH_CONTROLLER_DEFAULT == 320) {
                cell.labelPercent.frame = CGRectMake(10, 56, 88, 40);
                cell.buttonWait.frame = CGRectMake(281, 16, 23, 127);
                cell.labelTiaoJian.frame = CGRectMake(100, 27, 170, 19);
                cell.labelEvery.frame = CGRectMake(100, 56, 170, 14);
                cell.laeblData.frame = CGRectMake(100, 81, 170, 12);
                cell.labelTime.frame = CGRectMake(100, 123, 170, 13);
                cell.laeblMoney.frame = CGRectMake(12, 140, 112, 13);
                cell.labelShuoMing.frame = CGRectMake(125, 139, 145, 13);
            } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
                cell.labelPercent.frame = CGRectMake(10, 56, 105, 40);
            } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
                cell.labelPercent.frame = CGRectMake(12, 56, 112, 40);
                cell.labelTiaoJian.frame = CGRectMake(130, 27, 220, 19);
                cell.labelEvery.frame = CGRectMake(130, 56, 220, 14);
                cell.laeblData.frame = CGRectMake(130, 81, 220, 12);
                cell.labelTime.frame = CGRectMake(130, 123, 220, 13);
                cell.labelShuoMing.frame = CGRectMake(175, 139, 175, 13);
                cell.laeblMoney.frame = CGRectMake(12, 140, 160, 13);
                cell.buttonWait.frame = CGRectMake(370, 17, 23, 127);
            }
            
            NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", [jiaXiModel investMoney]]];
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
            
            cell.laeblData.text = [NSString stringWithFormat:@"%@至%@有效", [jiaXiModel startDate], [jiaXiModel endDate]];
            cell.laeblData.backgroundColor = [UIColor clearColor];
            
            NSMutableAttributedString *qianMianString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待兑付金额:%@元", [jiaXiModel cashMoney]]];
            NSRange qianMianRange = NSMakeRange(0, 6);
            [qianMianString addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:qianMianRange];
            [qianMianString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:qianMianRange];
            NSRange houMianRange = NSMakeRange([[qianMianString string] length] - 1, 1);
            [qianMianString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:houMianRange];
            [qianMianString addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:houMianRange];
            [cell.laeblMoney setAttributedText:qianMianString];
            cell.laeblMoney.backgroundColor = [UIColor clearColor];
            
            cell.labelTime.text = [NSString stringWithFormat:@"产品到期日:%@", [jiaXiModel productDueDate]];
            cell.labelTime.backgroundColor = [UIColor clearColor];
            
            cell.labelShuoMing.text = @"(到期日后7个工作日内兑付至余额)";
            cell.labelShuoMing.backgroundColor = [UIColor clearColor];
            if (WIDTH_CONTROLLER_DEFAULT == 320) {
                cell.labelShuoMing.font = [UIFont fontWithName:@"CenturyGothic" size:9];
            }
            
            [cell.buttonWait setTitle:@"待\n兑\n付" forState:UIControlStateNormal];
            cell.buttonWait.titleLabel.numberOfLines = 3;
            cell.buttonWait.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            cell.buttonWait.backgroundColor = [UIColor clearColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            TWIJiaXiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseJia"];
            cell.imagePicture.image = [UIImage imageNamed:@"jiaxijuan"];
            
            NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", jiaXiModel.incrMoney]];
            NSRange signRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"%"].location);
            [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:signRange];
            NSRange baiRange = NSMakeRange([[moneyString string] length] - 1, 1);
            [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:baiRange];
            [cell.labelMoney setAttributedText:moneyString];
            cell.labelMoney.backgroundColor = [UIColor clearColor];
            
//            可使用加息券frame值机型判断
            if (WIDTH_CONTROLLER_DEFAULT == 320) {
                cell.labelMoney.frame = CGRectMake(10, 55, 88, 40);
                cell.labelTiaoJian.frame = CGRectMake(100, 27, 170, 19);
                cell.labelEvery.frame = CGRectMake(100, 56, 170, 14);
                cell.labelData.frame = CGRectMake(100, 110, 170, 12);
                cell.butCanUse.frame = CGRectMake(281, 10, 23, 127);
            } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
                cell.labelMoney.frame = CGRectMake(10, 55, 105, 40);
            } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
                cell.labelMoney.frame = CGRectMake(12, 55, 112, 40);
                cell.labelTiaoJian.frame = CGRectMake(130, 27, 220, 19);
                cell.labelEvery.frame = CGRectMake(130, 56, 220, 14);
                cell.labelData.frame = CGRectMake(130, 110, 220, 12);
                cell.butCanUse.frame = CGRectMake(370, 10, 23, 127);
            }
            
            NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", [jiaXiModel investMoney]]];
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
            
            [cell.butCanUse setTitle:@"可\n使\n用" forState:UIControlStateNormal];
            cell.butCanUse.titleLabel.numberOfLines = 3;
            cell.butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            cell.butCanUse.backgroundColor = [UIColor clearColor];
            
            cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", [jiaXiModel startDate], [jiaXiModel endDate]];
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
        TWOJiaXiQuanModel *model  = [jiaXiQuanArray objectAtIndex:indexPath.row];
        if ([[[model status] description] isEqualToString:@"1"]) {
            NSLog(@"高");
            return 160;
        } else {
            NSLog(@"低");
            return 140;
        }
    }
}

//红包按钮
- (void)redBagButtonClicked:(UIButton *)button
{
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    [buttonJiaXi setTitleColor:[UIColor changeColor] forState:UIControlStateNormal];
    buttonJiaXi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

//加息券按钮
- (void)jiaXiQuanButtonClicked:(UIButton *)button
{
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
    [butRedBag setTitleColor:[UIColor changeColor] forState:UIControlStateNormal];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        
        if (scrollView.contentOffset.x == WIDTH_CONTROLLER_DEFAULT) {
            
            [buttonJiaXi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            buttonJiaXi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
            [butRedBag setTitleColor:[UIColor changeColor] forState:UIControlStateNormal];
            butRedBag.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
            
        } else {
            
            if (scrollView.contentOffset.x == 0) {
                [butRedBag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                butRedBag.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:18];
                [buttonJiaXi setTitleColor:[UIColor changeColor] forState:UIControlStateNormal];
                buttonJiaXi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    butRedBag.hidden = YES;
    buttonJiaXi.hidden = YES;
}

#pragma mark 对接接口
#pragma mark --------------------------------

- (void)getMyRedPacketListFuction{
    NSDictionary *parmeter = @{@"curPage":@1,@"status":@0,@"pageSize":@10,@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyRedPacketList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"获取红包列表:getMyRedPacketList = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *redbagArray = [responseObject objectForKey:@"RedPacket"];
            for (NSDictionary *dataDic in redbagArray) {
                TWORedBagModel *redBagModel = [[TWORedBagModel alloc] init];
                [redBagModel setValuesForKeysWithDictionary:dataDic];
                [redBagArray addObject:redBagModel];
            }
            
            [self redBagViewHeadShow];
            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)getMyIncreaseListFuction
{
    NSDictionary *parmeter = @{@"curPage":@1 ,@"status":@"0,1" ,@"pageSize":@10 ,@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyIncreaseList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyIncreaseList = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"Increase"];
            for (NSDictionary *dataDic in dataArray) {
                jiaXiQuanModel = [[TWOJiaXiQuanModel alloc] init];
                [jiaXiQuanModel setValuesForKeysWithDictionary:dataDic];
                [jiaXiQuanArray addObject:jiaXiQuanModel];
            }
            
            [self jiaxiquanHead];
            [_tableViewJia reloadData];
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
