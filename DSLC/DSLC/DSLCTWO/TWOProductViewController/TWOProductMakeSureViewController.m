//
//  TWOProductMakeSureViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/11.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductMakeSureViewController.h"
#import "TWOMakeSureTableViewCell.h"
#import "TWOProductDetailTableViewCell.h"
#import "ChongZhiViewController.h"
#import "TWOProductMakeSureHeadView.h"
#import "TWOProductMakeSureTwoTableViewCell.h"
#import "TWOProductMakeSureThreeTableViewCell.h"
#import "TWOProductPaySuccessViewController.h"
#import "TWOProductMMakeSureView.h"
#import "TWOProductMonkeyView.h"
#import "TWOUseRedBagViewController.h"
#import "TWOUseTicketViewController.h"
#import "TWOProductHuiFuViewController.h"
#import "TWOMoneyMoreViewController.h"
#import "TWORedBagModel.h"
#import "TWOJiaXiQuanModel.h"

@interface TWOProductMakeSureViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    
    NSDictionary *accountDic;
    
    NSString *allMoneyString;//投资金额
    NSString *redPackString;//红包金额
    NSString *qDayString;//起息日
    NSString *dDayString;//到期日
    NSString *syString;//收益
    NSString *monkeyString;//得到猴币数量
    
    UIView *sureView;
    
    UIButton *bView;
    
    UIButton *doneButton;
    
    TWOProductMMakeSureView *makeSView;
    
    TWOProductMonkeyView *monkeyView;
    
    MBProgressHUD *hud;
    
    NSArray *redPackCount;
    NSArray *increaseCount;
    
    // 选中的红包id
    TWORedBagModel *packetModel;
    // 选中的加息卷
    TWOJiaXiQuanModel *incrModel;
}

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TWOProductMakeSureViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    sureView.hidden = NO;
    
    sureView.hidden = NO;
    
    makeSView.hidden = NO;
    
    monkeyView.hidden = NO;
    
    doneButton.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDoneButtonToNumPadKeyboard:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    [self.navigationItem setTitle:@"投资"];
    
    [self showTableView];
    
    [self setSureView];
    
    [self getMyRedPacketList];
    [self getMyIncreaseList];
    
    redPackString = @"0";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keywordboardHide) name:UIKeyboardWillHideNotification object:nil];
    
    qDayString = [self.detailM beginTime];
    dDayString = [self.detailM endTime];
    syString = @"0元";
    monkeyString = @"0个";
    allMoneyString = @"0元";
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    sureView.hidden = YES;
    
    sureView.hidden = YES;
    
    doneButton.hidden = YES;
    
    [bView removeFromSuperview];
    [makeSView removeFromSuperview];
    [monkeyView removeFromSuperview];
    
    bView = nil;
    makeSView = nil;
    monkeyView = nil;
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

// 创建TableView
- (void)showTableView{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStyleGrouped];
    
    self.mainTableView.backgroundColor = Color_Gray;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TWOMakeSureTableViewCell" bundle:nil] forCellReuseIdentifier:@"reusef"];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TWOProductMakeSureTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseTwo"];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TWOProductDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TWOProductMakeSureThreeTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseThree"];
    
    [self tableViewHeadShow];
    
    [self.view addSubview:self.mainTableView];
}

- (void)tableViewHeadShow{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    TWOProductMakeSureHeadView *makeSureHView = (TWOProductMakeSureHeadView *)[[rootBundle loadNibNamed:@"TWOProductMakeSureHeadView" owner:nil options:nil] lastObject];
    makeSureHView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 220);
    self.mainTableView.tableHeaderView = makeSureHView;
    
    makeSureHView.productName.text = [self.detailM productName];
    
    // 预期年化收益
    NSMutableAttributedString *yqString = [[NSMutableAttributedString alloc] initWithString:@"13.17%"];
    [yqString replaceCharactersInRange:NSMakeRange(0, [[yqString string] rangeOfString:@"%"].location) withString:[NSString stringWithFormat:@"%@",[self.detailM productAnnualYield]]];
    NSRange numYString = NSMakeRange(0, [[yqString string] rangeOfString:@"%"].location);
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        [yqString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:21] range:numYString];
        NSRange oneString = NSMakeRange([[yqString string] length] - 1, 1);
        [yqString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:oneString];
        
    } else {
        [yqString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:numYString];
        NSRange oneString = NSMakeRange([[yqString string] length] - 1, 1);
        [yqString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:oneString];
    }
    [makeSureHView.yqBFLabel setAttributedText:yqString];
    
    // 剩余可投
    NSMutableAttributedString *residueString = [[NSMutableAttributedString alloc] initWithString:@"13.17元"];
    
    CGFloat residueMoney = [self.residueMoney floatValue];
    
    if (residueMoney / 10000.0 > 0){
        
        residueMoney /= 10000.0;
        
        [residueString replaceCharactersInRange:NSMakeRange(0, [[residueString string] rangeOfString:@"元"].location) withString:[NSString stringWithFormat:@"%.2lf万",residueMoney]];
        
        NSRange numRString = NSMakeRange(0, [[residueString string] rangeOfString:@"万"].location);
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:21] range:numRString];
            NSRange oneString = NSMakeRange([[residueString string] length] - 2, 2);
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:oneString];
            
        } else {
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:numRString];
            NSRange oneString = NSMakeRange([[residueString string] length] - 2, 2);
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:oneString];
        }
        
    } else {
        
        [residueString replaceCharactersInRange:NSMakeRange(0, [[residueString string] rangeOfString:@"元"].location) withString:[NSString stringWithFormat:@"%@",self.residueMoney]];
        
        NSRange numRString = NSMakeRange(0, [[residueString string] rangeOfString:@"元"].location);
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:21] range:numRString];
            NSRange oneString = NSMakeRange([[residueString string] length] - 1, 1);
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:oneString];
            
        } else {
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:numRString];
            NSRange oneString = NSMakeRange([[residueString string] length] - 1, 1);
            [residueString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:oneString];
        }
    }
    
    [makeSureHView.rMoneyLabel setAttributedText:residueString];
    
    // 理财期限
    NSMutableAttributedString *dayString = [[NSMutableAttributedString alloc] initWithString:@"13.17天"];
    [dayString replaceCharactersInRange:NSMakeRange(0, [[dayString string] rangeOfString:@"天"].location) withString:[NSString stringWithFormat:@"%@",[self.detailM productPeriod]]];
    NSRange numDString = NSMakeRange(0, [[dayString string] rangeOfString:@"天"].location);
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:21] range:numDString];
        NSRange oneString = NSMakeRange([[dayString string] length] - 1, 1);
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:oneString];
        
    } else {
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:numDString];
        NSRange oneString = NSMakeRange([[dayString string] length] - 1, 1);
        [dayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:oneString];
    }
    [makeSureHView.dayLabel setAttributedText:dayString];
    
}

- (void)setSureView{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    sureView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 78, WIDTH_CONTROLLER_DEFAULT, 58)];
    
    sureView.backgroundColor = Color_White;
    
    [app.window addSubview:sureView];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    sureButton.tag = 9574;
    
    sureButton.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 40);
    
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [sureButton setBackgroundColor:[UIColor findZiTiColor]];
    
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    sureButton.enabled = NO;
    
    [sureView addSubview:sureButton];
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
    if (indexPath.section == 0) {
        if ([[self.detailM.productType description] isEqualToString:@"3"]){
            
            return 100;
        } else if ([[self.detailM.productType description] isEqualToString:@"1"] || ([[self.detailM.productType description] isEqualToString:@"3"] && [[self.detailM.productName description] containsString:@"美猴王"])) {
            
            return 150;
        } else {
            
            return 200;
        }
    } else {
        
        return 50;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([[self.detailM.productType description] isEqualToString:@"3"]){
        return 1;
    } else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 1;
    } else {
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if ([[self.detailM.productType description] isEqualToString:@"3"]){
            
            UIButton *sureButton = (UIButton *)[sureView viewWithTag:9574];
            
            sureButton.backgroundColor = [UIColor profitColor];
            sureButton.enabled = YES;
            
            TWOProductMakeSureThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseThree"];
            
            [cell.inputMoneyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
            
            cell.inputMoneyTextField.tag = 9283;
            
            cell.inputMoneyTextField.delegate = self;
            
//            cell.inputMoneyTextField.placeholder = [NSString stringWithFormat:@"%@元起投,每%@元递增",[self.detailM amountMin],[self.detailM amountIncrease]];
            
            cell.inputMoneyTextField.text = @"5000";
            
            cell.inputMoneyTextField.enabled = NO;
            
            cell.yqMoneyLabel.text = @"4.93元";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        } else if ([[self.detailM.productType description] isEqualToString:@"1"] || ([[self.detailM.productType description] isEqualToString:@"3"] && [[self.detailM.productName description] containsString:@"美猴王"])) {
            
            TWOMakeSureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusef"];
            
            accountDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
            
            if ([accountDic objectForKey:@"accBalance"] == nil){
                
                cell.moneyLabel.text = @"0元";
            } else {
                
                cell.moneyLabel.text = [NSString stringWithFormat:@"%@元",[DES3Util decrypt:[accountDic objectForKey:@"accBalance"]]];
            }
            
            [cell.czButton addTarget:self action:@selector(czAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.inputMoneyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
            
            cell.inputMoneyTextField.tag = 9283;
            
            cell.inputMoneyTextField.delegate = self;
            
            cell.inputMoneyTextField.placeholder = [NSString stringWithFormat:@"%d元起投,每%d元递增",[[self.detailM amountMin] intValue],[[self.detailM amountIncrease] intValue]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        } else {
            
            TWOProductMakeSureTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseTwo"];
            
            accountDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
            
            if ([accountDic objectForKey:@"accBalance"] == nil){
                
                cell.accountMoney.text = @"0元";
            } else {
                
                cell.accountMoney.text = [NSString stringWithFormat:@"%@元",[DES3Util decrypt:[accountDic objectForKey:@"accBalance"]]];
            }
            
            cell.residueLabel.text = [NSString stringWithFormat:@"%@元",@"0"];
            
            [cell.czButton addTarget:self action:@selector(czAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.upMoneyButton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.upMoneyButton.hidden = YES;
            
            [cell.moneyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
            
            cell.moneyTextField.tag = 9283;
            
            cell.moneyTextField.placeholder = [NSString stringWithFormat:@"%d元起投,每%d元递增",[[self.detailM amountMin] intValue],[[self.detailM amountIncrease] intValue]];
            
            cell.moneyTextField.delegate = self;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }
        
        
    } else {
        
        TWOProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.valueLabel.hidden = YES;
        cell.rightButton.hidden = NO;
        cell.rjLabel.hidden = NO;
        if (indexPath.row == 0) {
            
            cell.titleLabel.text = @"使用红包";
            
            if (redPackCount.count == 0) {
                
                cell.rjLabel.text = @"暂无可使用红包";
                cell.rjLabel.textColor = [UIColor findZiTiColor];
            } else {
                if (packetModel == nil) {
                    cell.rjLabel.text = [NSString stringWithFormat:@"%ld个",(long)redPackCount.count];
                    cell.rjLabel.textColor = [UIColor orangecolor];
                } else {
                    cell.rjLabel.text = [NSString stringWithFormat:@"已选%@元",[packetModel redPacketMoney]];
                    cell.rjLabel.textColor = [UIColor orangecolor];
                }
            }
        } else {
            
            cell.titleLabel.text = @"使用加息卷";
            if (increaseCount.count == 0) {
                
                cell.rjLabel.text = @"暂无可使用加息卷";
                cell.rjLabel.textColor = [UIColor findZiTiColor];
            } else {
                if (incrModel == nil) {
                    cell.rjLabel.text = [NSString stringWithFormat:@"%ld个",(long)increaseCount.count];
                    cell.rjLabel.textColor = [UIColor orangecolor];
                } else {
                    cell.rjLabel.text = [NSString stringWithFormat:@"已选%@%%",[incrModel incrMoney]];
                    cell.rjLabel.textColor = [UIColor orangecolor];
                }
            }
        }
        
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:9283];
    
    if ([textField.text isEqualToString:@""]){
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入投资金额"];
        return;
    }
    
    NSInteger number = [textField.text integerValue] % [[self.detailM amountIncrease] integerValue];
    
    textField.text = [NSString stringWithFormat:@"%ld",[textField.text integerValue] - number];
    
    allMoneyString = textField.text;
    
    [self textFieldEditChanged:textField];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            if (redPackCount.count == 0) {
                return;
            }
            
            TWOUseRedBagViewController *useRedBagVC = [[TWOUseRedBagViewController alloc] init];
            useRedBagVC.proPeriod = [self.detailM productPeriod];
            useRedBagVC.transMoney = allMoneyString;
            
            [useRedBagVC returnText:^(TWORedBagModel *model) {
                NSLog(@"packetId = %@",model);
                
                packetModel = [[TWORedBagModel alloc] init];
                
                packetModel = model;
                
                redPackString = [packetModel redPacketMoney];
                
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
            pushVC(useRedBagVC);
        } else {
            
            if (increaseCount.count == 0) {
                return;
            }
            
            TWOUseTicketViewController *useTicketVC = [[TWOUseTicketViewController alloc] init];
            useTicketVC.proPeriod = [self.detailM productPeriod];
            useTicketVC.transMoney = allMoneyString;
            
            [useTicketVC returnText:^(TWOJiaXiQuanModel *model) {
                NSLog(@"incrID = %@",model);
                
                incrModel = [[TWOJiaXiQuanModel alloc] init];
                
                incrModel = model;
                
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
            pushVC(useTicketVC);
        }
    }
}

// 充值按钮
- (void)czAction:(id)sender{
    
    TWOMoneyMoreViewController *moneyMoreVC = [[TWOMoneyMoreViewController alloc] init];
    pushVC(moneyMoreVC);
}

// 去提升
- (void)upAction:(id)sender{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        self.mainTableView.scrollEnabled = NO;
    } else {
        self.mainTableView.scrollEnabled = YES;
        [self.view endEditing:YES];
        
        UITextField *textField = (UITextField *)[self.view viewWithTag:9283];
        
        if ([textField.text isEqualToString:@""]){
            return;
        }
        
        NSInteger number = [textField.text integerValue] % [[self.detailM amountIncrease] integerValue];
        
        textField.text = [NSString stringWithFormat:@"%ld",[textField.text integerValue] - number];
        
        allMoneyString = textField.text;
        
        [self textFieldEditChanged:textField];
    }
}

#pragma mark textfiled代理方法
#pragma mark --------------------------------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 19) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

//textField绑定方法
- (void)textFieldEditChanged:(UITextField *)textField
{
    
    UIButton *sureButton = (UIButton *)[sureView viewWithTag:9574];
    
    if (textField.text.length == 0) {
        sureButton.backgroundColor = [UIColor findZiTiColor];
        sureButton.enabled = NO;
    } else if (textField.text.length > 0) {
        sureButton.backgroundColor = [UIColor profitColor];
        sureButton.enabled = YES;
    }
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    if ([[self.detailM.productType description] isEqualToString:@"3"]){
        
        TWOProductMakeSureThreeTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        cell.yqMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod] floatValue] / 36500.0];
        
        syString = cell.yqMoneyLabel.text;
        
    } else if ([[self.detailM.productType description] isEqualToString:@"1"] || ([[self.detailM.productType description] isEqualToString:@"3"] && [self.detailM.productName containsString:@"美猴王"])) {
        
        TWOMakeSureTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        cell.yqMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod] floatValue] / 36500.0];
        
        syString = cell.yqMoneyLabel.text;
        
        NSInteger number = [textField.text integerValue] % [[self.detailM amountIncrease] integerValue];
        
        allMoneyString = [NSString stringWithFormat:@"%ld",[textField.text integerValue] - number];
        
    } else {
        
        TWOProductMakeSureTwoTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        cell.yqSLabel.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod] floatValue] / 36500.0];
        
        syString = cell.yqSLabel.text;
        
        NSInteger number = [textField.text integerValue] % [[self.detailM amountIncrease] integerValue];
        
        allMoneyString = [NSString stringWithFormat:@"%ld",[textField.text integerValue] - number];
    }
    
    monkeyString = @"0个";
    
}

// 确认按钮
- (void)sureAction:(id)sender{
    
    [self.view endEditing:YES];

    UITextField *textField = (UITextField *)[self.view viewWithTag:9283];
    
    if ([textField.text isEqualToString:@""]){
        return;
    }
    
    NSInteger number = [textField.text integerValue] % [[self.detailM amountIncrease] integerValue];
    
    textField.text = [NSString stringWithFormat:@"%ld",[textField.text integerValue] - number];
    
    allMoneyString = textField.text;
    
    [self textFieldEditChanged:textField];
    
    if ([[self.detailM amountMin] floatValue] > [allMoneyString floatValue]){
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"你的投资金额不满足起投金额,请重新输入!"];
        return;
    }
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    bView = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:Color_Black textColor:nil titleText:nil];
    
    bView.alpha = 0.3;
    [bView addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [app.window addSubview:bView];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    makeSView = [[mainBundle loadNibNamed:@"TWOProductMMakeSureView" owner:nil options:nil] lastObject];
    
    monkeyView = [[mainBundle loadNibNamed:@"TWOProductMonkeyView" owner:nil options:nil] lastObject];
    
    CGFloat margin_x = (38 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
    CGFloat margin_y = (182 / 667.0) * HEIGHT_CONTROLLER_DEFAULT;
    CGFloat width = (301 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320.0) {
        margin_y -= 30;
    }
    
    makeSView.frame = CGRectMake(margin_x, margin_y, width, 230);
    makeSView.layer.masksToBounds = YES;
    makeSView.layer.cornerRadius = 4.0;
    
    monkeyView.frame = CGRectMake(margin_x, margin_y, width, 190);
    monkeyView.layer.masksToBounds = YES;
    monkeyView.layer.cornerRadius = 4.0;
    
    makeSView.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@",allMoneyString];
    makeSView.kMoneyLabel.text = [NSString stringWithFormat:@"-¥%@",redPackString];
    allMoneyString = [NSString stringWithFormat:@"%ld",[allMoneyString integerValue] - [redPackString integerValue]];
    makeSView.zMoneyLabel.text = [NSString stringWithFormat:@"¥%@",allMoneyString];
    
    monkeyView.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@",allMoneyString];
    monkeyView.zMoneyLabel.text = [NSString stringWithFormat:@"¥%@",allMoneyString];
    
    if ([[self.detailM.productType description] isEqualToString:@"3"]){
    
        [app.window addSubview:monkeyView];
    } else {
        
        [app.window addSubview:makeSView];
    }
    
    [makeSView.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [makeSView.sureButton addTarget:self action:@selector(sureBAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [monkeyView.closeButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [monkeyView.sureButton addTarget:self action:@selector(sureBAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 添加完成按钮
#pragma mark --------------------------------

- (void)addDoneButtonToNumPadKeyboard:(NSNotification*)Not
{
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 73, 122, 53);
    doneButton.tag = 8293;
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self performSelector:@selector(addDoneButton) withObject:nil afterDelay:0.32f];
    
}

- (void) addDoneButton{
    //获得键盘所在的window视图
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [tempWindow addSubview:doneButton];    // 注意这里直接加到window上
    
}

//键盘隐藏
- (void)keywordboardHide{
    if (doneButton.superview){
        //从视图中移除掉
        [doneButton removeFromSuperview];
        doneButton = nil;
    }
}

//完成方法
- (void)doneButton:(id)sender{
    [self.view endEditing:YES];
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:9283];
    
    if ([textField.text isEqualToString:@""]){
        return;
    }
    
    NSInteger number = [textField.text integerValue] % [[self.detailM amountIncrease] integerValue];
    
    textField.text = [NSString stringWithFormat:@"%ld",[textField.text integerValue] - number];
    
    allMoneyString = textField.text;
    
    [self textFieldEditChanged:textField];
}

//关闭按钮
- (void)closeButton:(UIButton *)but{
    
    [bView removeFromSuperview];
    [makeSView removeFromSuperview];
    [monkeyView removeFromSuperview];
    
    bView = nil;
    makeSView = nil;
    monkeyView = nil;
}

// 提示框确认按钮
- (void)sureBAction:(id)sender{
    
    if ([[self.detailM.productType description] isEqualToString:@"3"]) {
        
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        
        hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
        
        NSDictionary *memberDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"member.plist"]];
        
        NSString *signString = [NSString stringWithFormat:@"%@%@%@%@%@",[memberDic objectForKey:@"token"],[[self.detailM productId] description],[allMoneyString description],@"1",@"iOS"];
        
        NSString *md5SignString = [NSString md5String:signString];
        
        NSLog(@"md5SignString = %@",md5SignString);
        
        NSDictionary *parameter = @{@"productId":[self.detailM productId],@"orderMoney":allMoneyString,@"payType":@"1",@"clientType":@"iOS",@"token":[memberDic objectForKey:@"token"],@"sign":md5SignString};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"trade/buyNewHandProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"产品详情ppppppppppppppp%@",responseObject);
            
            [hud hide:YES];
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                TWOProductPaySuccessViewController *paySuccessVC = [[TWOProductPaySuccessViewController alloc] init];
                paySuccessVC.allMoneyString = allMoneyString;
                paySuccessVC.syString = syString;
                paySuccessVC.qDayString = qDayString;
                paySuccessVC.dDayString = dDayString;
                paySuccessVC.monkeyString = monkeyString;
                pushVC(paySuccessVC);
            } else {
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@", error);
            
        }];

    } else {
        
        NSString *redPackIdString = @"0";
        NSString *incrIdString = @"0";
        
        if (packetModel != nil) {
            redPackIdString = [packetModel redPacketId];
        }
        
        if (incrModel != nil) {
            incrIdString = [incrModel incrId];
        }
        
        NSString *signString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[self.flagDic objectForKey:@"token"],[[self.detailM productId] description],[allMoneyString description],@"1",redPackIdString,incrIdString,@"iOS"];
        
        NSString *md5SignString = [NSString md5String:signString];
        
        TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
        productHuiFuVC.fuctionName = @"trade/chinaPnrTrade";
        
        productHuiFuVC.tradeString = [NSString stringWithFormat:@"productId=%@&packetId=%@&incrId=%@&orderMoney=%@&payType=1&clientType=iOS&token=%@&sign=%@",[[self.detailM productId] description],redPackIdString,incrIdString,[allMoneyString description],[self.flagDic objectForKey:@"token"],md5SignString];
        pushVC(productHuiFuVC);
    }
    
    
}

- (void)getMyRedPacketList{
    
    NSDictionary *parmeter = @{@"curPage":@1,@"status":@0,@"proPeriod":[self.detailM productPeriod],@"transMoney":@"100",@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyRedPacketList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyRedPacketList = %@",responseObject);
        
        redPackCount = [responseObject objectForKey:@"RedPacket"];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.mainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)getMyIncreaseList{
    
    NSDictionary *parmeter = @{@"curPage":@1,@"status":@0,@"proPeriod":[self.detailM productPeriod],@"transMoney":@"100",@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyIncreaseList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyIncreaseList = %@",responseObject);
        
        increaseCount = [responseObject objectForKey:@"Increase"];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.mainTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

        
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
