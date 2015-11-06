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
#import "NewMakeSureCell.h"
#import "CashFinishViewController.h"
#import "ChooseRedBagViewController.h"
#import "FBalancePaymentViewController.h"
#import "RechargeViewController.h"

@interface MakeSureViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *titleArr;
@property (nonatomic) UILabel *qianShu;
@property (nonatomic) UILabel *labelJiGe;
@property (nonatomic) UIImageView *imageViewRight;
@property (nonatomic) UIControl *controlBlack;
@property (nonatomic) UIButton *buttBlack;
@property (nonatomic) UIView *viewBottom;
@property (nonatomic) FConfirmMoney *viewWhite;
@property (nonatomic) UITextField *textFieldC;
@end

@implementation MakeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"确认投资"];
    [self showTableView];
    
    self.titleArr = @[@"账户余额", @"我的红包"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.controlBlack removeFromSuperview];
    [self.viewWhite removeFromSuperview];
    
    self.controlBlack = nil;
    self.viewWhite = nil;
}

//TableView展示
- (void)showTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor huibai];
    
    UIView *viewFoot = [[UIView alloc] init];
    
    if (self.decide == NO) {
        
        viewFoot.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130);
        
    } else {
        
        viewFoot.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 250);
    }
    
    viewFoot.backgroundColor = [UIColor huibai];
    self.tableView.tableFooterView = viewFoot;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CashMoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewMakeSureCell" bundle:nil] forCellReuseIdentifier:@"reuseNew"];
    
    UIButton *makeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (44.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (60.0 / 667.0), (WIDTH_CONTROLLER_DEFAULT - 80), HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"确认投资"];
    
    if (self.decide == NO) {
        
        [makeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [makeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    }
    
    makeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    [viewFoot addSubview:makeSure];
    [makeSure addTarget:self action:@selector(makeSureMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 110, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:buttonSafe];
    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
    
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
        
    } else if (section == 3) {
        
        return 30;
        
    } else {
        
        return 11;
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        
        UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor huibai]];
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(8, 0, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"提示:购买产品成功后,可拆开选择的红包"];
        [view addSubview:label];
        
        return view;
        
    } else {
        
        UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10) backgroundColor:[UIColor huibai]];
        return view;
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
    if (self.decide == NO) {
        
        return 3;
        
    } else {
        
        return 4;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.decide == NO) {
        
        return 1;
        
    } else {
        
        if (section == 2) {
            
            return 2;
            
        } else {
            
            return 1;
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        if (cell == nil) {
            
            cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        
        if (self.decide == NO) {
            
            cell.labelMonth.text = @"新手专享";
            
        } else {
            
            cell.labelMonth.text = @"3个月固定投资";
            
        }
        
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
        cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 53)];
        cell.textField.leftView.backgroundColor = [UIColor shurukuangColor];
        cell.textField.leftViewMode = UITextFieldViewModeAlways;
        cell.textField.tintColor = [UIColor yuanColor];
        cell.textField.tag = 199;
        
        if (self.decide == NO) {
            
            cell.textField.text = @"10,000";
            cell.textField.enabled = NO;
            
        } else {
            
            cell.textField.placeholder = @"请输入投资金额";
            
        }
        
        cell.textField.font = [UIFont systemFontOfSize:14];
        cell.textField.textColor = [UIColor zitihui];
        cell.textField.delegate = self;
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.layer.cornerRadius = 4;
        cell.textField.backgroundColor = [UIColor shurukuangColor];
        cell.textField.layer.borderWidth = 0.5;
        cell.textField.layer.borderColor = [[UIColor shurukuangBian] CGColor];
        
        cell.labelOneZi.text = @"元";
        cell.labelOneZi.font = [UIFont systemFontOfSize:14];
        cell.labelOneZi.textColor = [UIColor zitihui];
        cell.labelOneZi.backgroundColor = [UIColor clearColor];
        
        cell.labelShouRu.text = @"预计到期收益";
        cell.labelShouRu.font = [UIFont systemFontOfSize:15];
        
        if (self.decide == NO) {
            
            cell.labelYuan.text = @"5.00元";
            
        } else {
            
            cell.labelYuan.text = @"0.00元";
            
        }
        
        cell.labelYuan.font = [UIFont systemFontOfSize:15];
        cell.labelYuan.textColor = [UIColor daohanglan];
        
        cell.viewLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine1.alpha = 0.7;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 2) {
        
        if (self.decide == NO) {
            
            NewMakeSureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNew"];
            
            [cell.buttonLeft setTitle:@"新手体验金" forState:UIControlStateNormal];
            [cell.buttonLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell.buttonLeft setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
            cell.buttonLeft.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            cell.buttonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            cell.buttonLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            cell.labelRight.text = @"10,000元";
            cell.labelRight.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            cell.labelRight.textColor = [UIColor daohanglan];
            cell.labelRight.textAlignment = NSTextAlignmentRight;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            RedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
            
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
            
        }
        
        
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
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 1) {
            
            ChooseRedBagViewController *chooseVC = [[ChooseRedBagViewController alloc] init];
            [self.navigationController pushViewController:chooseVC animated:YES];
        }
    }
}

//充值按钮
- (void)cashMoneyButton:(UIButton *)button
{
    RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

//确认投资按钮
- (void)makeSureMoney:(UIButton *)button
{
    if (self.decide == NO) {
        
        CashFinishViewController *cashFinishVC = [[CashFinishViewController alloc] init];
        [self.navigationController pushViewController:cashFinishVC animated:YES];
        
    } else {
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        
        self.textFieldC = (UITextField *)[self.view viewWithTag:199];
        CGFloat numberInt = self.qianShu.text.intValue;
        CGFloat shuRuInt = self.textFieldC.text.intValue;
        
        if (shuRuInt > numberInt) {
            
            self.buttBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
            [app.tabBarVC.view addSubview:self.buttBlack];
            self.buttBlack.alpha = 0.3;
            [self.buttBlack addTarget:self action:@selector(buttonBlackRemove:) forControlEvents:UIControlEventTouchUpInside];
            
            self.viewBottom = [CreatView creatViewWithFrame:CGRectMake(50, (HEIGHT_CONTROLLER_DEFAULT - 20)/2 - 80, WIDTH_CONTROLLER_DEFAULT - 100, 160) backgroundColor:[UIColor whiteColor]];
            [app.tabBarVC.view addSubview:self.viewBottom];
            self.viewBottom.layer.cornerRadius = 3;
            self.viewBottom.layer.masksToBounds = YES;
            
            CGFloat viewWidth = self.viewBottom.frame.size.width;
            
            UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(0, 30, viewWidth, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont systemFontOfSize:15] text:@"您的余额不足,去充值?"];
            [self.viewBottom addSubview:label];
            
            UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, 90, (viewWidth - 50)/2, 40) backgroundColor:[UIColor colorWithRed:114.0 / 225.0 green:113.0 / 225.0 blue:111.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:@"取消"];
            [self.viewBottom addSubview:butCancle];
            butCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            butCancle.layer.cornerRadius = 3;
            butCancle.layer.masksToBounds = YES;
            [butCancle addTarget:self action:@selector(buttonBlackRemove:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *butDecide = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(butCancle.frame.size.width + 30, 90, (viewWidth - 50)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"确定"];
            [self.viewBottom addSubview:butDecide];
            butDecide.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            butDecide.layer.cornerRadius = 3;
            butDecide.layer.masksToBounds = YES;
            [butDecide addTarget:self action:@selector(decideCashMoney:) forControlEvents:UIControlEventTouchUpInside];
            
        } else {
            
            [self.controlBlack removeFromSuperview];
            [self.viewWhite removeFromSuperview];
            
            self.controlBlack = nil;
            self.viewWhite = nil;
            
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
                
                [self.viewWhite.buttonClose setImage:[UIImage imageNamed:@"iconfont_graycuo"] forState:UIControlStateNormal];
                [self.viewWhite.buttonClose addTarget:self action:@selector(controlBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
                
                self.viewWhite.labelLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
                self.viewWhite.labelLine.alpha = 0.7;
                
                self.viewWhite.labelSign.text = @"在购买<<新手专享>>前请您确认:";
                self.viewWhite.labelSign.font = [UIFont systemFontOfSize:15];
                self.viewWhite.labelSign.textColor = [UIColor zitihui];
                
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
        
    }
    
}

//余额足的情况下--黑色遮罩层&关闭按钮的触发事件
- (void)controlBlackDisappear:(UIControl *)control
{
    [self.controlBlack removeFromSuperview];
    [self.viewWhite removeFromSuperview];
    
    self.controlBlack = nil;
    self.viewWhite = nil;
}

//余额不足---黑色遮罩层
- (void)buttonBlackRemove:(UIButton *)button
{
    [self.buttBlack removeFromSuperview];
    [self.viewBottom removeFromSuperview];
    
    self.buttBlack = nil;
    self.viewBottom = nil;
}

//确定充值按钮
- (void)decideCashMoney:(UIButton *)button
{
    [self.buttBlack removeFromSuperview];
    [self.viewBottom removeFromSuperview];
    
    self.buttBlack = nil;
    self.viewBottom = nil;
    
    RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

//偏移量回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= 1) {
        
        self.textFieldC = (UITextField *)[self.view viewWithTag:199];
        [self.textFieldC resignFirstResponder];
    }
}

//确认投资按钮
- (void)buttonAffirmMoney:(UIButton *)button
{
    FBalancePaymentViewController *balanceVC = [[FBalancePaymentViewController alloc] init];
    [self.navigationController pushViewController:balanceVC animated:YES];
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
