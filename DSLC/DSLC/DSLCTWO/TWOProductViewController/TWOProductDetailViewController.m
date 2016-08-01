//
//  TWOProductDetailViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/9.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductDetailViewController.h"
#import "TWOProductDetailTableViewCell.h"
#import "ProductDetailModel.h"
#import "Calendar.h"
#import "TMakeSureViewController.h"
#import "MakeSureViewController.h"
#import "UsufructAssignmentViewController.h"
#import "TWOProductMoneyView.h"
#import "TWORecordViewController.h"
#import "TWOProductMakeSureViewController.h"
#import "TWOProductSafeTestViewController.h"
#import "TWOProductDDetailViewController.h"
#import "TWOLoginAPPViewController.h"
#import "TWOProductHuiFuViewController.h"
#import "TWOProductHuiFuModel.h"

@interface TWOProductDetailViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *titleArr;
    Calendar *calendar;
    UIButton *bView;
    UIView *viewSuan;
    
    UIButton *butMakeSure;
    NSDictionary *dataDic;
    
    NSInteger isOrder;
    
    NSArray *titleArray;
    
    // 星星view
    UIView *viewUserXing;
    NSString *kindString;
    
    // 资产数组
    NSMutableArray *assetArray;
    
    UIButton *buttBlack;
    UIView *viewThirdOpen;
    
    NSDictionary *userDic;
    NSArray *userXingArray;
    
    BOOL initFlag;
}

@property (nonatomic, strong) UIControl *viewBotton;
@property (nonatomic, strong) ProductDetailModel *detailM;
@property (nonatomic, strong) NSString *buyNumber;
@property (nonatomic, strong) NSDictionary *flagLogin;

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TWOProductDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    self.navigationController.navigationItem.title = self.productName;
    
    [self.navigationItem setTitle:self.productName];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductDetail) name:@"getProductDetail" object:nil];
    
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
    
    self.view.backgroundColor = [UIColor huibai];
    
    titleArray = [NSArray array];
    assetArray = [NSMutableArray array];
    
    initFlag = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductDetail) name:@"safeTest" object:nil];
    
    titleArray = @[@"收益方式",@"计息起始日&到账日",@"投资限额"];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
    
    [self getProductDetail];
}

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
    butMakeSure.enabled = YES;
}

// 创建TableView
- (void)showTableView{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84 - 49) style:UITableViewStyleGrouped];
    
    self.mainTableView.backgroundColor = [UIColor huibai];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TWOProductDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewHeadShow];
    
    [self.view addSubview:self.mainTableView];
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
    [buttonCal setImageEdgeInsets:UIEdgeInsetsMake(10, 32 / 93.0 * (WIDTH_CONTROLLER_DEFAULT / 4.0), 10, 32 / 93.0 * (WIDTH_CONTROLLER_DEFAULT / 4.0))];
    buttonCal.backgroundColor = [UIColor colorWithRed:112 / 255.0 green:192 / 255.0 blue:252 / 255.0 alpha:1.0];
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
    
//    if (self.estimate == NO) {
//        
//        [butMakeSure setTitle:@"立即投资" forState:UIControlStateNormal];
//        [butMakeSure setBackgroundColor:[UIColor profitColor]];
//        if ([self.residueMoney isEqualToString:@"0.00"]) {
//            
//            butMakeSure.enabled = NO;
//            butMakeSure.backgroundColor = [UIColor grayColor];
//            [butMakeSure setTitle:@"收益中" forState:UIControlStateNormal];
//        } else {
//            
//            [butMakeSure setTitle:@"立即投资" forState:UIControlStateNormal];
//            [butMakeSure setBackgroundColor:[UIColor profitColor]];
//            butMakeSure.enabled = YES;
//        }
//        
//    } else {
        NSLog(@"%@",self.residueMoney);
        
        if ([[[self.detailM status] description] isEqualToString:@"4"]) {
            
            butMakeSure.enabled = NO;
            butMakeSure.backgroundColor = [UIColor grayColor];
            [butMakeSure setTitle:@"收益中" forState:UIControlStateNormal];
        } else if ([[[self.detailM status] description] isEqualToString:@"6"]) {
            
            butMakeSure.enabled = NO;
            butMakeSure.backgroundColor = [UIColor grayColor];
            [butMakeSure setTitle:@"已兑付" forState:UIControlStateNormal];
        } else {
            
            butMakeSure.enabled = YES;
            [butMakeSure setBackgroundColor:[UIColor profitColor]];
            [butMakeSure setTitle:@"立即投资" forState:UIControlStateNormal];
        }
//    }
    
    butMakeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [butMakeSure addTarget:self action:@selector(makeSureButton:) forControlEvents:UIControlEventTouchUpInside];
}

//头部内容
- (void)tableViewHeadShow
{
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 196)];
    headImageView.image = [UIImage imageNamed:@"productDetailBackground"];
    self.mainTableView.tableHeaderView = headImageView;
    
    UILabel *profitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, WIDTH_CONTROLLER_DEFAULT, 40)];
    profitLabel.textAlignment = NSTextAlignmentCenter;
    [profitLabel setFont:[UIFont fontWithName:@"CenturyGothic" size:38]];
    profitLabel.textColor = Color_White;
    
    NSMutableAttributedString *redStringM = [[NSMutableAttributedString alloc] initWithString:@"13.17%"];
    [redStringM replaceCharactersInRange:NSMakeRange(0, [[redStringM string] rangeOfString:@"%"].location) withString:[NSString stringWithFormat:@"%@",[self.detailM productAnnualYield]]];
    NSRange numString = NSMakeRange(0, [[redStringM string] rangeOfString:@"%"].location);
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:32] range:numString];
        NSRange oneString = NSMakeRange([[redStringM string] length] - 1, 1);
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:oneString];
        
    } else {
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:35] range:numString];
        NSRange oneString = NSMakeRange([[redStringM string] length] - 1, 1);
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:oneString];
    }
    [profitLabel setAttributedText:redStringM];
    [headImageView addSubview:profitLabel];
    
    UILabel *profitTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(profitLabel.frame), WIDTH_CONTROLLER_DEFAULT, 20)];
    profitTitleLabel.text = @"预期年化收益率";
    profitTitleLabel.textAlignment = NSTextAlignmentCenter;
    [profitTitleLabel setFont:[UIFont fontWithName:@"CenturyGothic" size:15]];
    profitTitleLabel.textColor = Color_White;
    [headImageView addSubview:profitTitleLabel];
    
    CGFloat bfNumber = [[self.detailM saleProgress] floatValue] / 100.0;
    
    //小猴子
    UIImageView *monkeyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 84, 20, 30)];
    monkeyImageView.image = [UIImage imageNamed:@"productMonkey"];
    [headImageView addSubview:monkeyImageView];
    
    //百分比
    UILabel *bfLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 93, 50, 20)];
    bfLabel.textAlignment = NSTextAlignmentCenter;
    [bfLabel setFont:[UIFont fontWithName:@"CenturyGothic" size:14]];
    bfLabel.text = @"0%";
    bfLabel.textColor = Color_White;
    [headImageView addSubview:bfLabel];
    
    // 进度条
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(-WIDTH_CONTROLLER_DEFAULT, 116, WIDTH_CONTROLLER_DEFAULT, 2)];
    whiteView.backgroundColor = Color_White;
    [headImageView addSubview:whiteView];
    
    UIView *lightBlue = [[UIView alloc] initWithFrame:CGRectMake(0, 116, WIDTH_CONTROLLER_DEFAULT, 2)];
    lightBlue.backgroundColor = [UIColor colorFromHexCode:@"#3cb6f5"];
    [headImageView addSubview:lightBlue];
    
    [UIView animateWithDuration:2.f animations:^{
        
        bfLabel.text = [NSString stringWithFormat:@"%.0lf%%",bfNumber * 100];

        if ([bfLabel.text floatValue] > 10 && [bfLabel.text floatValue] < 94) {
            
            monkeyImageView.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * bfNumber, 84, 20, 30);
            bfLabel.frame = CGRectMake(CGRectGetMinX(monkeyImageView.frame) - 40, 93, 50, 20);
        } else if ([bfLabel.text floatValue] >= 94){
            
            monkeyImageView.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * 0.94, 84, 20, 30);
            bfLabel.frame = CGRectMake(CGRectGetMinX(monkeyImageView.frame) - 40, 93, 50, 20);
        }
        
        whiteView.frame = CGRectMake(-WIDTH_CONTROLLER_DEFAULT + WIDTH_CONTROLLER_DEFAULT * bfNumber, 116, WIDTH_CONTROLLER_DEFAULT, 2);
        lightBlue.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * bfNumber, 116, WIDTH_CONTROLLER_DEFAULT, 2);
    }];
    
    // 下方剩余可投的view
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    TWOProductMoneyView *pMoneyView = (TWOProductMoneyView *)[[rootBundle loadNibNamed:@"TWOProductMoneyView" owner:nil options:nil] lastObject];
    
    pMoneyView.frame = CGRectMake(0, 115, WIDTH_CONTROLLER_DEFAULT, 80);
    
    NSMutableAttributedString *resdStringM = [[NSMutableAttributedString alloc] initWithString:@"13.17元"];
    
    CGFloat residueMoney = [self.residueMoney floatValue];
    
    if (residueMoney / 10000.0 >= 0) {
        
        [resdStringM replaceCharactersInRange:NSMakeRange(0, [[resdStringM string] rangeOfString:@"元"].location) withString:[NSString stringWithFormat:@"%.2lf万",residueMoney / 10000.0]];
    } else {
        
        [resdStringM replaceCharactersInRange:NSMakeRange(0, [[resdStringM string] rangeOfString:@"元"].location) withString:[NSString stringWithFormat:@"%@",self.residueMoney]];
    }
    NSRange numYString = NSMakeRange(0, [[resdStringM string] rangeOfString:@"元"].location);
    
    if (residueMoney / 10000.0 >= 0) {
        numYString = NSMakeRange(0, [[resdStringM string] rangeOfString:@"万"].location);
    }
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        [resdStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:21] range:numYString];
        NSRange oneString = NSMakeRange([[resdStringM string] length] - 1, 1);
        
        if (residueMoney / 10000.0 >= 0) {
            oneString = NSMakeRange([[resdStringM string] length] - 2, 2);
        }
        
        [resdStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:oneString];
        
    } else {
        [resdStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:numYString];
        NSRange oneString = NSMakeRange([[resdStringM string] length] - 1, 1);
        
        if (residueMoney / 10000.0 >= 0) {
            oneString = NSMakeRange([[resdStringM string] length] - 2, 2);
        }
        
        [resdStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:oneString];
    }
    [pMoneyView.moneyLabel setAttributedText:resdStringM];
    
    NSMutableAttributedString *resdStringD = [[NSMutableAttributedString alloc] initWithString:@"13.17天"];
    [resdStringD replaceCharactersInRange:NSMakeRange(0, [[resdStringD string] rangeOfString:@"天"].location) withString:[NSString stringWithFormat:@"%@",[self.detailM productPeriod]]];
    NSRange numDString = NSMakeRange(0, [[resdStringD string] rangeOfString:@"天"].location);
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        [resdStringD addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:21] range:numDString];
        NSRange oneString = NSMakeRange([[resdStringD string] length] - 1, 1);
        [resdStringD addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:oneString];
        
    } else {
        [resdStringD addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:numDString];
        NSRange oneString = NSMakeRange([[resdStringD string] length] - 1, 1);
        [resdStringD addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:oneString];
    }
    [pMoneyView.dayLabel setAttributedText:resdStringD];
    
    [headImageView addSubview:pMoneyView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (assetArray.count == 0) {
        return 2;
    } else {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    } else if(section == 1){
        if (assetArray.count == 0) {
            return 3;
        } else {
            return 2;
        }
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    } else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TWOProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.titleLabel.text = titleArray[indexPath.row];
        if (indexPath.row == 0) {
            
            cell.valueLabel.text = [self.detailM productYieldDistribTypeName];
        } else if (indexPath.row == 1) {
            
            cell.valueLabel.text = [NSString stringWithFormat:@"%@",[self.detailM interestTypeName]];
        } else {
            if ([[[self.detailM productType] description] isEqualToString:@"1"]) {
                cell.valueLabel.text = @"无限额";
            } else if ([[[self.detailM productType] description] isEqualToString:@"2"]) {
                cell.valueLabel.text = @"无限额";
            } else if ([[[self.detailM productType] description] isEqualToString:@"3"]) {
                cell.valueLabel.text = @"(仅限新用户)单笔限额1万元";
            } else if ([[[self.detailM productType] description] isEqualToString:@"5"]) {
                cell.valueLabel.text = @"无限额";
            } else if ([[[self.detailM productType] description] isEqualToString:@"6"]) {
                cell.valueLabel.text = @"无限额";
            } else if ([[[self.detailM productType] description] isEqualToString:@"7"]) {
                cell.valueLabel.text = @"无限额";
            } else if ([[[self.detailM productType] description] isEqualToString:@"8"]) {
                cell.valueLabel.text = @"无限额";
            } else if ([[[self.detailM productType] description] isEqualToString:@"9"]) {
                cell.valueLabel.text = @"单人累计投资限额2万元";
            } else if ([[[self.detailM productType] description] isEqualToString:@"10"]){
                cell.valueLabel.text = @"每人每期限额2万元";
            }
        }
        
    } else if (indexPath.section == 1) {
        
        if (assetArray.count == 0) {
            if (indexPath.row == 0) {
                
                cell.titleLabel.text = @"产品介绍";
            } else if (indexPath.row == 1) {
                
                cell.titleLabel.text = @"投资记录";
                cell.titleLabel.textColor = [UIColor findZiTiColor];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            } else {
                
                cell.titleLabel.text = @"产品安全等级";
                cell.titleLabel.textColor = [UIColor findZiTiColor];
                
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                
                viewUserXing = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 175, 0, 150, 50) backgroundColor:[UIColor clearColor]];
                [cell addSubview:viewUserXing];
                
                if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"1"]) {
                    kindString = @"谨慎型";
                    userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xing"];
                    
                } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"2"]) {
                    kindString = @"稳健型";
                    userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xingkong"];
                    
                } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"3"]) {
                    kindString = @"平衡型";
                    userXingArray = @[@"xing", @"xing", @"xing", @"xingkong", @"xingkong"];
                    
                } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"4"]) {
                    kindString = @"进取型";
                    userXingArray = @[@"xing", @"xing", @"xingkong", @"xingkong", @"xingkong"];
                    
                } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"5"]) {
                    kindString = @"激进型";
                    userXingArray = @[@"xing", @"xingkong", @"xingkong", @"xingkong", @"xingkong"];
                    
                } else {
                    kindString = @"谨慎型";
                    userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xing"];
                }
                
                UILabel *kindLabel = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 60, 46) backgroundColor:Color_Clear textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:kindString];
                [viewUserXing addSubview:kindLabel];
                
                for (int w = 0; w < 5; w++) {
                    UIImageView *imageUserXing = [CreatView creatImageViewWithFrame:CGRectMake(60 + 3 * w + 14 * w, 16, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[userXingArray objectAtIndex:w]]];
                    [viewUserXing addSubview:imageUserXing];
                }
                
            }
        } else {
        
            if (indexPath.row == 0) {
                
                cell.titleLabel.text = @"资产详情";
                
            } else {
                
                cell.titleLabel.text = [[assetArray objectAtIndex:indexPath.row - 1] objectForKey:@"assetName"];
                cell.titleLabel.textColor = [UIColor findZiTiColor];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }
    } else if(indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            cell.titleLabel.text = @"产品介绍";
        } else if (indexPath.row == 1) {
            
            cell.titleLabel.text = @"投资记录";
            cell.titleLabel.textColor = [UIColor findZiTiColor];
        } else {
            
            cell.titleLabel.text = @"产品安全等级";
            cell.titleLabel.textColor = [UIColor findZiTiColor];
            
            viewUserXing = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 175, 0, 150, 50) backgroundColor:[UIColor clearColor]];
            [cell addSubview:viewUserXing];
            
            if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"1"]) {
                kindString = @"谨慎型";
                userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xing"];
                
            } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"2"]) {
                kindString = @"稳健型";
                userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xingkong"];
                
            } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"3"]) {
                kindString = @"平衡型";
                userXingArray = @[@"xing", @"xing", @"xing", @"xingkong", @"xingkong"];
                
            } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"4"]) {
                kindString = @"进取型";
                userXingArray = @[@"xing", @"xing", @"xingkong", @"xingkong", @"xingkong"];
                
            } else if ([[[dataDic objectForKey:@"securityLevel"] description] isEqualToString:@"5"]) {
                kindString = @"激进型";
                userXingArray = @[@"xing", @"xingkong", @"xingkong", @"xingkong", @"xingkong"];
                
            } else {
                kindString = @"谨慎型";
                userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xing"];
            }
            
            UILabel *kindLabel = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 60, 46) backgroundColor:Color_Clear textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:kindString];
            [viewUserXing addSubview:kindLabel];
            
            for (int w = 0; w < 5; w++) {
                UIImageView *imageUserXing = [CreatView creatImageViewWithFrame:CGRectMake(60 + 3 * w + 14 * w, 16, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[userXingArray objectAtIndex:w]]];
                [viewUserXing addSubview:imageUserXing];
            }
        }
    }
    
    if (indexPath.section != 0) {
        cell.valueLabel.hidden = YES;
        if (indexPath.row != 0) {
            cell.rightButton.hidden = NO;
        }
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 1) {
            TWORecordViewController *recordVC = [[TWORecordViewController alloc] init];
            recordVC.idString = self.idString;
            pushVC(recordVC);
        } else if (indexPath.row == 2){
            
            //判断是否登录,如若没有登录,跳转的都是未测评的页面,如已登录,需要判断是测过还是没测过
            NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
            
            if ([[dicLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
                TWOProductSafeTestViewController *safeTestVC = [[TWOProductSafeTestViewController alloc] init];
                safeTestVC.securityLevel = [[dataDic objectForKey:@"securityLevel"] description]; //产品等级类型
                pushVC(safeTestVC);
                
            } else {
                
                if ([[userDic objectForKey:@"investTestResult"] isEqualToString:@""]) {
                    TWOProductSafeTestViewController *safeTestVC = [[TWOProductSafeTestViewController alloc] init];
                    safeTestVC.securityLevel = [[dataDic objectForKey:@"securityLevel"] description]; //产品等级类型
                    pushVC(safeTestVC);
                } else {
                    TWOProductSafeTestViewController *safeTestVC = [[TWOProductSafeTestViewController alloc] init];
                    safeTestVC.alreadyTest = YES;
                    safeTestVC.score = [[userDic objectForKey:@"investTestResult"] floatValue];
                    NSLog(@"分数%f", safeTestVC.score);
                    safeTestVC.securityLevel = [[dataDic objectForKey:@"securityLevel"] description]; //产品等级类型
                    pushVC(safeTestVC);
                }
            }
        }
    } else if (indexPath.section == 1) {
        
        if (assetArray.count == 0) {
            if (indexPath.row == 1) {
                TWORecordViewController *recordVC = [[TWORecordViewController alloc] init];
                recordVC.idString = self.idString;
                pushVC(recordVC);
            } else if (indexPath.row == 2){
                
                //判断是否登录,如若没有登录,跳转的都是未测评的页面,如已登录,需要判断是测过还是没测过
                NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
                
                if ([[dicLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
                    TWOProductSafeTestViewController *safeTestVC = [[TWOProductSafeTestViewController alloc] init];
                    safeTestVC.securityLevel = [[dataDic objectForKey:@"securityLevel"] description]; //产品等级类型
                    pushVC(safeTestVC);
                    
                } else {
                    
                    if ([[userDic objectForKey:@"investTestResult"] isEqualToString:@""]) {
                        TWOProductSafeTestViewController *safeTestVC = [[TWOProductSafeTestViewController alloc] init];
                        safeTestVC.securityLevel = [[dataDic objectForKey:@"securityLevel"] description]; //产品等级类型
                        pushVC(safeTestVC);
                    } else {
                        TWOProductSafeTestViewController *safeTestVC = [[TWOProductSafeTestViewController alloc] init];
                        safeTestVC.alreadyTest = YES;
                        safeTestVC.score = [[userDic objectForKey:@"investTestResult"] floatValue];
                        NSLog(@"分数%f", safeTestVC.score);
                        safeTestVC.securityLevel = [[dataDic objectForKey:@"securityLevel"] description]; //产品等级类型
                        pushVC(safeTestVC);
                    }
                }
            }
            
        } else {
            if (indexPath.row == 1) {
                TWOProductDDetailViewController *productDDetailVC = [[TWOProductDDetailViewController alloc] init];
                productDDetailVC.assetId = [[assetArray objectAtIndex:indexPath.row - 1] objectForKey:@"assetId"];
                productDDetailVC.assetTitle = [[assetArray objectAtIndex:indexPath.row - 1] objectForKey:@"assetName"];
                pushVC(productDDetailVC);
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        self.mainTableView.scrollEnabled = NO;
    } else {
        self.mainTableView.scrollEnabled = YES;
    }
}

// 计算收益图层
- (void)calendarView
{
    [bView removeFromSuperview];
    [calendar removeFromSuperview];
    
    bView = nil;
    calendar = nil;
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
        
        calendar.frame = CGRectMake(margin_x, margin_y, width, 204);
        calendar.layer.masksToBounds = YES;
        calendar.layer.cornerRadius = 4.0;
        
        calendar.inputMoney.delegate = self;
        [calendar.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        calendar.viewDown.backgroundColor = [UIColor shurukuangColor];
        calendar.viewDown.layer.cornerRadius = 8;
        calendar.viewDown.layer.masksToBounds = YES;
//        calendar.viewDown.layer.borderColor = [[UIColor shurukuangBian] CGColor];
        calendar.viewDown.layer.borderColor = [[UIColor clearColor] CGColor];
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
        
        if (![[[self.detailM productPeriod] description] isEqualToString:@"0"]) {
            daysPeriodString = [self.detailM productPeriod];
        }
        
        if ([[[self.detailM productType] description] isEqualToString:@"2"])
            calendar.dayLabel.text = [NSString stringWithFormat:@"%@天",daysLimitString];
        else
            calendar.dayLabel.text = [NSString stringWithFormat:@"%@天",daysPeriodString];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [calendar addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(returnKeyboard:)];
        
        [app.tabBarVC.view addSubview:calendar];
    }
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [calendar.layer addAnimation:animation forKey:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 9) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

//自动计算
- (void)textFiledEditChange:(UITextField *)textField
{
    NSDecimalNumber *yearNumber = [NSDecimalNumber decimalNumberWithString:@"36500.0"];
    
    NSDecimalNumber *inputNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lf",[calendar.inputMoney.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue]]];
    
    NSDecimalNumber *totalNumber = [inputNumber decimalNumberByDividingBy:yearNumber];
    
    calendar.totalLabel.text = [NSString stringWithFormat:@"¥%.2f元",[totalNumber floatValue]];
}

//return按钮
- (void)returnKeyboard:(UITapGestureRecognizer *)tap
{
    
    [calendar endEditing:YES];
}

//关闭按钮
- (void)closeButton:(UIButton *)but{
    
    [bView removeFromSuperview];
    [calendar removeFromSuperview];
    
    bView = nil;
    calendar = nil;
}

//确认投资按钮
- (void)makeSureButton:(UIButton *)button
{
//    if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
//        return ;
//    }
    
    button.enabled = NO;
    
    if ([self.residueMoney isEqualToString:@"0.00"]) {
        
        button.enabled = YES;
        [self orderProduct];
        return;
    } else if ([self.residueMoney floatValue] < [[self.detailM amountMin] floatValue]) {
        
        button.enabled = YES;
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"剩余金额已小于起投金额,不能投资此产品"];
        return;
    } else if ([[self.detailM.productType description] isEqualToString:@"9"]) {
        if ([[userDic objectForKey:@"limitMoney"] isEqualToString:@"0"]) {
            
            button.enabled = YES;
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"您的投资限额已用完,去投资其他产品吧"];
            return;
        }
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
    
    if (![[dic objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
        
        button.enabled = YES;
        
        if ([[self.flagDic objectForKey:@"chinaPnrAcc"] isEqualToString:@""]) {
            
            [self registThirdShow];
            return;
        }
        
        TWOProductMakeSureViewController *makeSureVC = [[TWOProductMakeSureViewController alloc] init];
        
        makeSureVC.detailM = self.detailM;
        makeSureVC.residueMoney = self.residueMoney;
        makeSureVC.limitMoney = [userDic objectForKey:@"limitMoney"];
        
        [self submitLoadingWithHidden:YES];
        
        pushVC(makeSureVC);
    } else {
        button.enabled = YES;
        
        [self submitLoadingWithHidden:YES];
        TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
        
        loginVC.flagString = @"bugProduct";
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [nvc setNavigationBarHidden:YES animated:YES];
        
        [self presentViewController:nvc animated:YES completion:^{
            
        }];
    }
    
}

//开通托管账户弹框
- (void)registThirdShow
{
    NSLog(@"2");
    AppDelegate *app  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    buttBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttBlack];
    buttBlack.alpha = 0.5;
    [buttBlack addTarget:self action:@selector(buttonViewDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewThirdOpen = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 310/2, HEIGHT_CONTROLLER_DEFAULT/3, 310, 228) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewThirdOpen];
    viewThirdOpen.layer.cornerRadius = 4;
    viewThirdOpen.layer.masksToBounds = YES;
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewThirdOpen.frame.size.width, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"您还未开通托管账户"];
    [viewThirdOpen addSubview:labelAlert];
    
    UIImageView *imageImg = [CreatView creatImageViewWithFrame:CGRectMake(viewThirdOpen.frame.size.width/2 - 314/2/2, 45, 314/2, 234/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"thirdimg"]];
    [viewThirdOpen addSubview:imageImg];
    
    UIButton *buttonok = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 45 + imageImg.frame.size.height + 15, viewThirdOpen.frame.size.width - 24, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"去开户"];
    [viewThirdOpen addSubview:buttonok];
    buttonok.layer.cornerRadius = 4;
    buttonok.layer.masksToBounds = YES;
    buttonok.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonok addTarget:self action:@selector(buttonOpenThirdOK:) forControlEvents:UIControlEventTouchUpInside];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [viewThirdOpen.layer addAnimation:animation forKey:nil];
    
}

//开通三方确定按钮
- (void)buttonOpenThirdOK:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
    
    TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
    productHuiFuVC.fuctionName = @"userReg";
    pushVC(productHuiFuVC);
    
}

//开通三方弹框点击消失
- (void)buttonViewDisappear:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
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
    if ([butMakeSure.titleLabel.text isEqualToString:@"已售罄"] || [butMakeSure.titleLabel.text isEqualToString:@"已预约"]) {
        
        if (button.tag == 2000) {
            button.tag = 3000;
            [button setImage:[UIImage imageNamed:@"iconfont-dui-2111"] forState:UIControlStateNormal];
        } else {
            [button setImage:[UIImage imageNamed:@"iconfont-dui-2"] forState:UIControlStateNormal];
            button.tag = 2000;
        }
        
    } else {
        
        if (button.tag == 2000) {
            
            [button setImage:[UIImage imageNamed:@"iconfont-dui-2111"] forState:UIControlStateNormal];
            button.tag = 3000;
            butMakeSure.enabled = NO;
            butMakeSure.backgroundColor = [UIColor whiteColor];
            //        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
            butMakeSure.backgroundColor = [UIColor colorWithRed:190.0 / 225.0 green:190.0 / 225.0 blue:190.0 / 225.0 alpha:1.0];
            
        } else {
            
            butMakeSure.enabled = YES;
            //        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
            butMakeSure.backgroundColor = [UIColor daohanglan];
            [button setImage:[UIImage imageNamed:@"iconfont-dui-2"] forState:UIControlStateNormal];
            button.tag = 2000;
        }
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

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
            //            [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
            butMakeSure.backgroundColor = [UIColor colorWithRed:190.0 / 225.0 green:190.0 / 225.0 blue:190.0 / 225.0 alpha:1.0];
        } else {
            [ProgressHUD showMessage:@"请先登录,然后再预约" Width:100 High:20];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)getProductDetail{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSString *tokenString = [dic objectForKey:@"token"];
    
    NSDictionary *parameter = @{@"productId":self.idString,@"token":tokenString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"product/getProductDetail" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"产品详情ppppppppppppppp%@",responseObject);
        
        [self loadingWithHidden:YES];
        
        self.detailM = [[ProductDetailModel alloc] init];
        dataDic = [responseObject objectForKey:@"Product"];
        [self.detailM setValuesForKeysWithDictionary:dataDic];
        
        assetArray = [responseObject objectForKey:@"Asset"];
        
        userDic = [responseObject objectForKey:@"User"];
        
        if (!initFlag) {
            
            [self showTableView];
            [self showBottonView];
        }
        
        initFlag = YES;
        
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
