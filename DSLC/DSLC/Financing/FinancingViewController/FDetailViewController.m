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
#import "FDescriptionViewController.h"
#import "RecordViewController.h"
#import "InvestNoticeViewController.h"
#import "ProductDetailModel.h"
#import "MonkeyViewController.h"
#import "TDescriptionCell.h"
#import "TRiskGradeViewController.h"
#import "TMakeSureViewController.h"
#import "UsufructAssignmentViewController.h"

@interface FDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITableView *_tableView;
    NSArray *titleArr;
    Calendar *calendar;
    UIButton *bView;
    UIView *viewSuan;
    
    UIButton *butMakeSure;
    NSDictionary *dataDic;
    
    NSInteger isOrder;
    
    UIButton *butCountDown;
    UILabel *labelRisk;
}
@property (nonatomic, strong) UIControl *viewBotton;
@property (nonatomic, strong) ProductDetailModel *detailM;
@property (nonatomic, strong) NSString *residueMoney;
@property (nonatomic, strong) NSString *buyNumber;
@property (nonatomic, strong) NSDictionary *flagLogin;

@end

@implementation FDetailViewController

- (NSDictionary *)flagLogin{
    if (_flagLogin == nil) {
        if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
            [FileOfManage createWithFile:@"isLogin.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
        }
    }
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
    self.flagLogin = dic;
    return _flagLogin;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_viewBotton setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (self.viewBotton == nil) {
        self.viewBotton = [[UIControl alloc] initWithFrame:CGRectMake(0, app.tabBarVC.view.frame.size.height - 49, WIDTH_CONTROLLER_DEFAULT, app.tabBarVC.view.frame.size.height)];
        [app.tabBarVC.view addSubview:self.viewBotton];
        self.viewBotton.backgroundColor = [UIColor huibai];
    } else {
        self.viewBotton.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getProductDetail];
    
    [self loadingWithView:self.view loadingFlag:NO height:120.0];
    
    self.view.backgroundColor = [UIColor huibai];

    titleArr = @[@"投资记录", @"风险等级"];
    
    [self.navigationItem setTitle:@"产品详情"];
    
    butCountDown = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((self.view.frame.size.width - 20)/2, 0, (self.view.frame.size.width - 20)/2, 29) backgroundColor:[UIColor greenColor] textColor:[UIColor zitihui] titleText:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whatRisk:) name:@"risk" object:nil];
    
    labelRisk = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 25 - 60, 10, 60, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
}

- (void)whatRisk:(NSNotification *)notice
{
    labelRisk.text = [notice object];
}

//头部分区的tableView展示
- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 28) style:UITableViewStyleGrouped]; //49
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 53)];
    _tableView.tableFooterView = viewFoot;
    viewFoot.backgroundColor = [UIColor huibai];
    _tableView.separatorColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"FixInvestCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [_tableView registerNib:[UINib nibWithNibName:@"BasicMessageCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [_tableView registerNib:[UINib nibWithNibName:@"PlanCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [_tableView registerNib:[UINib nibWithNibName:@"ThreeCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
    [_tableView registerNib:[UINib nibWithNibName:@"TDescriptionCell" bundle:nil] forCellReuseIdentifier:@"reuseTwo"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 149;
        
    } else if (indexPath.section == 1) {
        
        return 160;
        
    } else if (indexPath.section == 2) {
        
        return 120;
        
    } else if (indexPath.section == 3) {
        
        return 154;
    }
    
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        FixInvestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.9;
        
        if (self.estimate == NO) {
            
            cell.labelMonth.text = @"新手专享";
            
        } else {
            
            cell.labelMonth.text = [self.detailM productName];
            
        }
        
        cell.labelMonth.font = [UIFont systemFontOfSize:15];
        
//        cell.labelBuyNum.text = [NSString stringWithFormat:@"已有%@人购买",self.buyNumber];
        cell.labelBuyNum.textAlignment = NSTextAlignmentRight;
        cell.labelBuyNum.font = [UIFont systemFontOfSize:12];
        cell.labelBuyNum.textColor = [UIColor zitihui];
        cell.labelBuyNum.text = @"投资须知";
        
        [cell.butTouZi addTarget:self action:@selector(touzixuzhi:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.labelPercentage.text = [self.detailM productAnnualYield];
        cell.labelPercentage.textColor = [UIColor daohanglan];
        cell.labelPercentage.font = [UIFont fontWithName:@"CenturyGothic" size:17];
        
        cell.labelDayNum.text = [self.detailM productPeriod];
        cell.labelDayNum.font = [UIFont fontWithName:@"CenturyGothic" size:17];
        
        cell.viewDiSe.backgroundColor = [UIColor qianhuise];
        
        cell.labelIncome.text = @"预期年化(%)";
        cell.labelIncome.textColor = [UIColor zitihui];
        cell.labelIncome.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelDeadline.text = @"理财期限(天)";
        cell.labelDeadline.textColor = [UIColor zitihui];
        cell.labelDeadline.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelDeadline.textAlignment = NSTextAlignmentCenter;
        
        cell.labelSurplus.text = [NSString stringWithFormat:@" %@%@%@", @"剩余总额:", self.residueMoney, @"元"];
        cell.labelSurplus.textColor = [UIColor zitihui];
        cell.labelSurplus.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelSurplus.backgroundColor = [UIColor clearColor];
        
//        固收已售完时显示倒计时
        if (self.pandaun == YES) {
            
            if ([self.residueMoney isEqualToString:@"0.00"]) {
                
                cell.progressView.hidden = YES;
                
                [cell.butCountDown setImage:[UIImage imageNamed:@"61-拷贝"] forState:UIControlStateNormal];
                [cell.butCountDown setTitle:[NSString stringWithFormat:@" %@ %@", @"倒计时", @"12:12:12"] forState:UIControlStateNormal];
                
            } else {
                
                cell.progressView.hidden = NO;
                cell.butCountDown.hidden = YES;
                
                [cell.progressView setProgress:1 - [self.residueMoney floatValue] / [self.detailM.productInitLimit floatValue] animated:NO];
                
            }
            
//            新手专享倒计时
        } else if (self.estimate == NO) {
            
            if ([self.residueMoney isEqualToString:@"0.00"]) {
            
                cell.progressView.hidden = YES;
                
                [cell.butCountDown setImage:[UIImage imageNamed:@"61-拷贝"] forState:UIControlStateNormal];
                [cell.butCountDown setTitle:[NSString stringWithFormat:@" %@ %@", @"倒计时", @"12:12:12"] forState:UIControlStateNormal];
                
//            火爆专区非新手专享没剩余时要隐藏
            } else {
                
                cell.butCountDown.hidden = YES;
                cell.progressView.hidden = NO;
                
                [cell.progressView setProgress:1 - [self.residueMoney floatValue] / [self.detailM.productInitLimit floatValue] animated:NO];
            }
           
//            其他不用显示倒计时要隐藏
        } else {
            
            cell.progressView.hidden = NO;
            cell.butCountDown.hidden = YES;
            
            [cell.progressView setProgress:1 - [self.residueMoney floatValue] / [self.detailM.productInitLimit floatValue] animated:NO];
        }
        
        [cell.butCountDown setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        cell.butCountDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        [cell.butCountDown setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        
        cell.labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.labelLine.alpha = 0.9;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 1) {
        
        BasicMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        
        cell.labelBaseMess.text = @"基本信息";
        cell.labelBaseMess.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.alpha = 0.7;
        
        cell.imageOne.image = [UIImage imageNamed:@"iconfont-jixifangshi"];
        cell.imageTwo.image = [UIImage imageNamed:@"iconfont-shijian"];
        cell.imageThree.image = [UIImage imageNamed:@"iconfont-fenpei"];
        
        cell.labelOne.textColor = [UIColor zitihui];
        cell.labelOne.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelOne.text = @"T+1计算";
        
        cell.labelTwo.textColor = [UIColor zitihui];
        cell.labelTwo.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTwo.text = @"到期日T+1到账";
        
        cell.labelThree.textColor = [UIColor zitihui];
        cell.labelThree.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelThree.text = @"兑付本金加收益";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else if (indexPath.section == 2) {
        
        TDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseTwo"];
        
        cell.labelDescription.text = @"产品描述";
        cell.labelDescription.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.labelLine.alpha = 0.7;
        
        cell.labelContent.text = @"大圣理财目前所有固定收益类产品收益权全部来自四大国有资产管理公司，资产安全，收益稳健。自购买当日起T+1日起息到期后兑付本金收益T+1日到账。";
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelContent.numberOfLines = 0;
        cell.labelContent.textColor = [UIColor zitihui];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 3) {
        
        PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        
        cell.labelPlan.text = @"投资计划";
        cell.labelPlan.textColor = [UIColor zitihui];
        cell.labelPlan.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.7;
        
        cell.imageTimeZhou.image = [UIImage imageNamed:@"750chanpin"];
        
        cell.buyPlan.text = @"购买时间";
        cell.buyPlan.textColor = [UIColor zitihui];
        cell.buyPlan.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        
        cell.timeOne.text = dateString;
        cell.timeOne.textColor = [UIColor zitihui];
        cell.timeOne.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.beginDay.text = @"起息日";
        cell.beginDay.textColor = [UIColor zitihui];
        cell.beginDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.rightNowTime.text = [self.detailM beginTime];
        cell.rightNowTime.textColor = [UIColor zitihui];
        cell.rightNowTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelEndDay.text = @"结息日";
        cell.labelEndDay.textColor = [UIColor zitihui];
        cell.labelEndDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.endTime.text = [self.detailM endTime];
        cell.endTime.textColor = [UIColor zitihui];
        cell.endTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelCash.text = @"预计到账日";
        cell.labelCash.textColor = [UIColor zitihui];
        cell.labelCash.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.cashDay.text = [self.detailM cashTime];
        cell.cashDay.textColor = [UIColor zitihui];
        cell.cashDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.imageQuan.image = [UIImage imageNamed:@"750产品详情"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else {
        
    ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
    
    if (cell == nil) {
        
        cell = [[ThreeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse4"];
    }
    
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.section - 4];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
    cell.imageRight.image = [UIImage imageNamed:@"7501111"];
        
        if (indexPath.section == 5) {
            
            [cell addSubview:labelRisk];
        }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 4) {
        
        RecordViewController *recordVC = [[RecordViewController alloc] init];
        recordVC.idString = self.idString;
        [self.navigationController pushViewController:recordVC animated:YES];
        
    } else if (indexPath.section == 5) {
        
        TRiskGradeViewController *riskGrade = [[TRiskGradeViewController alloc] init];
        [self.navigationController pushViewController:riskGrade animated:YES];
    }
}

- (void)returnBackBar:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

//底部计算器+投资视图
- (void)showBottonView
{
    viewSuan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT/4, 49)];
    [self.viewBotton addSubview:viewSuan];
    viewSuan.backgroundColor = [UIColor colorWithRed:78/255 green:88/255 blue:97/255 alpha:1.0];
    
    UIButton *buttonCal = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCal.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT/4, 49);
    [buttonCal setImage:[UIImage imageNamed:@"750产品详111"] forState:UIControlStateNormal];
    [buttonCal setImageEdgeInsets:UIEdgeInsetsMake(10, 30, 10, 30)];
    buttonCal.backgroundColor = [UIColor colorWithRed:78/255 green:88/255 blue:97/255 alpha:1.0];
    [buttonCal addTarget:self action:@selector(calendarView) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBotton addSubview:buttonCal];
    
    butMakeSure = [UIButton buttonWithType:UIButtonTypeCustom];
    butMakeSure.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/4, 0, WIDTH_CONTROLLER_DEFAULT/4*3, 49);
    [self.viewBotton addSubview:butMakeSure];
    butMakeSure.tag = 9080;
    
//    勾选协议
    
    UIButton *buttonGou = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 8, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [_tableView.tableFooterView addSubview:buttonGou];
    [buttonGou setBackgroundImage:[UIImage imageNamed:@"iconfont-dui-2"] forState:UIControlStateNormal];
    buttonGou.tag = 2000;
    [buttonGou addTarget:self action:@selector(shifouGouXuan:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelFront = [CreatView creatWithLabelFrame:CGRectMake(22, 0, 116, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:10] text:@" 我已阅读并同意相关协议"];
    [_tableView.tableFooterView addSubview:labelFront];
    
    UIButton *buttonXuan = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(138, 0, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor chongzhiColor] titleText:@"《产品收益权转让及服务协议》"];
    [_tableView.tableFooterView addSubview:buttonXuan];
    buttonXuan.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:10];
    buttonXuan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [buttonXuan addTarget:self action:@selector(buttonCheck:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.estimate == NO) {
        
        if ([self.residueMoney isEqualToString:@"0.00"]) {
            if ([[self.detailM isOrder] isEqualToNumber:[NSNumber numberWithInt:0]]) {
                [butMakeSure setTitle:@"预约" forState:UIControlStateNormal];
                [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
                butMakeSure.enabled = YES;
                
            } else {
                [butMakeSure setTitle:@"已预约" forState:UIControlStateNormal];
                [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
                butMakeSure.enabled = NO;
            }
        } else {
            butMakeSure.enabled = YES;
            [butMakeSure setTitle:@"投资(可使用5,000体验金)" forState:UIControlStateNormal];
            [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        }
        
    } else {
        NSLog(@"%@",self.residueMoney);
        if ([self.residueMoney isEqualToString:@"0.00"]) {
            if ([[self.detailM productType] isEqualToString:@"1"]) {
                if ([[self.detailM isOrder] isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    [butMakeSure setTitle:@"预约" forState:UIControlStateNormal];
                    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
                } else {
                    [butMakeSure setTitle:@"已预约" forState:UIControlStateNormal];
                    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
                }
            } else {
//                [butMakeSure setTitle:[NSString stringWithFormat:@"%@%@%@", @"投资(",[dataDic objectForKey:@"amountMin"], @"元起投)"] forState:UIControlStateNormal];
                [butMakeSure setTitle:@"已售罄" forState:UIControlStateNormal];
                [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
                [butMakeSure setUserInteractionEnabled:NO];
            }
        } else {
            [butMakeSure setTitle:[NSString stringWithFormat:@"%@%@%@", @"投资(",[dataDic objectForKey:@"amountMin"], @"元起投)"] forState:UIControlStateNormal];
            [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        }
    }
    
    butMakeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [butMakeSure addTarget:self action:@selector(makeSureButton:) forControlEvents:UIControlEventTouchUpInside];
}

//查看协议
- (void)buttonCheck:(UIButton *)button
{
    UsufructAssignmentViewController *usufruct = [[UsufructAssignmentViewController alloc] init];
    [self.navigationController pushViewController:usufruct animated:YES];
}

//勾选协议按钮
- (void)shifouGouXuan:(UIButton *)button
{
    if (button.tag == 2000) {
        
        [button setImage:[UIImage imageNamed:@"iconfont-dui-2111"] forState:UIControlStateNormal];
        button.tag = 3000;
        butMakeSure.enabled = NO;
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        
    } else {
        
        butMakeSure.enabled = YES;
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"iconfont-dui-2"] forState:UIControlStateNormal];
        button.tag = 2000;
        
    }
}

//确认投资按钮
- (void)makeSureButton:(UIButton *)button
{
    if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
        return ;
    }
    
    if ([self.residueMoney isEqualToString:@"0.00"]) {
        [self orderProduct];
        return;
    } else if ([self.residueMoney floatValue] < [[self.detailM amountMin] floatValue]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"剩余金额已小于起投金额,不能投资此产品"];
        return;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    if ([dic objectForKey:@"token"] != nil) {
    
        NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyAccountInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            
            if ([[responseObject objectForKey:@"result"] integerValue] == 400) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];

            } else {
            
                if (![[[dataDic objectForKey:@"productType"] description] isEqualToString:@"3"]) {
                        
                    TMakeSureViewController *makeSureVC = [[TMakeSureViewController alloc] init];
                    makeSureVC.decide = YES;
                    makeSureVC.detailM = self.detailM;
                    makeSureVC.residueMoney = self.residueMoney;
                    [self.navigationController pushViewController:makeSureVC animated:YES];
                    
                    [MobClick event:@"makeSure"];

                    [self submitLoadingWithHidden:YES];
                    
                } else {
                            
                    MakeSureViewController *makeSureVC = [[MakeSureViewController alloc] init];
                    makeSureVC.decide = NO;
                    makeSureVC.nHand = self.nHand;
                    makeSureVC.detailM = self.detailM;
                    makeSureVC.residueMoney = self.residueMoney;
                    [self.navigationController pushViewController:makeSureVC animated:YES];
                
                    [self submitLoadingWithHidden:YES];
                        
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@", error);
            
        }];
    } else {
        [self submitLoadingWithHidden:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
    }
    
}

// 计算收益图层
- (void)calendarView
{
    
    [bView removeFromSuperview];
    [calendar removeFromSuperview];
    
    bView = nil;
    calendar = nil;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (bView == nil) {
        bView = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:Color_Black textColor:nil titleText:nil];
        
        bView.alpha = 0.3;
        [bView addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [app.tabBarVC.view addSubview:bView];
        
    }
    
    if (calendar == nil) {
        NSBundle *rootBundle = [NSBundle mainBundle];
        
        calendar = (Calendar *)[[rootBundle loadNibNamed:@"Calendar" owner:nil options:nil] lastObject];
        
        CGFloat margin_x = (38 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
        CGFloat margin_y = (182 / 667.0) * HEIGHT_CONTROLLER_DEFAULT;
        CGFloat width = (301 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
        
        if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
            margin_y -= 30;
        }
        
        calendar.frame = CGRectMake(margin_x, margin_y, width, 246);
        calendar.layer.masksToBounds = YES;
        calendar.layer.cornerRadius = 4.0;
        
//        calendar.inputMoney.tag = 888;
        calendar.inputMoney.delegate = self;
        [calendar.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
//        [calendar.calButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
//        [calendar.calButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
//        [calendar.calButton addTarget:self action:@selector(calButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        calendar.viewDown.backgroundColor = [UIColor shurukuangColor];
        calendar.viewDown.layer.cornerRadius = 4;
        calendar.viewDown.layer.masksToBounds = YES;
        calendar.viewDown.layer.borderColor = [[UIColor shurukuangBian] CGColor];
        calendar.viewDown.layer.borderWidth = 0.5;
        
        calendar.inputMoney.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
        calendar.inputMoney.leftViewMode = UITextFieldViewModeAlways;
        calendar.inputMoney.tintColor = [UIColor grayColor];
        calendar.inputMoney.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [calendar.inputMoney addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        
        calendar.yearLv.text = [NSString stringWithFormat:@"%@%%",[self.detailM productAnnualYield]];
        
        NSString *daysLimitString = @"0";
        NSString *daysPeriodString = @"0";
        
        if (![[self.detailM productDaysLimit] isEqualToString:@"0"]) {
            daysLimitString = [self.detailM productDaysLimit];
        }
        
        if (![[self.detailM productPeriod] isEqualToString:@"0"]) {
            daysPeriodString = [self.detailM productPeriod];
        }
        
        if ([[self.detailM productType] isEqualToString:@"2"])
            calendar.dayLabel.text = [NSString stringWithFormat:@"%@天",daysLimitString];
        else
            calendar.dayLabel.text = [NSString stringWithFormat:@"%@天",daysPeriodString];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [calendar addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(returnKeyboard:)];
        
        [app.tabBarVC.view addSubview:calendar];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 9) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)textFiledEditChange:(UITextField *)textField
{
    calendar.totalLabel.text = [NSString stringWithFormat:@"%.2f元",[calendar.inputMoney.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue] / 36500.0];
}

- (void)returnKeyboard:(UITapGestureRecognizer *)tap
{
    [calendar endEditing:YES];
    
//    [UIView animateWithDuration:0.5f animations:^{
//        CGFloat margin_x = (38 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
//        CGFloat margin_y = (182 / 667.0) * HEIGHT_CONTROLLER_DEFAULT;
//        CGFloat width = (301 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
//        
//        if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
//
//        }
//        
//        calendar.frame = CGRectMake(margin_x, margin_y - 40, width, 301);
//    }];

}

//计算按钮
- (void)calButtonAction:(id)sender
{
    if (calendar.inputMoney.text == nil) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入投资金额"];
    } else {
    
        calendar.totalLabel.text = [NSString stringWithFormat:@"%.2f",[calendar.inputMoney.text floatValue] * [[self.detailM productAnnualYield] floatValue] * ([calendar.dayLabel.text floatValue] / 36500.0)];
    }
}

- (void)closeButton:(UIButton *)but{
    [bView removeFromSuperview];
    [calendar removeFromSuperview];
    
    bView = nil;
    calendar = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5f animations:^{
        CGFloat margin_x = (38 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
        CGFloat margin_y = (182 / 667.0) * HEIGHT_CONTROLLER_DEFAULT;
        CGFloat width = (301 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
        
        if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
            margin_y -= 30;
        }
        
        calendar.frame = CGRectMake(margin_x, margin_y - 40, width, 246);
    }];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductDetail{
    NSDictionary *parameter = @{@"productId":self.idString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductDetail" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"产品详情ppppppppppppppp%@",responseObject);
        
        [self loadingWithHidden:YES];
        
        self.residueMoney = [responseObject objectForKey:@"residueMoney"];
        self.buyNumber = [responseObject objectForKey:@"buyCount"];
        
        self.detailM = [[ProductDetailModel alloc] init];
        dataDic = [responseObject objectForKey:@"Product"];
        [self.detailM setValuesForKeysWithDictionary:dataDic];
        
        [self showTableView];
        [self showBottonView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 网络请求方法
#pragma mark -----------------------------

// 预定产品
- (void)orderProduct{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameters = @{@"productId":[self.detailM productId],@"productType":[self.detailM productType],@"token":[dic objectForKey:@"token"]};
    
    NSLog(@"%@",parameters);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/orderProduct" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"orderProduct = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已预约"];
            
            butMakeSure.userInteractionEnabled = NO;
            [butMakeSure setTitle:@"已预约" forState:UIControlStateNormal];
            [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        } else {
            [ProgressHUD showMessage:@"请先登录,然后再预约" Width:100 High:20];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)touzixuzhi:(UITapGestureRecognizer *)tap{
    InvestNoticeViewController *investNVC = [[InvestNoticeViewController alloc] init];
    investNVC.productId = [self.detailM productId];
    investNVC.productType = [self.detailM productType];
    investNVC.amountMax = [self.detailM amountMax];
    investNVC.amountMin = [self.detailM amountMin];
    pushVC(investNVC);
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
