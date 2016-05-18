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

@interface TWOProductMakeSureViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    
    NSDictionary *accountDic;
    
    NSString *allMoneyString;//投资金额
    NSString *qDayString;//起息日
    NSString *dDayString;//到期日
    NSString *syString;//收益
    NSString *monkeyString;//得到猴币数量
    
    UIView *sureView;
    
    UIButton *bView;
    
    UIButton *doneButton;
    
    TWOProductMMakeSureView *makeSView;
    
    TWOProductMonkeyView *monkeyView;
}

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TWOProductMakeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    [self.navigationItem setTitle:@"投资"];
    
    [self showTableView];
    
    [self setSureView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDoneButtonToNumPadKeyboard) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keywordboardHide) name:UIKeyboardWillHideNotification object:nil];
    
    qDayString = [self.detailM beginTime];
    dDayString = [self.detailM endTime];
    syString = @"0元";
    monkeyString = @"0个";
    allMoneyString = @"0元";
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [sureView removeFromSuperview];
    sureView = nil;
    
    [bView removeFromSuperview];
    bView = nil;
    
    [makeSView removeFromSuperview];
    makeSView = nil;
    
    [monkeyView removeFromSuperview];
    monkeyView = nil;
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
    
    sureButton.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 40);
    
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [sureButton setBackgroundImage:[UIImage imageNamed:@"productSureButton"] forState:UIControlStateNormal];
    
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
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
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([self.detailM.productName containsString:@"新手"]){
            
            return 100;
        } else if ([self.detailM.productType isEqualToString:@"1"] || ([self.detailM.productType isEqualToString:@"3"] && [self.detailM.productName containsString:@"美猴王"])) {
            
            return 150;
        } else {
            
            return 200;
        }
    } else {
        
        return 50;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.detailM.productName containsString:@"新手"]){
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
        
        if ([self.detailM.productName containsString:@"新手"]){
            
            TWOProductMakeSureThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseThree"];
            
            [cell.inputMoneyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
            
            cell.inputMoneyTextField.delegate = self;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        } else if ([self.detailM.productType isEqualToString:@"1"] || ([self.detailM.productType isEqualToString:@"3"] && [self.detailM.productName containsString:@"美猴王"])) {
            
            TWOMakeSureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusef"];
            
            accountDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
            
            if ([accountDic objectForKey:@"accBalance"] == nil){
                
                cell.moneyLabel.text = @"100000000元";
            } else {
                
                cell.moneyLabel.text = [NSString stringWithFormat:@"%@",[DES3Util decrypt:[accountDic objectForKey:@"accBalance"]]];
            }
            
            [cell.czButton addTarget:self action:@selector(czAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.inputMoneyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
            
            cell.inputMoneyTextField.delegate = self;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        } else {
            
            TWOProductMakeSureTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseTwo"];
            
            accountDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
            
            if ([accountDic objectForKey:@"accBalance"] == nil){
                
                cell.accountMoney.text = @"100000000元";
            } else {
                
                cell.accountMoney.text = [NSString stringWithFormat:@"%@元",[DES3Util decrypt:[accountDic objectForKey:@"accBalance"]]];
            }
            
            cell.residueLabel.text = [NSString stringWithFormat:@"%@元",@"0"];
            
            [cell.czButton addTarget:self action:@selector(czAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.upMoneyButton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.moneyTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
            
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
            cell.rjLabel.text = @"暂无可使用红包";
        } else {
            
            cell.titleLabel.text = @"使用加息卷";
            cell.rjLabel.text = @"0张";
            cell.rjLabel.textColor = [UIColor orangecolor];
        }
        
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

// 充值按钮
- (void)czAction:(id)sender{
    
    ChongZhiViewController *czVC = [[ChongZhiViewController alloc] init];
    pushVC(czVC);
}

// 去提升
- (void)upAction:(id)sender{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        self.mainTableView.scrollEnabled = NO;
    } else {
        self.mainTableView.scrollEnabled = YES;
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
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    if ([self.detailM.productName containsString:@"新手"]){
        
        TWOProductMakeSureThreeTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        cell.yqMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue] / 36500.0];
        
        syString = cell.yqMoneyLabel.text;
        
    } else if ([self.detailM.productType isEqualToString:@"1"] || ([self.detailM.productType isEqualToString:@"3"] && [self.detailM.productName containsString:@"美猴王"])) {
        
        TWOMakeSureTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        cell.yqMoneyLabel.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue] / 36500.0];
        
        syString = cell.yqMoneyLabel.text;
        
    } else {
        
        TWOProductMakeSureTwoTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        
        cell.yqSLabel.text = [NSString stringWithFormat:@"%.2f元",[textField.text floatValue] * [[self.detailM productAnnualYield] floatValue] * [[self.detailM productPeriod]floatValue] / 36500.0];
        
        syString = cell.yqSLabel.text;
    }
    
    allMoneyString = textField.text;
    monkeyString = @"0个";
    
}

// 确认按钮
- (void)sureAction:(id)sender{
    
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
//    makeSView.kMoneyLabel.text = [NSString stringWithFormat:@"-¥%@",]
//    makeSView.zMoneyLabel.text = [NSString stringWithFormat:@"¥%@"]
    
    monkeyView.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@",allMoneyString];
    monkeyView.zMoneyLabel.text = [NSString stringWithFormat:@"¥%@",allMoneyString];
    
    if ([self.detailM.productName containsString:@"新手"]){
    
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

- (void)addDoneButtonToNumPadKeyboard
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

// 确认按钮
- (void)sureBAction:(id)sender{
    
    TWOProductPaySuccessViewController *paySuccessVC = [[TWOProductPaySuccessViewController alloc] init];
    paySuccessVC.allMoneyString = allMoneyString;
    paySuccessVC.syString = syString;
    paySuccessVC.qDayString = qDayString;
    paySuccessVC.dDayString = dDayString;
    paySuccessVC.monkeyString = monkeyString;
    pushVC(paySuccessVC);
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
