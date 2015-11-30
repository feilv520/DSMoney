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
#import "RechargeAlreadyBinding.h"
#import "ChooseRedBagController.h"
#import "RedBagModel.h"
#import "ShareHaveRedBag.h"

@interface MakeSureViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>{
    RedBagModel *redbagModel;
}
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
@property (nonatomic) UIButton *makeSure;
@property (nonatomic) UIButton *buttonNew;

@property (nonatomic, strong) NSDictionary *accountDic;

@property (nonatomic, strong) NSMutableArray *redBagArray;

@end

@implementation MakeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.accountDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];;
    
    self.redBagArray = [NSMutableArray array];
    
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor huibai];
    
    UIView *viewFoot = [[UIView alloc] init];
    viewFoot.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (150.0 / 667.0));
    viewFoot.backgroundColor = [UIColor huibai];
    self.tableView.tableFooterView = viewFoot;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CashMoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewMakeSureCell" bundle:nil] forCellReuseIdentifier:@"reuseNew"];
    
    _makeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (40.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (60.0 / 667.0), (WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (80.0 / 375.0)), HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"确认投资"];
    
    if (self.decide == NO) {
        
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    }
    
    _makeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    [viewFoot addSubview:_makeSure];
    [_makeSure addTarget:self action:@selector(makeSureMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSafe = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (60.0 / 667.0) + HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0) + HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * 20.0 / 667.0) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:buttonSafe];
    buttonSafe.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    [buttonSafe setImage:[UIImage imageNamed:@"iocn_saft"] forState:UIControlStateNormal];
    
    self.qianShu = [[UILabel alloc] init];
    self.qianShu.font = [UIFont systemFontOfSize:15];
    
    self.labelJiGe = [[UILabel alloc] init];
    self.labelJiGe.font = [UIFont systemFontOfSize:15];
    
    self.imageViewRight = [[UIImageView alloc] init];
    
    self.buttonNew = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonNew setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.buttonNew.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendValuenotification:) name:@"sendValue" object:nil];
}

- (void)sendValuenotification:(NSNotification *)notice
{
    redbagModel = [notice object];
    self.labelJiGe.text = [NSString stringWithFormat:@"%@",[redbagModel rpTypeName]];
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
    return 4;
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
            
            cell.labelMonth.text = [self.detailM productName];
            
        }
        
        cell.labelMonth.font = [UIFont systemFontOfSize:15];
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.7;
        
        NSMutableAttributedString *year = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@%%", @"年化收益率", [self.detailM productAnnualYield]]];
        NSRange black = NSMakeRange(0, [[year string] rangeOfString:@":"].location);
        [year addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:black];
        [cell.labelYear setAttributedText:year];
        cell.labelYear.textColor = [UIColor zitihui];
        
        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@元", @"剩余总额", self.residueMoney]];
        NSRange moneyRange = NSMakeRange(0, [[moneyStr string] length]);
        [moneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:moneyRange];
        [cell.labelSheng setAttributedText:moneyStr];
        cell.labelSheng.textColor = [UIColor zitihui];
        
        NSMutableAttributedString *moneyS = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@元起投,每%@元递增", @"起投资金", [self.detailM amountMin],[self.detailM amountIncrease]]];
        NSRange Range = NSMakeRange(0, [[moneyS string] length]);
        [moneyS addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:Range];
        [cell.labelMoney setAttributedText:moneyS];
        cell.labelMoney.textColor = [UIColor zitihui];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 1) {
        
        MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        
        cell.labelMoney.text = @"投资金额";
        cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 53)];
        cell.textField.leftView.backgroundColor = [UIColor shurukuangColor];
        cell.textField.leftViewMode = UITextFieldViewModeAlways;
        cell.textField.tintColor = [UIColor yuanColor];
        cell.textField.tag = 199;
        cell.textField.delegate = self;
        [cell.textField addTarget:self action:@selector(textFieldEditShow:) forControlEvents:UIControlEventEditingChanged];
        
        if (self.decide == NO) {
            
            cell.textField.text = @"5000";
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
        
        [cell.textField addTarget:self action:@selector(ValueChanged:) forControlEvents:UIControlEventEditingChanged];
        
        cell.labelOneZi.text = @"元";
        cell.labelOneZi.font = [UIFont systemFontOfSize:14];
        cell.labelOneZi.textColor = [UIColor zitihui];
        cell.labelOneZi.backgroundColor = [UIColor clearColor];
        
        cell.labelShouRu.text = @"预计到期收益";
        cell.labelShouRu.font = [UIFont systemFontOfSize:15];
        
        cell.labelYuan.tag = 9898;
        
        if (self.decide == NO) {
            
            cell.labelYuan.text = [NSString stringWithFormat:@"%.2f%@",[cell.textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue] / 36000.0, @"元"];
            
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
            
            [cell.buttonLeft setTitle:@"我的红包" forState:UIControlStateNormal];
            [cell.buttonLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            cell.buttonLeft.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            cell.buttonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
//            self.labelJiGe.text = [NSString stringWithFormat:@"%@%@", [self.accountDic objectForKey:@"redPacket"], @"个"];
//            self.labelJiGe.textAlignment = NSTextAlignmentCenter;
//            self.labelJiGe.textAlignment = NSTextAlignmentRight;
//            self.labelJiGe.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 20 - 16 - 100, 0, 100, 48);
//            [cell addSubview:self.labelJiGe];
            
            self.imageViewRight.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 14, 16, 16, 16);
            self.imageViewRight.image = [UIImage imageNamed:@"7501111"];
            [cell addSubview:self.imageViewRight];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            RedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
            
            if (indexPath.row == 0) {
                
                [cell.butRecharge setTitle:@"充值" forState:UIControlStateNormal];
                cell.butRecharge.titleLabel.font = [UIFont systemFontOfSize:12];
                [cell.butRecharge setTitleColor:[UIColor chongzhiColor] forState:UIControlStateNormal];
                [cell.butRecharge addTarget:self action:@selector(cashMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
                
                self.qianShu.frame = CGRectMake(100, 0, WIDTH_CONTROLLER_DEFAULT - 110, 48);
                self.qianShu.text = [DES3Util decrypt:[self.accountDic objectForKey:@"accBalance"]];
                self.qianShu.textColor = [UIColor daohanglan];
                self.qianShu.textAlignment = NSTextAlignmentRight;
                [cell addSubview:self.qianShu];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            } else {
                
//                self.labelJiGe.text = [NSString stringWithFormat:@"%@%@", [self.accountDic objectForKey:@"redPacket"], @"个"];
//                self.labelJiGe.textAlignment = NSTextAlignmentCenter;
//                self.labelJiGe.textAlignment = NSTextAlignmentRight;
//                self.labelJiGe.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 20 - 16 - 100, 0, 100, 48);
//                [cell addSubview:self.labelJiGe];
                
                self.imageViewRight.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 14, 16, 16, 16);
                self.imageViewRight.image = [UIImage imageNamed:@"7501111"];
                [cell addSubview:self.imageViewRight];
            }
            
            cell.labelRedBag.text = [self.titleArr objectAtIndex:indexPath.row];
            cell.labelRedBag.font = [UIFont systemFontOfSize:15];
            
            return cell;
            
        }
        
        
    } else {
        
        CashMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
        
        cell.labelCash.text = @"支付金额";
        cell.labelCash.font = [UIFont systemFontOfSize:15];
        
        if (self.decide == NO) {
            
            cell.labelYuanShu.hidden = YES;
            self.buttonNew.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 20)/2 + 5, 12, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 20);
            [cell addSubview:self.buttonNew];
            [self.buttonNew setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
            self.buttonNew.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            
            NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"新手体验金5,000元"];
            NSRange LeftSange = NSMakeRange([[redStr string] length] - 6, 6);
            [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:LeftSange];
            [self.buttonNew setAttributedTitle:redStr forState:UIControlStateNormal];
            
        } else {
            
            cell.labelYuanShu.text = @"0.00元";
            cell.labelYuanShu.font = [UIFont systemFontOfSize:15];
            cell.labelYuanShu.textColor = [UIColor daohanglan];
            cell.labelYuanShu.textAlignment = NSTextAlignmentRight;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:199];
    
    if (indexPath.section == 2) {
        
        if (self.decide == NO) {
            
            if (indexPath.row == 0) {
                
                NSLog(@"%@-op-op-op-%@",textField.text,[self.detailM amountMin]);
                
                if (![textField.text isEqualToString:@""] && [textField.text floatValue] >= [[self.detailM amountMin] floatValue]) {
                    if ([textField.text floatValue] >= [[self.detailM minRedPacketMoney] floatValue]) {
                        ChooseRedBagController *chooseVC = [[ChooseRedBagController alloc] init];
                        chooseVC.buyMoney = textField.text;
                        chooseVC.days = [self.detailM productPeriod];
                        [self.navigationController pushViewController:chooseVC animated:YES];
                    } else {
                        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"没有可用的红包"];
                    }
                } else {
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入金额,大于起投金额"];
                }
                
            }
            
        } else {
            
            NSLog(@"%@-op-op-op-%@",textField.text,[self.detailM amountMin]);
            
            if (indexPath.row == 1) {
                
                if (![textField.text isEqualToString:@""] && [textField.text floatValue] >= [[self.detailM amountMin] floatValue]) {
                    if ([textField.text floatValue] >= [[self.detailM minRedPacketMoney] floatValue]) {
                        ChooseRedBagController *chooseVC = [[ChooseRedBagController alloc] init];
                        chooseVC.buyMoney = textField.text;
                        chooseVC.days = [self.detailM productPeriod];
                        [self.navigationController pushViewController:chooseVC animated:YES];
                    } else {
                        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"没有可用的红包"];
                    }
                } else {
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入金额,大于起投金额"];
                }
            }
            
        }
        
    }
}

- (void)textFieldEditShow:(UITextField *)textField
{
    self.textFieldC = (UITextField *)[self.view viewWithTag:199];
    
    if (self.textFieldC.text.length > 0) {
        
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else if ([self.textFieldC.text isEqualToString:@"0"]) {
        
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [_makeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _tableView.contentOffset = CGPointMake(0, 145);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    return YES;
}

//充值按钮
- (void)cashMoneyButton:(UIButton *)button
{
//    *********未绑定银行卡的充值页面*************
    RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
//    *********已经绑定银行卡的充值页面**************
//    RechargeAlreadyBinding *already = [[RechargeAlreadyBinding alloc] init];
//    [self.navigationController pushViewController:already animated:YES];
}

//确认投资按钮
- (void)makeSureMoney:(UIButton *)button
{
    [self getMyRedPacketList];
//    判断新手还是固收或银行票据
    if (self.decide == NO) {
        
        self.textFieldC = (UITextField *)[self.view viewWithTag:199];
        
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        NSDictionary *parameter;
        if ([redbagModel rpID] == nil) {
            parameter = @{@"productId":[self.detailM productId],@"packetId":@"",@"orderMoney":[NSNumber numberWithFloat:[self.textFieldC.text floatValue]],@"payMoney":@0,@"payType":@1,@"payPwd":@"",@"token":[dic objectForKey:@"token"]};
        } else {
            parameter = @{@"productId":[self.detailM productId],@"packetId":[redbagModel rpID],@"orderMoney":[NSNumber numberWithFloat:[self.textFieldC.text floatValue]],@"payMoney":@0,@"payType":@1,@"payPwd":@"",@"token":[dic objectForKey:@"token"]};
        }
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/buyProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"buyProduct = %@",responseObject);
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                if ([redbagModel rpID] == nil) {
    //              支付没有红包
                    CashFinishViewController *cashFinish = [[CashFinishViewController alloc] init];
                    cashFinish.nHand = self.nHand;
                    [self.navigationController pushViewController:cashFinish animated:YES];
                } else {
    //              支付有红包
                    ShareHaveRedBag *shareHave = [[ShareHaveRedBag alloc] init];
                    shareHave.redbagModel = redbagModel;
                    shareHave.nHand = self.nHand;
                    [self.navigationController pushViewController:shareHave animated:YES];
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"支付成功"];
                }
            } else {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@", error);
            
        }];
        
    } else {
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        
        self.textFieldC = (UITextField *)[self.view viewWithTag:199];
        CGFloat numberInt = [[[DES3Util decrypt:[self.accountDic objectForKey:@"accBalance"]] stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        CGFloat shuRuInt = self.textFieldC.text.floatValue;
        
//        NSLog(@"--- %@ ====--- %.f %.f",[[self.accountDic objectForKey:@"accBalance"] stringByReplacingOccurrencesOfString:@"," withString:@""],numberInt,shuRuInt);
        
//        当输入的值大于余额值 提示余额不足 是否充值
        if (shuRuInt > numberInt && shuRuInt != 0) {
        
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

//            当输入的值小于余额时 可以投资
        } else if (shuRuInt <= numberInt && shuRuInt != 0) {
            if (shuRuInt >= [[self.detailM amountMin] floatValue]) {
                if ([redbagModel rpID] != nil) {
                    [self showSureView:app];
                } else {
                    if (self.redBagArray.count == 0) {
                        [self showSureView:app];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你还有未使用的红包,要不要去看看?" delegate:self cancelButtonTitle:@"拒绝去看" otherButtonTitles:@"去看看",nil];
                        // optional - add more buttons:
                        [alert show];
                    }
                }
            } else {
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"投资金额要大于起投金额"];
            }
        }
    }
}

- (void)showSureView:(AppDelegate *)app{
    
    self.controlBlack = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    [app.tabBarVC.view addSubview:self.controlBlack];
    self.controlBlack.backgroundColor = [UIColor blackColor];
    self.controlBlack.alpha = 0.3;
    [self.controlBlack addTarget:self action:@selector(controlBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    self.viewWhite = (FConfirmMoney *)[[rootBundle loadNibNamed:@"FConfirmMoney" owner:nil options:nil] lastObject];
    
    self.viewWhite.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 300)/2, (HEIGHT_CONTROLLER_DEFAULT - 20 - 64)/2 - 120, 301, 300);
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
    
    self.viewWhite.labelBook.textColor = [UIColor zitihui];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"本人已仔细阅读/理解该收益权产品\n<<购买条款>>、<<收益权转让协议>>全文,并愿意自行承担投资风险"];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor chongzhiColor] range:[@"本人已仔细阅读/理解该收益权产品\n<<购买条款>>、<<收益权转让协议>>全文,并愿意自行承担投资风险"rangeOfString:@"<<购买条款>>、<<收益权转让协议>>"]];
    [self.viewWhite.labelBook setAttributedText:attStr];
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

#pragma mark alertView 的 代理方法
#pragma mark --------------------------------

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.textFieldC = (UITextField *)[self.view viewWithTag:199];
    if (buttonIndex == 0) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [self showSureView:app];
    } else {
        ChooseRedBagController *chooseVC = [[ChooseRedBagController alloc] init];
        chooseVC.buyMoney = self.textFieldC.text;
        chooseVC.days = [self.detailM productPeriod];
        [self.navigationController pushViewController:chooseVC animated:YES];
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
    if (scrollView.contentOffset.y != 0) {
        [self getMyRedPacketList];
        self.textFieldC = (UITextField *)[self.view viewWithTag:199];
        [self.textFieldC resignFirstResponder];
    }
}

//确认投资按钮
- (void)buttonAffirmMoney:(UIButton *)button
{
    UITextField *textField = (UITextField *)[self.view viewWithTag:199];
    FBalancePaymentViewController *balanceVC = [[FBalancePaymentViewController alloc] init];
    balanceVC.productName = [self.detailM productName];
    balanceVC.idString = [self.detailM productId];
    balanceVC.moneyString = textField.text;
    balanceVC.typeString = [self.detailM productType];
    balanceVC.redbagModel = redbagModel;
    balanceVC.nHand = self.nHand;
    [self.navigationController pushViewController:balanceVC animated:YES];
}

#pragma mark textField 的监控方法
#pragma mark --------------------------------

- (void)ValueChanged:(UITextField *)textField{
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:3];
    MoneyCell *cell = (MoneyCell *)[self.tableView cellForRowAtIndexPath:path];
    CashMoneyCell *cell1 = (CashMoneyCell *)[self.tableView cellForRowAtIndexPath:path1];
    cell.labelYuan.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue] / 36000.0];
    cell1.labelYuanShu.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue]];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 10) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyRedPacketList{
    if (self.textFieldC == nil) {
        return;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"],@"buyMoney":self.textFieldC.text,@"days":[self.detailM productPeriod]};
    
    NSLog(@"getMyRedPacketList parameter = %@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/redpacket/getUserRedPacketRandList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyRedPacketList = %@",responseObject);
        
        self.redBagArray = [responseObject objectForKey:@"RedPacket"];
        
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
