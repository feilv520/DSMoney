//
//  FDetailViewController.m
//  DSLC
//
//  Created by ios on 15/10/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FDetailViewController.h"
#import "define.h"
#import "FixInvestCell.h"
#import "BasicMessageCell.h"
#import "PlanCell.h"
#import "ThreeCell.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "MakeSureViewController.h"
#import "Calendar.h"

@interface FDetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *titleArr;
    Calendar *calendar;
    UIView *bView;
}
@property (nonatomic, strong) UIControl *viewBotton;
@end

@implementation FDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
    
    self.viewBotton = [[UIControl alloc] initWithFrame:CGRectMake(0, app.tabBarVC.view.frame.size.height - 49, WIDTH_CONTROLLER_DEFAULT, app.tabBarVC.view.frame.size.height)];
    [app.tabBarVC.view addSubview:self.viewBotton];
    self.viewBotton.backgroundColor = [UIColor greenColor];

    [self showBottonView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    titleArr = @[@"产品描述", @"资产安全", @"投资须知"];
    
    self.navigationItem.title = @"产品详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self showNavigationRetuenBack];
    [self showTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
    
    [self.viewBotton removeFromSuperview];
    
}

//修改导航栏的默认返回按钮
- (void)showNavigationRetuenBack
{
    UIImageView *imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImage *imageBack = [UIImage imageNamed:@"750产品111"];
    imageViewBack.image = imageBack;
    imageViewBack.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageViewBack];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBackBar:)];
    [imageViewBack addGestureRecognizer:tap];
}

//头部分区的tableView展示
- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 49) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 53)];
    _tableView.tableFooterView = viewFoot;
    viewFoot.backgroundColor = [UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
    
    UIImageView *imageSmallImg = [[UIImageView alloc] initWithFrame:CGRectMake(97, 18, 12, 12)];
    UIImage *imageSmall = [UIImage imageNamed:@"shouyeqiepian_21"];
    imageSmallImg.image = imageSmall;
    [viewFoot addSubview:imageSmallImg];
    
    UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(113, 14, 179, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:11] text:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:labelName];
    
    [_tableView registerNib:[UINib nibWithNibName:@"FixInvestCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [_tableView registerNib:[UINib nibWithNibName:@"BasicMessageCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [_tableView registerNib:[UINib nibWithNibName:@"PlanCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [_tableView registerNib:[UINib nibWithNibName:@"ThreeCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return 11;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 149;
        
    } else if (indexPath.section == 1) {
        
        return 217;
        
    } else if (indexPath.section == 2) {
        
        return 154;
    }
    
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        FixInvestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        if (cell == nil) {
            
            cell = [[FixInvestCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
            
        }
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.9;
        
        cell.labelMonth.text = @"3个月固定投资";
        cell.labelMonth.font = [UIFont systemFontOfSize:15];
        
        cell.labelBuyNum.text = @"已有362人购买";
        cell.labelBuyNum.textAlignment = NSTextAlignmentRight;
        cell.labelBuyNum.font = [UIFont systemFontOfSize:12];
        cell.labelBuyNum.textColor = [UIColor zitihui];
        
        NSMutableAttributedString *redString = [[NSMutableAttributedString alloc] initWithString:@"8.02%"];
        NSRange redLocation = NSMakeRange(0, [[redString string] rangeOfString:@"%"].location);
        [redString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:redLocation];
        [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:redLocation];
        NSRange percent = NSMakeRange([[redString string] length] - 1, 1);
        [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:percent];
        [cell.labelPercentage setAttributedText:redString];
        
        NSMutableAttributedString *dayString = [[NSMutableAttributedString alloc] initWithString:@"360天"];
        NSRange dayRange = NSMakeRange(0, [[dayString string] rangeOfString:@"天"].location);
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:dayRange];
        NSRange tianRange = NSMakeRange([[dayString string] length] - 1, 1);
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:tianRange];
        [cell.labelDayNum setAttributedText:dayString];
        cell.labelDayNum.textAlignment = NSTextAlignmentRight;
        
        cell.viewDiSe.backgroundColor = [UIColor qianhuise];
        
        cell.labelIncome.text = @"预期年化收益率";
        cell.labelIncome.textColor = [UIColor zitihui];
        cell.labelIncome.font = [UIFont systemFontOfSize:12];
        
        cell.labelDeadline.text = @"理财期限";
        cell.labelDeadline.textColor = [UIColor zitihui];
        cell.labelDeadline.font = [UIFont systemFontOfSize:12];
        cell.labelDeadline.textAlignment = NSTextAlignmentRight;
        
        cell.labelSurplus.text = [NSString stringWithFormat:@"%@%@", @"剩余总额:", @"24.6万"];
        cell.labelSurplus.textColor = [UIColor zitihui];
        cell.labelSurplus.font = [UIFont systemFontOfSize:12];
        cell.labelSurplus.backgroundColor = [UIColor clearColor];
        
        cell.labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.labelLine.alpha = 0.9;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 1) {
        
        BasicMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        
        if (cell == nil) {
            
            cell = [[BasicMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse2"];
        }
        
        cell.labelBaseMess.text = @"基本信息";
        cell.labelBaseMess.font = [UIFont systemFontOfSize:15];
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.alpha = 0.7;
        
        cell.labelName.text = @"产品名称";
        cell.labelName.textColor = [UIColor zitihui];
        cell.labelName.font = [UIFont systemFontOfSize:15];
        
        cell.nameContent.text = @"3个月固定资产";
        cell.nameContent.textColor = [UIColor zitihui];
        cell.nameContent.textAlignment = NSTextAlignmentRight;
        cell.nameContent.font = [UIFont systemFontOfSize:15];
        
        cell.labelNumber.text = @"产品编号";
        cell.labelNumber.textColor = [UIColor zitihui];
        cell.labelNumber.font = [UIFont systemFontOfSize:15];
        
        cell.numberContent.text = @"3M001";
        cell.numberContent.textColor = [UIColor zitihui];
        cell.numberContent.font = [UIFont systemFontOfSize:15];
        cell.numberContent.textAlignment = NSTextAlignmentRight;
        
        cell.labelInvestor.text = @"资产名称";
        cell.labelInvestor.textColor = [UIColor zitihui];
        cell.labelInvestor.font = [UIFont systemFontOfSize:15];
        
        cell.InvestorContent.text = @"国丞创投";
        cell.InvestorContent.textColor = [UIColor zitihui];
        cell.InvestorContent.font = [UIFont systemFontOfSize:15];
        cell.InvestorContent.textAlignment = NSTextAlignmentRight;
        
        cell.labelData.text = @"起息日";
        cell.labelData.textColor = [UIColor zitihui];
        cell.labelData.font = [UIFont systemFontOfSize:15];
        
        cell.labelIntraday.text = @"购买当天起息";
        cell.labelIntraday.textColor = [UIColor zitihui];
        cell.labelIntraday.font = [UIFont systemFontOfSize:15];
        cell.labelIntraday.textAlignment = NSTextAlignmentRight;
        
        cell.labelStyle.text = @"兑换方式";
        cell.labelStyle.textColor = [UIColor zitihui];
        cell.labelStyle.font = [UIFont systemFontOfSize:15];
        
        cell.labelIncome.text = @"到期兑付收益";
        cell.labelIncome.textColor = [UIColor zitihui];
        cell.labelIncome.font = [UIFont systemFontOfSize:15];
        cell.labelIncome.textAlignment = NSTextAlignmentRight;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else if (indexPath.section == 2) {
        
        PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        
        if (cell == nil) {
            
            cell = [[PlanCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse3"];
        }
        
        cell.labelPlan.text = @"投资计划";
        cell.labelPlan.textColor = [UIColor zitihui];
        cell.labelPlan.font = [UIFont systemFontOfSize:15];
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.7;
        
        cell.imageTimeZhou.image = [UIImage imageNamed:@"750chanpin"];
        
        cell.buyPlan.text = @"购买计划";
        cell.buyPlan.textColor = [UIColor zitihui];
        cell.buyPlan.font = [UIFont systemFontOfSize:12];
        
        cell.timeOne.text = @"2015-9-22";
        cell.timeOne.textColor = [UIColor zitihui];
        cell.timeOne.font = [UIFont systemFontOfSize:12];
        
        cell.beginDay.text = @"起息日";
        cell.beginDay.textColor = [UIColor zitihui];
        cell.beginDay.font = [UIFont systemFontOfSize:12];
        
        cell.rightNowTime.text = @"立即起息";
        cell.rightNowTime.textColor = [UIColor zitihui];
        cell.rightNowTime.font = [UIFont systemFontOfSize:12];
        
        cell.labelEndDay.text = @"结息日";
        cell.labelEndDay.textColor = [UIColor zitihui];
        cell.labelEndDay.font = [UIFont systemFontOfSize:12];
        
        cell.endTime.text = @"2015-9-24";
        cell.endTime.textColor = [UIColor zitihui];
        cell.endTime.font = [UIFont systemFontOfSize:12];
        
        cell.labelCash.text = @"兑付日";
        cell.labelCash.textColor = [UIColor zitihui];
        cell.labelCash.font = [UIFont systemFontOfSize:12];
        
        cell.cashDay.text = @"2015-9-25";
        cell.cashDay.textColor = [UIColor zitihui];
        cell.cashDay.font = [UIFont systemFontOfSize:12];
        
        cell.imageQuan.image = [UIImage imageNamed:@"750产品详情"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else {
        
    ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
    
    if (cell == nil) {
        
        cell = [[ThreeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse4"];
    }
    
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.imageRight.image = [UIImage imageNamed:@"7501111"];
    
    return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)returnBackBar:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

//底部计算器+投资视图
- (void)showBottonView
{
    UIView *viewSuan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT - 285, 49)];
    [self.viewBotton addSubview:viewSuan];
    viewSuan.backgroundColor = [UIColor colorWithRed:78/255 green:88/255 blue:97/255 alpha:1.0];
    
    UIButton *buttonCal = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCal.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT - 285, 49);
    [buttonCal setImage:[UIImage imageNamed:@"750产品详111"] forState:UIControlStateNormal];
    [buttonCal setImageEdgeInsets:UIEdgeInsetsMake(10, 30, 10, 30)];
    [buttonCal addTarget:self action:@selector(calendarView) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBotton addSubview:buttonCal];
    
    UIButton *butMakeSure = [UIButton buttonWithType:UIButtonTypeCustom];
    butMakeSure.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 285, 0, 285, 49);
    [self.viewBotton addSubview:butMakeSure];
    [butMakeSure setTitle:@"投资(1,000元起投)" forState:UIControlStateNormal];
    butMakeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    butMakeSure.backgroundColor = [UIColor daohanglan];
    [butMakeSure addTarget:self action:@selector(makeSureButton:) forControlEvents:UIControlEventTouchUpInside];
}

//确认投资按钮
- (void)makeSureButton:(UIButton *)button
{
    MakeSureViewController *makeSureVC = [[MakeSureViewController alloc] init];
    [self.navigationController pushViewController:makeSureVC animated:YES];
}

// 计算收益图层
- (void)calendarView{
    
    [bView removeFromSuperview];
    [calendar removeFromSuperview];
    
    bView = nil;
    calendar = nil;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (bView == nil) {
        bView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
        
        bView.backgroundColor = Color_Black;
        bView.alpha = 0.3;
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        
        [app.tabBarVC.view addSubview:bView];
        
    }
    
    if (calendar == nil) {
        NSBundle *rootBundle = [NSBundle mainBundle];
        
        calendar = (Calendar *)[[rootBundle loadNibNamed:@"Calendar" owner:nil options:nil] lastObject];
        calendar.frame = CGRectMake(38, 182, 301, 301);
        calendar.layer.masksToBounds = YES;
        calendar.layer.cornerRadius = 4.0;
        
        [calendar.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [app.tabBarVC.view addSubview:calendar];

    }

}

- (void)closeButton:(UIButton *)but{
    [bView removeFromSuperview];
    [calendar removeFromSuperview];
    
    bView = nil;
    calendar = nil;
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
