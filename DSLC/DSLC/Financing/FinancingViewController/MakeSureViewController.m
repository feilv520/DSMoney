//
//  MakeSureViewController.m
//  DSLC
//
//  Created by ios on 15/10/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MakeSureViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "ContentCell.h"
#import "MoneyCell.h"
#import "RedBagCell.h"
#import "CashMoneyCell.h"
#import "CreatView.h"
#import "FConfirmMoney.h"
#import "FSelectionPayTypeViewController.h"

@interface MakeSureViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *titleArr;
@property (nonatomic) UILabel *qianShu;
@property (nonatomic) UILabel *labelJiGe;
@property (nonatomic) UIImageView *imageViewRight;
@property (nonatomic) UIControl *controlBlack;
@property (nonatomic) FConfirmMoney *viewWhite;
@end

@implementation MakeSureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"确认投资";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self showNavigation];
    [self showTableView];
    
    self.titleArr = @[@"账户余额", @"我的红包"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
    
    [self.controlBlack removeFromSuperview];
    [self.viewWhite removeFromSuperview];
    
    self.controlBlack = nil;
    self.viewWhite = nil;

}

//导航栏修改返回按钮
- (void)showNavigation
{
    UIImageView *imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImage *imageBack = [UIImage imageNamed:@"750产品111"];
    imageViewBack.image = imageBack;
    imageViewBack.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageViewBack];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBack:)];
    [imageViewBack addGestureRecognizer:tap];
}

//TableView展示
- (void)showTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 200)];
    viewFoot.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = viewFoot;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CashMoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
    
    UIButton *makeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (44.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (23.0 / 667.0), (WIDTH_CONTROLLER_DEFAULT - 80), HEIGHT_CONTROLLER_DEFAULT * (44.0 / 667.0)) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"确认投资"];
    makeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    [viewFoot addSubview:makeSure];
    [makeSure addTarget:self action:@selector(makeSureMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageGou = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (97.5 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (80.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (18.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (18.0 / 667.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"iocn_saft"]];
    [viewFoot addSubview:imageGou];
    
    UILabel *moneySafe = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (115.5 / 375), HEIGHT_CONTROLLER_DEFAULT * (80.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (170 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (18.0/ 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:11] text:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:moneySafe];
    
    self.qianShu = [[UILabel alloc] init];
    self.qianShu.font = [UIFont systemFontOfSize:15];
    
    self.labelJiGe = [[UILabel alloc] init];
    self.labelJiGe.font = [UIFont systemFontOfSize:15];
    
    self.imageViewRight = [[UIImageView alloc] init];
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
        
        return 145;
        
    } else if (indexPath.section == 1) {
        
        return 158;
        
    } else if (indexPath.section == 2) {
        
        return 48;
        
    } else {
        
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        
        return 2;
        
    } else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        if (cell == nil) {
            
            cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        
        cell.labelMonth.text = @"3个月固定投资";
        cell.labelMonth.font = [UIFont systemFontOfSize:15];
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.7;
        
        
        
        NSMutableAttributedString *year = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@", @"年化收益率", @"8.02%"]];
        NSRange black = NSMakeRange(0, [[year string] rangeOfString:@":"].location);
        [year addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:black];
        
        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@", @"剩余总额", @"34.2万元"]];
        NSRange moneyRange = NSMakeRange(0, [[moneyStr string] length]);
        [moneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:moneyRange];
        [cell.labelSheng setAttributedText:moneyStr];
        cell.labelSheng.textColor = [UIColor zitihui];
        
        NSMutableAttributedString *moneyS = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@", @"起投资金", @"1,000元起投,每1000元递增"]];
        NSRange Range = NSMakeRange(0, [[moneyS string] length]);
        [moneyS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:Range];
        [cell.labelMoney setAttributedText:moneyS];
        cell.labelMoney.textColor = [UIColor zitihui];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 1) {
        
        MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        if (cell == nil) {
            
            cell = [[MoneyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse2"];
        }
        
        cell.labelMoney.text = @"投资金额";
        cell.labelMoney.font = [UIFont systemFontOfSize:15];
        
        cell.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 53)];
        cell.textField.leftView.backgroundColor = [UIColor shurukuangColor];
        cell.textField.leftViewMode = UITextFieldViewModeAlways;
        cell.textField.tintColor = [UIColor yuanColor];
        
        cell.textField.placeholder = @"请输入投资金额";
        cell.textField.font = [UIFont systemFontOfSize:14];
        cell.textField.layer.cornerRadius = 4;
        cell.textField.backgroundColor = [UIColor shurukuangColor];
        cell.textField.layer.borderWidth = 0.5;
        cell.textField.layer.borderColor = [[UIColor shurukuangBian] CGColor];
        
        cell.labelOneZi.text = @"元";
        cell.labelOneZi.font = [UIFont systemFontOfSize:14];
        cell.labelOneZi.textColor = [UIColor yuanColor];
        cell.labelOneZi.backgroundColor = [UIColor clearColor];
        
        cell.labelShouRu.text = @"预计到期收益";
        cell.labelShouRu.font = [UIFont systemFontOfSize:15];
        
        cell.labelYuan.text = @"0.00元";
        cell.labelYuan.font = [UIFont systemFontOfSize:15];
        cell.labelYuan.textColor = [UIColor daohanglan];
        
        cell.viewLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine1.alpha = 0.7;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 2) {
        
        RedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        if (cell == nil) {
            
            cell = [[RedBagCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse3"];
        }
        
        if (indexPath.row == 0) {
            
            [cell.butRecharge setTitle:@"充值" forState:UIControlStateNormal];
            cell.butRecharge.titleLabel.font = [UIFont systemFontOfSize:12];
            [cell.butRecharge setTitleColor:[UIColor chongzhiColor] forState:UIControlStateNormal];
            [cell.butRecharge addTarget:self action:@selector(cashMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
            
            self.qianShu.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 12 - 60, 0, 60, 48);
            self.qianShu.text = @"56.02元";
            self.qianShu.textColor = [UIColor daohanglan];
            self.qianShu.textAlignment = NSTextAlignmentRight;
            [cell addSubview:self.qianShu];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        } else {
            
            self.labelJiGe.text = @"2个";
            self.labelJiGe.textAlignment = NSTextAlignmentCenter;
            self.labelJiGe.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 16 - 30, 0, 30, 48);
            [cell addSubview:self.labelJiGe];
            
            self.imageViewRight.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 16, 16, 16, 16);
            self.imageViewRight.image = [UIImage imageNamed:@"7501111"];
            [cell addSubview:self.imageViewRight];
        }
        
        cell.labelRedBag.text = [self.titleArr objectAtIndex:indexPath.row];
        cell.labelRedBag.font = [UIFont systemFontOfSize:15];
        
        return cell;
        
    } else {
        
        CashMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
        
        if (cell == nil) {
            
            cell = [[CashMoneyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse4"];
        }
        
        cell.labelCash.text = @"支付金额";
        cell.labelCash.font = [UIFont systemFontOfSize:15];
        
        cell.labelYuanShu.text = @"0.00元";
        cell.labelYuanShu.font = [UIFont systemFontOfSize:15];
        cell.labelYuanShu.textColor = [UIColor daohanglan];
        cell.labelYuanShu.textAlignment = NSTextAlignmentRight;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//充值按钮
- (void)cashMoneyButton:(UIButton *)button
{
    NSLog(@"充值");
}

//确认投资按钮
- (void)makeSureMoney:(UIButton *)button
{
    [self.controlBlack removeFromSuperview];
    [self.viewWhite removeFromSuperview];
    
    self.controlBlack = nil;
    self.viewWhite = nil;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (self.controlBlack == nil) {
        
        self.controlBlack = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
        [app.tabBarVC.view addSubview:self.controlBlack];
        self.controlBlack.backgroundColor = [UIColor blackColor];
        self.controlBlack.alpha = 0.3;
        [self.controlBlack addTarget:self action:@selector(controlBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (self.viewWhite == nil) {
        
        NSBundle *rootBundle = [NSBundle mainBundle];
        self.viewWhite = (FConfirmMoney *)[[rootBundle loadNibNamed:@"FConfirmMoney" owner:nil options:nil] lastObject];
        
        CGFloat viewX = WIDTH_CONTROLLER_DEFAULT * (38 / 375.0);
        CGFloat viewH = WIDTH_CONTROLLER_DEFAULT * (158 / 375.0);
        CGFloat viewWeith = WIDTH_CONTROLLER_DEFAULT * (301 / 375.0);
        CGFloat viewHejght = HEIGHT_CONTROLLER_DEFAULT * (301 / 667.0);
        
        self.viewWhite.frame = CGRectMake(viewX, viewH, viewWeith, viewHejght);
        self.viewWhite.layer.masksToBounds = YES;
        self.viewWhite.layer.cornerRadius = 4;
        [app.tabBarVC.view addSubview:self.viewWhite];
        
        self.viewWhite.labelName.text = @"尊敬的黄经理";
        self.viewWhite.labelName.font = [UIFont systemFontOfSize:15];
//        self.viewWhite.labelName.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (15.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (11.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (230.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (21.0 / 375.0));
        
        [self.viewWhite.buttonClose setImage:[UIImage imageNamed:@"iconfont_graycuo"] forState:UIControlStateNormal];
        [self.viewWhite.buttonClose addTarget:self action:@selector(controlBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
        self.viewWhite.labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.viewWhite.labelLine.alpha = 0.7;
//        self.viewWhite.labelLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (15.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (42.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (1.0 / 667.0));
        
        self.viewWhite.labelSign.text = @"在购买<<新手专享>>前请您确认:";
        self.viewWhite.labelSign.font = [UIFont systemFontOfSize:15];
        self.viewWhite.labelSign.textColor = [UIColor zitihui];
//        self.viewWhite.labelSign.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (23.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (60.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (261.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (30.0 / 667.0));
        
        self.viewWhite.labelKnow.text = @"本人已清除知悉该收益权产品的基础信息,并已充分了解其产品特性";
        self.viewWhite.labelKnow.textColor = [UIColor zitihui];
        self.viewWhite.labelKnow.font = [UIFont systemFontOfSize:15];
        self.viewWhite.labelKnow.numberOfLines = 0;
        
        self.viewWhite.labelBook.text = @"本人已仔细阅读/理解该收益权产品<<风险提示书>>全文,并愿意自行承担投资风险";
        self.viewWhite.labelBook.textColor = [UIColor zitihui];
        self.viewWhite.labelBook.font = [UIFont systemFontOfSize:15];
        self.viewWhite.labelBook.numberOfLines = 0;
        
        self.viewWhite.imageBlueOne.image = [UIImage imageNamed:@"blueyuan"];
        self.viewWhite.imageBlueTwo.image = [UIImage imageNamed:@"blueyuan"];
        
        [self.viewWhite.buttonAffirm setTitle:@"确认" forState:UIControlStateNormal];
        self.viewWhite.buttonAffirm.titleLabel.font = [UIFont systemFontOfSize:15];
        self.viewWhite.buttonAffirm.layer.cornerRadius = 4;
        self.viewWhite.buttonAffirm.layer.masksToBounds = YES;
        self.viewWhite.buttonAffirm.backgroundColor = [UIColor daohanglan];
        [self.viewWhite.buttonAffirm addTarget:self action:@selector(buttonAffirmMoney:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

//黑色遮罩层&关闭按钮的触发事件
- (void)controlBlackDisappear:(UIControl *)control
{
    [self.controlBlack removeFromSuperview];
    [self.viewWhite removeFromSuperview];
    
    self.controlBlack = nil;
    self.viewWhite = nil;
}

//确认投资按钮
- (void)buttonAffirmMoney:(UIButton *)button
{
    FSelectionPayTypeViewController *fSelectionPayVC = [[FSelectionPayTypeViewController alloc] init];
    [self.navigationController pushViewController:fSelectionPayVC animated:YES];
}

//返回按钮
- (void)returnBack:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
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
