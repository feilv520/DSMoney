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

@interface FDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITableView *_tableView;
    NSArray *titleArr;
    Calendar *calendar;
    UIView *bView;
    UIView *viewSuan;
    
    UIButton *butMakeSure;
}
@property (nonatomic, strong) UIControl *viewBotton;
@property (nonatomic, strong) ProductDetailModel *detailM;
@property (nonatomic, strong) NSString *residueMoney;
@property (nonatomic, strong) NSString *buyNumber;



@end

@implementation FDetailViewController

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

    titleArr = @[@"产品描述", @"投资须知", @"投资记录"];
    
    [self.navigationItem setTitle:@"产品详情"];
    
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
    viewFoot.backgroundColor = [UIColor huibai];
    
    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 15, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:buttonSafe];
    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
    
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
        
        return 273;
        
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
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.9;
        
        if (self.estimate == NO) {
            
            cell.labelMonth.text = @"新手专享";
            
        } else {
            
            cell.labelMonth.text = [self.detailM productName];
            
        }
        
        cell.labelMonth.font = [UIFont systemFontOfSize:15];
        
        cell.labelBuyNum.text = [NSString stringWithFormat:@"已有%@人购买",self.buyNumber];
        cell.labelBuyNum.textAlignment = NSTextAlignmentRight;
        cell.labelBuyNum.font = [UIFont systemFontOfSize:12];
        cell.labelBuyNum.textColor = [UIColor zitihui];
        
        NSMutableAttributedString *redString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",[self.detailM productAnnualYield]]];
        NSRange redLocation = NSMakeRange(0, [[redString string] rangeOfString:@"%"].location);
        [redString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:redLocation];
        [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:redLocation];
        NSRange percent = NSMakeRange([[redString string] length] - 1, 1);
        [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:percent];
        [cell.labelPercentage setAttributedText:redString];
        
        NSMutableAttributedString *dayString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[self.detailM productPeriod]]];
        NSRange dayRange = NSMakeRange(0, [[dayString string] rangeOfString:@"天"].location);
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:dayRange];
        NSRange tianRange = NSMakeRange([[dayString string] length] - 1, 1);
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:tianRange];
        [cell.labelDayNum setAttributedText:dayString];
        cell.labelDayNum.textAlignment = NSTextAlignmentCenter;
        
        cell.viewDiSe.backgroundColor = [UIColor qianhuise];
        
        cell.labelIncome.text = @"预期年化收益率";
        cell.labelIncome.textColor = [UIColor zitihui];
        cell.labelIncome.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelDeadline.text = @"理财期限";
        cell.labelDeadline.textColor = [UIColor zitihui];
        cell.labelDeadline.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelDeadline.textAlignment = NSTextAlignmentCenter;
        
        cell.labelSurplus.text = [NSString stringWithFormat:@"%@%@", @"剩余总额:", self.residueMoney];
        cell.labelSurplus.textColor = [UIColor zitihui];
        cell.labelSurplus.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelSurplus.backgroundColor = [UIColor clearColor];
        
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
        
        cell.labelName.text = @"产品名称";
        cell.labelName.textColor = [UIColor zitihui];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.nameContent.text = [self.detailM productName];
        cell.nameContent.textColor = [UIColor zitihui];
        cell.nameContent.textAlignment = NSTextAlignmentRight;
        cell.nameContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelNumber.text = @"产品编号";
        cell.labelNumber.textColor = [UIColor zitihui];
        cell.labelNumber.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.numberContent.text = [self.detailM productCode];
        cell.numberContent.textColor = [UIColor zitihui];
        cell.numberContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        cell.numberContent.textAlignment = NSTextAlignmentRight;
        
        cell.labelInvestor.text = @"预期年化收益率";
        cell.labelInvestor.textColor = [UIColor zitihui];
        cell.labelInvestor.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.InvestorContent.text = [NSString stringWithFormat:@"%@%%",[self.detailM productAnnualYield]];
        cell.InvestorContent.textColor = [UIColor zitihui];
        cell.InvestorContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        cell.InvestorContent.textAlignment = NSTextAlignmentRight;
        
        cell.labelData.text = @"理财期限";
        cell.labelData.textColor = [UIColor zitihui];
        cell.labelData.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelIntraday.text = [NSString stringWithFormat:@"%@天",[self.detailM productPeriod]];
        cell.labelIntraday.textColor = [UIColor zitihui];
        cell.labelIntraday.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        cell.labelIntraday.textAlignment = NSTextAlignmentRight;
        
        cell.labelStyle.text = @"计息方式";
        cell.labelStyle.textColor = [UIColor zitihui];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelIncome.text = [self.detailM productInterestTypeName];
        cell.labelIncome.textColor = [UIColor zitihui];
        cell.labelIncome.font = [UIFont systemFontOfSize:15];
        cell.labelIncome.textAlignment = NSTextAlignmentRight;
        
        cell.labelComeTime.text = @"预计到账时间";
        cell.labelComeTime.textColor = [UIColor zitihui];
        cell.labelComeTime.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.ComeTime.text = [self.detailM productToaccountTypeName];
        cell.ComeTime.textColor = [UIColor zitihui];
        cell.ComeTime.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelEarnings.text = @"收益分配方式";
        cell.labelEarnings.textColor = [UIColor zitihui];
        cell.labelEarnings.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            
        cell.labelLast.text = [self.detailM productYieldDistribTypeName];
        
        cell.labelLast.textColor = [UIColor zitihui];
        cell.labelLast.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else if (indexPath.section == 2) {
        
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
        
        cell.timeOne.text = [self.detailM beginTime];
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
    
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
    cell.imageRight.image = [UIImage imageNamed:@"7501111"];
    
    return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            
            FDescriptionViewController *fDes = [[FDescriptionViewController alloc] init];
            [self.navigationController pushViewController:fDes animated:YES];
            
        } else if (indexPath.row == 2) {
            
            RecordViewController *recordVC = [[RecordViewController alloc] init];
            recordVC.idString = self.idString;
            [self.navigationController pushViewController:recordVC animated:YES];
            
        } else {
            
            InvestNoticeViewController *investNotice = [[InvestNoticeViewController alloc] init];
            [self.navigationController pushViewController:investNotice animated:YES];
            
        }
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
    
    if (self.estimate == NO) {
        
        [butMakeSure setTitle:@"投资(可使用5,000元体验金)" forState:UIControlStateNormal];
        
    } else {
        NSLog(@"%@",self.residueMoney);
        if ([self.residueMoney isEqualToString:@"0.00"]) {
            [butMakeSure setTitle:@"预约" forState:UIControlStateNormal];
        } else {
            [butMakeSure setTitle:@"投资(1,000元起投)" forState:UIControlStateNormal];
        }
    }
    
    butMakeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    butMakeSure.backgroundColor = [UIColor daohanglan];
    [butMakeSure addTarget:self action:@selector(makeSureButton:) forControlEvents:UIControlEventTouchUpInside];
}

//确认投资按钮
- (void)makeSureButton:(UIButton *)button
{
    if ([self.residueMoney isEqualToString:@"0.00"]) {
        [self orderProduct];
        return;
    } else if ([self.residueMoney floatValue] <= [[self.detailM amountMin] floatValue]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"剩余金额已小于起投金额,不能投资此产品"];
        return;
    }
    
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    if ([dic objectForKey:@"token"] != nil) {
    
        NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyAccountInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            if ([[responseObject objectForKey:@"result"] integerValue] == 400) {
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请先登录,然后再投资"];

            } else {
                
                MakeSureViewController *makeSureVC = [[MakeSureViewController alloc] init];
                
                if (self.estimate == YES) {
                    
                    makeSureVC.decide = YES;
                    
                } else {
                    
                    makeSureVC.decide = NO;
                    makeSureVC.nHand = self.nHand;
                }
                makeSureVC.detailM = self.detailM;
                makeSureVC.residueMoney = self.residueMoney;
                [self.navigationController pushViewController:makeSureVC animated:YES];
            }

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@", error);
            
        }];
    } else {
        [ProgressHUD showMessage:@"请先登录,然后再投资" Width:100 High:20];
    }
    
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
        
        calendar.frame = CGRectMake(margin_x, margin_y, width, 301);
        calendar.layer.masksToBounds = YES;
        calendar.layer.cornerRadius = 4.0;
        
        calendar.inputMoney.delegate = self;
        [calendar.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
        [calendar.calButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [calendar.calButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        [calendar.calButton addTarget:self action:@selector(calButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        calendar.viewDown.backgroundColor = [UIColor shurukuangColor];
        calendar.viewDown.layer.cornerRadius = 4;
        calendar.viewDown.layer.masksToBounds = YES;
        calendar.viewDown.layer.borderColor = [[UIColor shurukuangBian] CGColor];
        calendar.viewDown.layer.borderWidth = 0.5;
        
        calendar.inputMoney.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
        calendar.inputMoney.leftViewMode = UITextFieldViewModeAlways;
        calendar.inputMoney.tintColor = [UIColor grayColor];
        
        calendar.yearLv.text = [self.detailM productAnnualYield];
        calendar.dayLabel.text = [self.detailM productPeriod];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [calendar addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(returnKeyboard:)];
        
        [app.tabBarVC.view addSubview:calendar];
    }
}

- (void)returnKeyboard:(UITapGestureRecognizer *)tap
{
    [calendar endEditing:YES];
}

//计算按钮
- (void)calButtonAction:(id)sender
{
    if (calendar.inputMoney.text == nil) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入投资金额"];
    } else {
    
        calendar.totalLabel.text = [NSString stringWithFormat:@"%.2f",[calendar.inputMoney.text floatValue] * [[self.detailM productAnnualYield] floatValue] * ([[self.detailM productPeriod] floatValue] / 36000.0)];
    }
}

- (void)closeButton:(UIButton *)but{
    [bView removeFromSuperview];
    [calendar removeFromSuperview];
    
    bView = nil;
    calendar = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5f animations:^{
        CGFloat margin_x = (38 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
        CGFloat margin_y = (182 / 667.0) * HEIGHT_CONTROLLER_DEFAULT;
        CGFloat width = (301 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
        
        if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
            margin_y -= 30;
        }
        
        calendar.frame = CGRectMake(margin_x, margin_y - 40, width, 301);
    }];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductDetail{
    NSDictionary *parameter = @{@"productId":self.idString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductDetail" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        [self loadingWithHidden:YES];
        
        self.residueMoney = [responseObject objectForKey:@"residueMoney"];
        self.buyNumber = [responseObject objectForKey:@"buyCount"];
        
        self.detailM = [[ProductDetailModel alloc] init];
        NSDictionary *dic = [responseObject objectForKey:@"Product"];
        [self.detailM setValuesForKeysWithDictionary:dic];
        
        [self showTableView];
        [self showBottonView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

// 预定产品
- (void)orderProduct{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameters = @{@"productId":[self.detailM productId],@"productType":[self.detailM productType],@"token":[dic objectForKey:@"token"]};
    
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
