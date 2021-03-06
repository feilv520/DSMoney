//
//  TWORedBagViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWORedBagViewController.h"
#import "TWOUseRedBagCellMine.h"
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
    UIButton *butWhite;
    
//    接口返回红包列表数组
    NSMutableArray *redbagArray;
    NSInteger pageRedBag;
    NSInteger pageAddXiQuan;
    MJRefreshBackGifFooter *gifFooter;
    MJRefreshBackGifFooter *jiaFooter;
    BOOL moreFlag;
    BOOL jiaMoreFlag;
    
    BOOL switchFlag;
    NSString *canMakeNum;
    
    UIView *viewFoot;
    UIView *viewFootR;
}

@end

@implementation TWORedBagViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    butWhite.hidden = NO;
    butRedBag.hidden = NO;
    buttonJiaXi.hidden = NO;
    
    //摇一摇中奖纪录页面点击加息券传来2, 跳转我的加息券页面;
    if ([self.recordState isEqualToString:@"2"]) {
        [_scrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    pageRedBag = 1;
    pageAddXiQuan = 1;
    moreFlag = NO;
    jiaMoreFlag = NO;
    
    switchFlag = YES;
    
    redBagArray = [NSMutableArray array];
    jiaXiQuanArray = [NSMutableArray array];
    
    [self navigationTitleShow];
    [self commonShow];
    [self getMyIncreaseListFuction];
    [self getMyRedPacketListFuction];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

//没有红包的样式
- (void)noHaveRedBagShow
{
    UIButton *butBagUse = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 72 - 10, 10, 72, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"红包使用说明"];
    [_scrollView addSubview:butBagUse];
    butBagUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butBagUse addTarget:self action:@selector(redBagUseExplain:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 13.5, butBagUse.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [butBagUse addSubview:viewLine];
    
    UIImageView *imageNothing = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [_scrollView addSubview:imageNothing];
    
    UIView *viewHistory = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 96, 260/2 + 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 192, 14) backgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:viewHistory];
    
    UILabel *labelLeft = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 144, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"没有更多有效红包了, 查看"];
    [viewHistory addSubview:labelLeft];
    
    UIButton *buttonCheck = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewHistory.frame.size.width - 48, 0, 48, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"历史红包"];
    [viewHistory addSubview:buttonCheck];
    buttonCheck.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [buttonCheck addTarget:self action:@selector(buttonCheckHistoryRedBag:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine2 = [CreatView creatViewWithFrame:CGRectMake(0, buttonCheck.frame.size.height - 1, buttonCheck.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [buttonCheck addSubview:viewLine2];
}

//没有加息券的样式
- (void)noHaveJiaXiQuanShow
{
    UIButton *butJiaUse = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT*2 - 85 - 10, 10, 85, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"加息券使用说明"];
    [_scrollView addSubview:butJiaUse];
    butJiaUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    butJiaUse.tag = 66;
    [butJiaUse addTarget:self action:@selector(redBagUseExplain:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 13.5, butJiaUse.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [butJiaUse addSubview:viewLine];
    
    UIImageView *imageNothing = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT + (WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2), 78, 260/2, 260/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [_scrollView addSubview:imageNothing];
    
    UIView *viewHistory = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT +(WIDTH_CONTROLLER_DEFAULT/2 - 108), 260/2 + 80.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 216, 14) backgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:viewHistory];
    
    UILabel *labelLeft = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 156, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"没有更多有效加息券了, 查看"];
    [viewHistory addSubview:labelLeft];
    
    UIButton *buttonCheck = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewHistory.frame.size.width - 60, 0, 60, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"历史加息券"];
    [viewHistory addSubview:buttonCheck];
    buttonCheck.tag = 77;
    buttonCheck.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [buttonCheck addTarget:self action:@selector(buttonCheckHistoryRedBag:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine2 = [CreatView creatViewWithFrame:CGRectMake(0, buttonCheck.frame.size.height - 1, buttonCheck.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [buttonCheck addSubview:viewLine2];
}

//红包,加息券按钮页面的切换
- (void)navigationTitleShow
{
    butWhite = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 180)/2, 5, 180, 30) backgroundColor:[UIColor profitColor] textColor:nil titleText:nil];
    [self.navigationController.navigationBar addSubview:butWhite];
    butWhite.layer.cornerRadius = 15;
    butWhite.layer.masksToBounds = YES;
    butWhite.layer.borderColor = [[UIColor whiteColor] CGColor];
    butWhite.layer.borderWidth = 1;
    CGFloat widthButton = butWhite.frame.size.width;
    
    butRedBag = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, widthButton/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"红包"];
    [butWhite addSubview:butRedBag];
    butRedBag.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butRedBag.layer.cornerRadius = 15;
    butRedBag.layer.masksToBounds = YES;
    [butRedBag addTarget:self action:@selector(redBagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonJiaXi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(widthButton/2, 0, widthButton/2, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"加息券"];
    [butWhite addSubview:buttonJiaXi];
    buttonJiaXi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonJiaXi.layer.cornerRadius = 15;
    buttonJiaXi.layer.masksToBounds = YES;
    [buttonJiaXi addTarget:self action:@selector(jiaXiQuanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commonShow
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20)];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT*2, 1);
}

- (void)redBagTableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64 - 72) style:UITableViewStylePlain];
    [_scrollView addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tag = 700;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOUseRedBagCellMine" bundle:nil] forCellReuseIdentifier:@"reuseRedBag"];
    
    [self addTableViewWithFooter:_tableView];
    [self redBagViewHeadShow];
    [self redBagTabelViewFoot];
}

- (void)jiaXiQuanTableViewShow
{
    _tableViewJia = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 65, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64 - 72) style:UITableViewStylePlain];
    [_scrollView addSubview:_tableViewJia];
    _tableViewJia.dataSource = self;
    _tableViewJia.delegate = self;
    _tableViewJia.tag = 800;
    _tableViewJia.separatorColor = [UIColor clearColor];
    _tableViewJia.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];

    [_tableViewJia registerNib:[UINib nibWithNibName:@"TWIJiaXiQuanCell" bundle:nil] forCellReuseIdentifier:@"reuseJia"];
    [_tableViewJia registerNib:[UINib nibWithNibName:@"TWOWaitCashCell" bundle:nil] forCellReuseIdentifier:@"reuseTWO"];
    
    [self addTableViewWithFooter:_tableViewJia];
    [self jiaxiquanHead];
    [self jiaxiquanFoot];
}

- (void)redBagViewHeadShow
{
    UIView *viewHead = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 65) backgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:viewHead];
    
    butCanUse = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 36) backgroundColor:[UIColor redBagBankColor] textColor:[UIColor profitColor] titleText:nil];
    [viewHead addSubview:butCanUse];
    butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCanUse addTarget:self action:@selector(goToUseRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    红包使用说明按钮
    UIButton *butUseSHuo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 72, viewHead.frame.size.height - 16 -5, 72, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"红包使用说明"];
    [viewHead addSubview:butUseSHuo];
    butUseSHuo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butUseSHuo addTarget:self action:@selector(redBagUseExplain:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butLine = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 72, viewHead.frame.size.height - 2 - 6, 72, 1) backgroundColor:[UIColor profitColor] textColor:nil titleText:nil];
    [viewHead addSubview:butLine];
}

- (void)redBagTabelViewFoot
{
    viewFootR = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 96, _tableView.tableFooterView.frame.size.height - 40, 192, 14) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableFooterView addSubview:viewFootR];
    viewFootR.hidden = YES;
    
    UILabel *labelGray = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 144, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"没有更多有效红包了, 查看"];
    [viewFootR addSubview:labelGray];
    
    UIButton *butCheck = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewFootR.frame.size.width - 48, 0, 48, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"历史红包"];
    [viewFootR addSubview:butCheck];
    butCheck.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butCheck addTarget:self action:@selector(buttonCheckHistoryRedBag:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, butCheck.frame.size.height - 1, butCheck.frame.size.width, 0.5) backgroundColor:[UIColor profitColor]];
    [butCheck addSubview:viewLine];
}

- (void)jiaxiquanHead
{
    UIView *viewHead = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, 65) backgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:viewHead];
    
    UIButton *butCanUseJ = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 36) backgroundColor:[UIColor redBagBankColor] textColor:[UIColor profitColor] titleText:[NSString stringWithFormat:@"%@张可用加息券, 去使用>", canMakeNum]];
    [viewHead addSubview:butCanUseJ];
    butCanUseJ.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCanUseJ addTarget:self action:@selector(goToUseRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    加息券使用说明按钮
    UIButton *butUseSHuo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 84, viewHead.frame.size.height - 16 - 5, 84, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"加息券使用说明"];
    [viewHead addSubview:butUseSHuo];
    butUseSHuo.tag = 66;
    butUseSHuo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butUseSHuo addTarget:self action:@selector(redBagUseExplain:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butLine = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 9 - 84, viewHead.frame.size.height - 2 - 6, 84, 1) backgroundColor:[UIColor profitColor] textColor:nil titleText:nil];
    [viewHead addSubview:butLine];
}

- (void)jiaxiquanFoot
{
    viewFoot = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 108, _tableViewJia.tableFooterView.frame.size.height - 40, 216, 14) backgroundColor:[UIColor whiteColor]];
    [_tableViewJia.tableFooterView addSubview:viewFoot];
    viewFoot.hidden = YES;
    
    UILabel *labelGray = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 156, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"没有更多有效加息券了, 查看"];
    [viewFoot addSubview:labelGray];
    
    UIButton *butCheck = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewFoot.frame.size.width - 60, 0, 60, 14) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"历史加息券"];
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
        
        TWOUseRedBagCellMine *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseRedBag"];
        
        cell.imagePicture.image = [UIImage imageNamed:@"twohongbao"];
        
        TWORedBagModel *redBagModel = [redBagArray objectAtIndex:indexPath.row];
        
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", [redBagModel redPacketMoney]]];
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
        
        if ([[[redBagModel applyTypeName] description] isEqualToString:@"0"]) {
            cell.labelEvery.text = @"所有产品适用";
        } else {
            cell.labelEvery.text = [NSString stringWithFormat:@"期限%@天及以上产品可用", [redBagModel applyTypeName]];
        }
        cell.labelEvery.backgroundColor = [UIColor clearColor];
        
        //红包只有'可使用'状态
        [cell.butCanUse setTitle:@"可\n使\n用" forState:UIControlStateNormal];
        
        cell.butCanUse.titleLabel.numberOfLines = 3;
        cell.butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.butCanUse.backgroundColor = [UIColor clearColor];
        
        cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", [redBagModel startDate], [redBagModel endDate]];
        cell.labelData.backgroundColor = [UIColor clearColor];
        
        if ([[[redBagModel redPacketType] description] isEqualToString:@"7"]) {

            cell.labelData.text = @"请尽快使用";
            cell.labelEvery.text = @"仅可用于新手专享";
            cell.labelTiaoJian.text = @"新手体验金";
            
            cell.labelTiaoJian.textColor = [UIColor moneyColor];
            cell.labelTiaoJian.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        TWOJiaXiQuanModel *jiaXiModel = [jiaXiQuanArray objectAtIndex:indexPath.row];
        
//        加息券待兑付状态
        if ([[[jiaXiModel status] description] isEqualToString:@"1"]) {
            
            TWOWaitCashCell *cell = [_tableViewJia dequeueReusableCellWithIdentifier:@"reuseTWO"];
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
                cell.laeblMoney.frame = CGRectMake(125, 139, 145, 13);
            } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
                cell.labelPercent.frame = CGRectMake(10, 56, 105, 40);
            } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
                cell.labelPercent.frame = CGRectMake(12, 56, 112, 40);
                cell.labelTiaoJian.frame = CGRectMake(130, 27, 220, 19);
                cell.labelEvery.frame = CGRectMake(130, 56, 220, 14);
                cell.laeblData.frame = CGRectMake(130, 81, 220, 12);
                cell.labelTime.frame = CGRectMake(130, 123, 220, 13);
                cell.laeblMoney.frame = CGRectMake(175, 139, 175, 13);
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
            
            if ([[[jiaXiModel applyTypeName] description] isEqualToString:@"0"]) {
                cell.labelEvery.text = @"所有产品适用";
            } else {
                cell.labelEvery.text = [NSString stringWithFormat:@"期限%@天及以上产品可用", [jiaXiModel applyTypeName]];
            }

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
            
            [cell.buttonWait setTitle:@"待\n兑\n付" forState:UIControlStateNormal];
            cell.buttonWait.titleLabel.numberOfLines = 3;
            cell.buttonWait.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            cell.buttonWait.backgroundColor = [UIColor clearColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            TWIJiaXiQuanCell *cell = [_tableViewJia dequeueReusableCellWithIdentifier:@"reuseJia"];
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
            
            if ([[[jiaXiModel applyTypeName] description] isEqualToString:@"0"]) {
                cell.labelEvery.text = @"所有产品适用";
            } else {
                cell.labelEvery.text = [NSString stringWithFormat:@"期限%@天及以上产品可用", [jiaXiModel applyTypeName]];
            }
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
            return 160;
        } else {
            return 140;
        }
    }
}

//红包按钮
- (void)redBagButtonClicked:(UIButton *)button
{
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    
    buttonJiaXi.backgroundColor = [UIColor clearColor];
    [buttonJiaXi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        switchFlag = YES;
    }];
}

//加息券按钮
- (void)jiaXiQuanButtonClicked:(UIButton *)button
{
    [butRedBag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butRedBag.backgroundColor = [UIColor clearColor];
    
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _scrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
    } completion:^(BOOL finished) {
        switchFlag = NO;
    }];
}

//去使用可用红包页面
- (void)goToUseRedBagButton:(UIButton *)button
{
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
    
    [app.tabBarVC setTabbarViewHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
            
            [buttonJiaXi setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
            buttonJiaXi.backgroundColor = [UIColor whiteColor];
            [butRedBag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            butRedBag.backgroundColor = [UIColor clearColor];
            
        } else {
            
            if (scrollView.contentOffset.x == 0) {
                [butRedBag setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
                butRedBag.backgroundColor = [UIColor whiteColor];
                [buttonJiaXi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                buttonJiaXi.backgroundColor = [UIColor clearColor];
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    butWhite.hidden = YES;
    butRedBag.hidden = YES;
    buttonJiaXi.hidden = YES;
    
    //摇一摇中奖纪录页面点击加息券传来2, 跳转我的加息券页面 点击返回偏移量要归位;
    if ([self.recordState isEqualToString:@"2"]) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark 对接接口
#pragma mark --------------------------------

// 获得红包接口
- (void)getMyRedPacketListFuction{
    NSDictionary *parmeter = @{@"curPage":[NSString stringWithFormat:@"%ld", (long)pageRedBag],@"status":@0,@"pageSize":@10,@"token":[self.flagDic objectForKey:@"token"],@"pageSize":@10};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyRedPacketList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [gifFooter endRefreshing];
        
        [self loadingWithHidden:YES];
        NSLog(@"获取红包列表:getMyRedPacketList = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            redbagArray = [responseObject objectForKey:@"RedPacket"];
            for (NSDictionary *dataDic in redbagArray) {
                TWORedBagModel *redBagModel = [[TWORedBagModel alloc] init];
                [redBagModel setValuesForKeysWithDictionary:dataDic];
                [redBagArray addObject:redBagModel];
            }
            
            // 这个是按结束时间排序
            redBagArray = (NSMutableArray *)[redBagArray sortedArrayUsingComparator:^NSComparisonResult(TWORedBagModel *obj1, TWORedBagModel *obj2) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *date1 = [formatter dateFromString:[obj1 endDate]];
                NSDate *date2 = [formatter dateFromString:[obj2 endDate]];
                NSComparisonResult result = [date1 compare:date2];
                return result == NSOrderedDescending;
            }];
            
            redBagArray = [redBagArray mutableCopy];
            
            // 这个排序是金额大小的排序
            NSComparator finderSort = ^(TWORedBagModel *obje1,TWORedBagModel *obje2){
                
                if ([[obje1 redPacketMoney] integerValue] > [[obje2 redPacketMoney] integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }else if ([[obje1 redPacketMoney] integerValue] < [[obje2 redPacketMoney] integerValue]){
                    return (NSComparisonResult)NSOrderedAscending;
                }
                else
                    return (NSComparisonResult)NSOrderedSame;
            };
            
            NSArray *resultArray = [redBagArray sortedArrayUsingComparator:finderSort];
            
            redBagArray = [resultArray mutableCopy];
            
            [gifFooter endRefreshing];
            
            //判断有无红包 调用不同的页面样式
            if (pageRedBag == 1) {
                if (redBagArray.count == 0) {
                    [self noHaveRedBagShow];
                } else {
                    [self redBagTableViewShow];
                }
                
            } else {
                [_tableView reloadData];
            }
            
            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                moreFlag = YES;
                viewFootR.hidden = NO;
            }
            
            [butCanUse setTitle:[NSString stringWithFormat:@"%@张可用红包,去使用>", [responseObject objectForKey:@"redPacketCount"]] forState:UIControlStateNormal];

        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

// 获得加息券接口
- (void)getMyIncreaseListFuction
{
    NSDictionary *parmeter = @{@"curPage":[NSString stringWithFormat:@"%ld", (long)pageAddXiQuan] ,@"status":@"0,1" ,@"pageSize":@10 ,@"token":[self.flagDic objectForKey:@"token"],@"pageSize":@1000};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyIncreaseList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        NSLog(@"获取加息券列表 = %@",responseObject);
        
        [jiaFooter endRefreshing];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            canMakeNum = [responseObject objectForKey:@"incrCount"];
            NSMutableArray *dataArray = [responseObject objectForKey:@"Increase"];
            for (NSDictionary *dataDic in dataArray) {
                jiaXiQuanModel = [[TWOJiaXiQuanModel alloc] init];
                [jiaXiQuanModel setValuesForKeysWithDictionary:dataDic];
                [jiaXiQuanArray addObject:jiaXiQuanModel];
            }
            
            //判断有无加息券 调用不同的页面样式
            if (pageAddXiQuan == 1) {
                if (dataArray.count == 0) {
                    [self noHaveJiaXiQuanShow];
                } else {
                    [self jiaXiQuanTableViewShow];
                }
            } else {
                [_tableViewJia reloadData];
            }
            
            if ([[[responseObject objectForKey:@"currPage"] description] isEqualToString:[[responseObject objectForKey:@"totalPage"] description]]) {
                jiaMoreFlag = YES;
                viewFoot.hidden = NO;
            }
        } else {

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

//加载的方法
- (void)loadMoreData:(MJRefreshBackGifFooter *)footer
{
    if (switchFlag) {
        
        gifFooter = footer;
        
        if (moreFlag) {
            [gifFooter endRefreshing];
        } else {
            pageRedBag++;
            [self getMyRedPacketListFuction];
        }
        
    } else {
        
        jiaFooter = footer;
        if (jiaMoreFlag) {
            [jiaFooter endRefreshing];
        } else {
            pageAddXiQuan++;
            [self getMyIncreaseListFuction];
        }
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
